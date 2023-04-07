import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/domain/extensions/stream_extensions.dart';
import '../../../../../core/presentation/mixins/disposable_cubit.dart';
import '../../../../star_wars_api/domain/models/star_wars_character.dart';
import '../../../../star_wars_api/domain/star_wars_favorites_usecases.dart';
import 'people_list_router.dart';

part 'people_list_cubit.freezed.dart';

class PeopleListCubit extends Cubit<PeopleListState> with DisposableCubit {
  PeopleListCubit({
    required StarWarsFavoritesUseCases starWarsFavs,
    required PeopleListRouter router,
  })  : _starWarsFavs = starWarsFavs,
        _router = router,
        super(PeopleListState()) {
    _init();
  }

  final StarWarsFavoritesUseCases _starWarsFavs;
  final PeopleListRouter _router;

  @override
  Future<void> close() {
    disposeAll();
    return super.close();
  }

  void _init() {
    emit(state.copyWith(isLoading: true));
    getPeople();
  }

  void getPeople() {
    _starWarsFavs
        .getPeople(
          page: state.paginationCursor,
        )
        .listen(
          (PaginatedStarWarsFavCharacters pagination) => emit(
            state.copyWith(
              paginationCursor: pagination.next,
              peopleList: [
                ...state.peopleList,
                ...pagination.characters,
              ],
            ),
          ),
          onError: (_) {},
          onDone: () => emit(
            state.copyWith(
              isLoading: false,
              isBottomLoading: false,
            ),
          ),
        )
        .dispose(this);
  }

  void fetchMoreData() {
    emit(state.copyWith(isBottomLoading: true));
    getPeople();
  }

  void navigateToDetail(StarWarsFavCharacter item) {
    _router.navigateToDetail(item).then((result) {
      if (result == null) {
        return;
      }
      final String url = result.url;
      final bool isInFavsList = _starWarsFavs.isInFavList(url);

      if (isInFavsList && !result.isFavorite) {
        onRemoveFavorite(url);
        return;
      }
      if (!isInFavsList && result.isFavorite) {
        onAddFavorite(url);
        return;
      }
    });
  }

  void onAddFavorite(String url) {
    _starWarsFavs.saveFavorite(url);

    emit(state.copyWith(
        peopleList: _starWarsFavs.getFavoritePeople(
      characters: state.peopleList,
    )));
  }

  void onRemoveFavorite(String url) {
    _starWarsFavs.removeFavorite(url);

    emit(state.copyWith(
        peopleList: _starWarsFavs.getFavoritePeople(
      characters: state.peopleList,
    )));
  }
}

@freezed
class PeopleListState with _$PeopleListState {
  factory PeopleListState({
    @Default(false) bool isLoading,
    @Default(false) bool isBottomLoading,
    @Default(<StarWarsFavCharacter>[]) List<StarWarsFavCharacter> peopleList,
    String? paginationCursor,
  }) = _PeopleListState;
}
