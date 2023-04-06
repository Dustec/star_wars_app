import '../../../core/domain/contracts/mapper.dart';
import '../../../core/domain/managers/http_manager.dart';
import '../../../core/remote/api.dart';
import '../domain/models/star_wars_charater.dart';
import '../domain/star_wars_repository.dart';
import 'mapper/star_wars_character_from_dto.dart';
import 'model/star_wars_character_dto.dart';
import 'model/star_wars_get_people_response.dart';

class StarWarsDataRepository with Api implements StarWarsRepository {
  StarWarsDataRepository({
    this.characterMapper = const StarWarsCharacterFromDtoMapper(),
  });

  final Mapper<StarWarsCharacterDto, StarWarsCharacter> characterMapper;

  @override
  Stream<List<StarWarsCharacter>> getPeople() async* {
    yield* http
        .get(
          Uri.https(baseUrl, 'people/').toString(),
        )
        .handle(
          mapper: (dynamic json) => StarWarsGetPeopleResponseDto.fromJson(json),
        )
        .map((StarWarsGetPeopleResponseDto r) =>
            (r.results ?? []).map(characterMapper.map).toList());
  }
}
