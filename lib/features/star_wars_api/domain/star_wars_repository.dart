import 'models/star_wars_charater.dart';

abstract class StarWarsRepository {
  Stream<List<StarWarsCharacter>> getPeople();
}
