import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:star_wars_app/features/user_favorites/db/adapters/user_favs_db.dart';
import 'package:star_wars_app/features/user_favorites/db/constants/db_constants.dart';
import 'package:star_wars_app/features/user_favorites/db/db.dart';

import '../../../../../core/domain/extensions/stream_extensions.dart';
import '../../../../../core/presentation/mixins/disposable_cubit.dart';
import '../../../../star_wars_api/domain/models/star_wars_character.dart';
import '../../../../star_wars_api/domain/star_wars_repository.dart';

part 'people_list_cubit.freezed.dart';

class PeopleListCubit extends Cubit<PeopleListState> with DisposableCubit {
  PeopleListCubit({
    required StarWarsRepository starWarsRepo,
  })  : _starWarsRepo = starWarsRepo,
        super(PeopleListState()) {
    _init();
  }

  final StarWarsRepository _starWarsRepo;

  late Box<UserFav> _dbBox;

  @override
  Future<void> close() {
    disposeAll();
    return super.close();
  }

  void _init() {
    _dbBox = Db.instance.getDb<UserFav>(DbBoxes.userFavs);
    final List<String> savedFavs =
        _dbBox.values.map((e) => e.url ?? '').toList();

    emit(state.copyWith(
      isLoading: true,
      favsList: savedFavs,
    ));
    getPeople();
  }

  void getPeople() {
    _starWarsRepo
        .getPeople(
          page: state.paginationCursor,
        )
        .flatMap((PaginatedStarWarsCharacters pagination) async* {
          yield PaginatedStarWarsFavCharactersDto(
            next: pagination.next,
            characters: _buildFavorites(
              characters: pagination.characters,
              favsList: state.favsList,
            ),
          );
        })
        .listen(
          (PaginatedStarWarsFavCharactersDto pagination) => emit(
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

  void onAddFavorite(String url) {
    final List<String> _favs = List.from(state.favsList);
    _dbBox.put(_favs.length + 1, UserFav(url: url));
    _favs.add(url);
    emit(state.copyWith(
        favsList: _favs,
        peopleList: _buildFavorites(
          characters: state.peopleList,
          favsList: _favs,
        )));
  }

  void onRemoveFavorite(String url) {
    final List<String> _favs = List.from(state.favsList);
    _dbBox.deleteAt(_favs.indexWhere((element) => element == url));
    _favs.remove(url);

    emit(state.copyWith(
        favsList: _favs,
        peopleList: _buildFavorites(
          characters: state.peopleList,
          favsList: _favs,
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

class PaginatedStarWarsFavCharactersDto {
  const PaginatedStarWarsFavCharactersDto({
    required this.next,
    required this.characters,
  });
  final String next;
  final List<StarWarsFavCharacter> characters;
}

@freezed
class PeopleListState with _$PeopleListState {
  factory PeopleListState({
    @Default(false) bool isLoading,
    @Default(false) bool isBottomLoading,
    @Default(<StarWarsFavCharacter>[]) List<StarWarsFavCharacter> peopleList,
    @Default(<String>[]) List<String> favsList,
    String? paginationCursor,
  }) = _PeopleListState;
}
