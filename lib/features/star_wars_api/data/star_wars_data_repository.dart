import '../../../core/domain/contracts/mapper.dart';
import '../../../core/domain/managers/http_manager.dart';
import '../domain/models/star_wars_character.dart';
import '../domain/star_wars_repository.dart';
import '../remote/star_wars_api.dart';
import 'mapper/star_wars_character_from_dto.dart';
import 'model/star_wars_get_people_response.dart';

class StarWarsDataRepository with StarWarsApi implements StarWarsRepository {
  StarWarsDataRepository({
    this.getPeopleMapper = const StarWarsGetPeopleFromDtoMapper(),
  });

  final Mapper<StarWarsGetPeopleResponseDto, PaginatedStarWarsCharacters>
      getPeopleMapper;

  @override
  Stream<PaginatedStarWarsCharacters> getPeople({
    String? page,
  }) async* {
    yield* http
        .get(endpointParse('people/'), queryParams: {
          'page': page,
        })
        .handle(
          mapper: (dynamic json) => StarWarsGetPeopleResponseDto.fromJson(json),
        )
        .map(getPeopleMapper.map);
  }
}
