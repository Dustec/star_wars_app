import 'package:rxdart/rxdart.dart';
import 'package:star_wars_app/features/star_wars_api/domain/star_wars_repository.dart';
import 'package:star_wars_app/features/user_favorites/domain/sources/user_favs_source.dart';

import 'models/star_wars_character.dart';

abstract class StarWarsFavoritesUseCases {
  List<StarWarsFavCharacter> getFavoritePeople({
    required List<StarWarsCharacter> characters,
  });
  void removeFavorite(String url);
  void saveFavorite(String url);
  Stream<PaginatedStarWarsFavCharacters> getPeople({
    String? page,
  });
}

class StarWarsFavoritesUseCasesImp implements StarWarsFavoritesUseCases {
  StarWarsFavoritesUseCasesImp({
    required UserFavSource favDbSource,
    required StarWarsRepository remoteRepo,
  })  : _favDbSource = favDbSource,
        _remoteRepo = remoteRepo;

  final UserFavSource _favDbSource;
  final StarWarsRepository _remoteRepo;

  @override
  Stream<PaginatedStarWarsFavCharacters> getPeople({
    String? page,
  }) async* {
    yield* _remoteRepo
        .getPeople(page: page)
        .flatMap((PaginatedStarWarsCharacters pagination) async* {
      yield PaginatedStarWarsFavCharacters(
        next: pagination.next,
        characters: getFavoritePeople(
          characters: pagination.characters,
        ),
      );
    });
  }

  @override
  void removeFavorite(String url) {
    _favDbSource.removeFavorite(url);
  }

  @override
  void saveFavorite(String url) {
    _favDbSource.saveFavorite(url);
  }

  List<StarWarsFavCharacter> getFavoritePeople({
    required List<StarWarsCharacter> characters,
  }) {
    return characters.map((StarWarsCharacter character) {
      return StarWarsFavCharacter(
          name: character.name,
          url: character.url,
          homeWorld: character.homeWorld,
          birthYear: character.birthYear,
          isFavorite: _favDbSource
              .getFavorites()
              .any((element) => element == character.url));
    }).toList();
  }
}
