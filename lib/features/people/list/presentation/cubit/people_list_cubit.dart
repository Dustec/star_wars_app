import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../star_wars_api/domain/models/star_wars_character.dart';
import '../../../../star_wars_api/domain/star_wars_repository.dart';

part 'people_list_cubit.freezed.dart';

class PeopleListCubit extends Cubit<PeopleListState> {
  PeopleListCubit({
    required StarWarsRepository starWarsRepo,
  })  : _starWarsRepo = starWarsRepo,
        super(PeopleListState()) {
    getPeople();
  }

  final StarWarsRepository _starWarsRepo;

  void getPeople() {
    emit(state.copyWith(isLoading: true));

    _starWarsRepo.getPeople().listen(
          (PaginatedStarWarsCharacters pagination) => emit(
            state.copyWith(
              paginationCursor: pagination.next,
              peopleList: pagination.characters,
            ),
          ),
          onError: (error) => print('onError: $error'),
          onDone: () => emit(
            state.copyWith(isLoading: false),
          ),
        );
  }
}

@freezed
class PeopleListState with _$PeopleListState {
  factory PeopleListState({
    @Default(false) bool isLoading,
    @Default(<StarWarsCharacter>[]) List<StarWarsCharacter> peopleList,
    String? paginationCursor,
  }) = _PeopleListState;
}
