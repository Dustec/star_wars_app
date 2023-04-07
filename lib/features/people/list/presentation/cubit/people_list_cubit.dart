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
    _dbBox = Db.instance.getDb<UserFav>(DbBoxes.userFavs);
    _dbFavs = _dbBox.values.map((e) => e.url ?? '').toList();

    emit(state.copyWith(isLoading: true));
    getPeople();
  }

  late Box<UserFav> _dbBox;
  late List<String> _dbFavs;
  final StarWarsRepository _starWarsRepo;

  @override
  Future<void> close() {
    disposeAll();
    return super.close();
  }

  void getPeople() {
    _starWarsRepo
        .getPeople(
          page: state.paginationCursor,
        )
        .flatMap((PaginatedStarWarsCharacters pagination) async* {
          yield PaginatedStarWarsFavCharactersDto(
            next: pagination.next,
            characters:
                pagination.characters.map((StarWarsCharacter character) {
              return StarWarsFavCharacter(
                  name: character.name,
                  url: character.url,
                  homeWorld: character.homeWorld,
                  birthYear: character.birthYear,
                  isFavorite:
                      _dbFavs.any((element) => element == character.url));
            }).toList(),
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
    String? paginationCursor,
  }) = _PeopleListState;
}
