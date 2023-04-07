import 'package:star_wars_app/core/domain/contracts/mapper.dart';
import 'package:star_wars_app/features/star_wars_api/data/model/star_wars_planet_dto.dart';
import 'package:star_wars_app/features/star_wars_api/domain/models/star_wars_planet.dart';

class StarWarsPlanetFromDtoMapper
    implements Mapper<StarWarsPlanetDto, StarWarsPlanet> {
  const StarWarsPlanetFromDtoMapper();

  @override
  StarWarsPlanet map(StarWarsPlanetDto t) {
    return StarWarsPlanet(
      name: t.name ?? '',
      climate: t.climate ?? '',
      gravity: t.gravity ?? '',
      diameter: t.diameter ?? '',
      population: t.population ?? '',
      terrain: t.terrain ?? '',
    );
  }
}
