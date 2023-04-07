import 'models/star_wars_character.dart';

abstract class StarWarsRepository {
  Stream<PaginatedStarWarsCharacters> getPeople({
    String? page,
  });
}
