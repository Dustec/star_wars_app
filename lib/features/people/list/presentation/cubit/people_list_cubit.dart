import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:star_wars_app/features/people/list/presentation/cubit/people_list_router.dart';

import '../../../../user_favorites/db/adapters/user_favs_db.dart';
import '../../../../user_favorites/db/constants/db_constants.dart';
import '../../../../user_favorites/db/db.dart';

import '../../../../../core/domain/extensions/stream_extensions.dart';
import '../../../../../core/presentation/mixins/disposable_cubit.dart';
import '../../../../star_wars_api/domain/models/star_wars_character.dart';
import '../../../../star_wars_api/domain/star_wars_repository.dart';

part 'people_list_cubit.freezed.dart';

class PeopleListCubit extends Cubit<PeopleListState> with DisposableCubit {
  PeopleListCubit({
    required StarWarsRepository starWarsRepo,
    required PeopleListRouter router,
  })  : _starWarsRepo = starWarsRepo,
        _router = router,
        super(PeopleListState()) {
    _init();
  }

  final StarWarsRepository _starWarsRepo;
  final PeopleListRouter _router;

  late Box<UserFav> _dbBox;
  final List<String> _favsList = List.empty(growable: true);

  @override
  Future<void> close() {
    disposeAll();
    return super.close();
  }

  void _init() {
    _dbBox = Db.instance.getDb<UserFav>(DbBoxes.userFavs);
    final List<String> savedFavs =
        _dbBox.values.map((e) => e.url ?? '').toList();
    _favsList.addAll(savedFavs);

    emit(state.copyWith(isLoading: true));
    getPeople();
  }

  void getPeople() {
    _starWarsRepo
        .getPeople(
          page: state.paginationCursor,
        )
        .flatMap((PaginatedStarWarsCharacters pagination) async* {
          yield PaginatedStarWarsFavCharacters(
            next: pagination.next,
            characters: _buildFavorites(
              characters: pagination.characters,
              favsList: [..._favsList],
            ),
          );
        })
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
      final bool isInFavsList = _favsList.any((element) => element == url);

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
    _dbBox.put(url, UserFav(url: url));
    _favsList.add(url);

    emit(state.copyWith(
        peopleList: _buildFavorites(
      characters: state.peopleList,
      favsList: [..._favsList],
    )));
  }

  void onRemoveFavorite(String url) {
    _dbBox.delete(url);
    _favsList.remove(url);

    emit(state.copyWith(
        peopleList: _buildFavorites(
      characters: state.peopleList,
      favsList: [..._favsList],
    )));
  }

  List<StarWarsFavCharacter> _buildFavorites({
    required List<StarWarsCharacter> characters,
    required List<String> favsList,
  }) {
    return characters.map((StarWarsCharacter character) {
      return StarWarsFavCharacter(
          name: character.name,
          url: character.url,
          homeWorld: character.homeWorld,
          birthYear: character.birthYear,
          isFavorite: favsList.any((element) => element == character.url));
    }).toList();
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
