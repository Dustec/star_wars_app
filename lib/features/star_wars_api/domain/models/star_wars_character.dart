class PaginatedStarWarsCharacters {
  const PaginatedStarWarsCharacters({
    required this.next,
    required this.characters,
  });

  final String next;
  final List<StarWarsCharacter> characters;
}

class PaginatedStarWarsFavCharacters {
  const PaginatedStarWarsFavCharacters({
    required this.next,
    required this.characters,
  });

  final String next;
  final List<StarWarsFavCharacter> characters;
}

class StarWarsFavCharacter extends StarWarsCharacter {
  StarWarsFavCharacter({
    required String name,
    required String url,
    required String homeWorld,
    required String birthYear,
    required this.isFavorite,
  }) : super(
          name: name,
          url: url,
          homeWorld: homeWorld,
          birthYear: birthYear,
        );

  final bool isFavorite;
}

class StarWarsCharacter {
  const StarWarsCharacter({
    required this.name,
    required this.url,
    required this.homeWorld,
    required this.birthYear,
  });

  final String name;
  final String url;
  final String homeWorld;
  final String birthYear;
}
