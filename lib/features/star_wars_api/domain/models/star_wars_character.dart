class PaginatedStarWarsCharacters {
  const PaginatedStarWarsCharacters({
    required this.next,
    required this.characters,
  });

  final String next;
  final List<StarWarsCharacter> characters;
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
