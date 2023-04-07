import 'package:star_wars_app/features/star_wars_api/domain/models/star_wars_planet.dart';

import 'models/star_wars_character.dart';

abstract class StarWarsRepository {
  Stream<PaginatedStarWarsCharacters> getPeople({
    String? page,
  });

  Stream<StarWarsPlanet> getPlanetById({
    String? endpoint,
    String? id,
  });
}
