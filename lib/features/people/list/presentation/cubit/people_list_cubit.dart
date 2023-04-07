import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
    emit(state.copyWith(isLoading: true));
    getPeople();
  }

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
        .listen(
          (PaginatedStarWarsCharacters pagination) => emit(
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

@freezed
class PeopleListState with _$PeopleListState {
  factory PeopleListState({
    @Default(false) bool isLoading,
    @Default(false) bool isBottomLoading,
    @Default(<StarWarsCharacter>[]) List<StarWarsCharacter> peopleList,
    String? paginationCursor,
  }) = _PeopleListState;
}
