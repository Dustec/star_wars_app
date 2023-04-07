import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:star_wars_app/core/presentation/mixins/disposable_cubit.dart';

import '../../../../star_wars_api/domain/star_wars_repository.dart';

part 'detail_cubit.freezed.dart';

class DetailCubit extends Cubit<DetailState> with DisposableCubit {
  DetailCubit({
    required StarWarsRepository starWarsRepo,
  })  : _starWarsRepo = starWarsRepo,
        super(DetailState());

  final StarWarsRepository _starWarsRepo;

  @override
  Future<void> close() {
    disposeAll();
    return super.close();
  }
}

@freezed
class DetailState with _$DetailState {
  factory DetailState({
    @Default(false) bool isLoading,
  }) = _DetailState;
}
