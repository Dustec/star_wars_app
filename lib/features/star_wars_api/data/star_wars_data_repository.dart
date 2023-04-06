import 'package:star_wars_app/core/domain/managers/http_manager.dart';
import 'package:star_wars_app/core/remote/api.dart';

import '../domain/models/star_wars_charater.dart';
import '../domain/star_wars_repository.dart';

class StarWarsDataRepository with Api implements StarWarsRepository {
  @override
  Stream<StarWarsCharacter> getPeople() async* {
    yield* http
        .get(
          Uri.https(baseUrl, 'people/').toString(),
        )
        .handle(mapper: mapper);
  }
}
