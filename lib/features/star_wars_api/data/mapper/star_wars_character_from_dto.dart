import 'package:star_wars_app/features/star_wars_api/data/model/star_wars_get_people_response.dart';

import '../../../../core/domain/contracts/mapper.dart';
import '../model/star_wars_character_dto.dart';
import '../../domain/models/star_wars_character.dart';

class StarWarsGetPeopleFromDtoMapper
    implements
        Mapper<StarWarsGetPeopleResponseDto, PaginatedStarWarsCharacters> {
  const StarWarsGetPeopleFromDtoMapper({
    this.characterMapper = const StarWarsCharacterFromDtoMapper(),
  });

  final Mapper<StarWarsCharacterDto, StarWarsCharacter> characterMapper;

  @override
  PaginatedStarWarsCharacters map(StarWarsGetPeopleResponseDto t) {
    final String next =
        (Uri.tryParse(t.next ?? '')?.queryParameters['page'].toString()) ?? '';

    return PaginatedStarWarsCharacters(
      next: next,
      characters: (t.results ?? []).map(characterMapper.map).toList(),
    );
  }
}

class StarWarsCharacterFromDtoMapper
    implements Mapper<StarWarsCharacterDto, StarWarsCharacter> {
  const StarWarsCharacterFromDtoMapper();

  @override
  StarWarsCharacter map(StarWarsCharacterDto t) {
    return StarWarsCharacter(
      name: t.name ?? '',
      url: t.url ?? '',
      homeWorld: t.homeworld ?? '',
      birthYear: t.birthYear ?? '',
    );
  }
}
