import 'package:star_wars_app/features/star_wars_api/data/mapper/star_wars_character_from_dto_mapper.dart';
import 'package:star_wars_app/features/star_wars_api/data/mapper/star_wars_planet_from_dto_mapper.dart';
import 'package:star_wars_app/features/star_wars_api/data/model/star_wars_planet_dto.dart';
import 'package:star_wars_app/features/star_wars_api/domain/models/star_wars_planet.dart';

import '../../../core/domain/contracts/mapper.dart';
import '../../../core/domain/managers/http_manager.dart';
import '../domain/models/star_wars_character.dart';
import '../domain/star_wars_repository.dart';
import '../remote/star_wars_api.dart';
import 'model/star_wars_get_people_response.dart';

class StarWarsDataRepository with StarWarsApi implements StarWarsRepository {
  StarWarsDataRepository({
    this.getPeopleMapper = const StarWarsGetPeopleFromDtoMapper(),
    this.planetMapper = const StarWarsPlanetFromDtoMapper(),
  });

  final Mapper<StarWarsGetPeopleResponseDto, PaginatedStarWarsCharacters>
      getPeopleMapper;
  final Mapper<StarWarsPlanetDto, StarWarsPlanet> planetMapper;

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

  @override
  Stream<StarWarsPlanet> getPlanetById({
    String? endpoint,
    String? id,
  }) async* {
    yield* http
        .get(endpoint ?? endpointParse('planets/$id'))
        .handle(mapper: (dynamic json) => StarWarsPlanetDto.fromJson(json))
        .map(planetMapper.map);
  }
}
