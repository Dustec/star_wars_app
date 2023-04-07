import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:star_wars_app/features/star_wars_api/domain/star_wars_repository.dart';

part 'people_list_cubit.freezed.dart';

class PeopleListCubit extends Cubit<PeopleListState> {
  PeopleListCubit({
    required StarWarsRepository starWarsRepo,
  })  : _starWarsRepo = starWarsRepo,
        super(PeopleListState());
  final StarWarsRepository _starWarsRepo;

  void getPeople() {
    _starWarsRepo.getPeople().listen(
          (event) => print('onSucess'),
          onError: (error) => print('onError: $error'),
        );
  }
}

@freezed
class PeopleListState with _$PeopleListState {
  factory PeopleListState({
    @Default(false) bool isLoading,
  }) = _PeopleListState;
}
