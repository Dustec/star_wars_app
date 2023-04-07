import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/domain/extensions/stream_extensions.dart';
import '../../../../../core/presentation/mixins/disposable_cubit.dart';
import '../../../../star_wars_api/domain/models/star_wars_character.dart';
import '../../../../star_wars_api/domain/models/star_wars_planet.dart';

import '../../../../star_wars_api/domain/star_wars_repository.dart';

part 'detail_cubit.freezed.dart';

class DetailCubit extends Cubit<DetailState> with DisposableCubit {
  DetailCubit({
    required StarWarsRepository starWarsRepo,
    required this.character,
  })  : _starWarsRepo = starWarsRepo,
        super(DetailState()) {
    _init();
  }

  final StarWarsCharacter character;
  final StarWarsRepository _starWarsRepo;

  @override
  Future<void> close() {
    disposeAll();
    return super.close();
  }

  void _init() {
    emit(state.copyWith(isLoading: true));

    _starWarsRepo.getPlanetById(endpoint: character.homeWorld).listen(
      (StarWarsPlanet planet) {
        emit(state.copyWith(planet: planet));
      },
      onError: (_) {},
      onDone: () => emit(state.copyWith(isLoading: false)),
    ).dispose(this);
  }
}

@freezed
class DetailState with _$DetailState {
  factory DetailState({
    @Default(false) bool isLoading,
    StarWarsPlanet? planet,
  }) = _DetailState;
}
