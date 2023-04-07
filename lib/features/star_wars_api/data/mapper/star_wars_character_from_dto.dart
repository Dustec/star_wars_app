import '../../../../core/domain/contracts/mapper.dart';
import '../model/star_wars_character_dto.dart';
import '../../domain/models/star_wars_character.dart';

class StarWarsCharacterFromDtoMapper
    implements Mapper<StarWarsCharacterDto, StarWarsCharacter> {
  const StarWarsCharacterFromDtoMapper();

  @override
  StarWarsCharacter map(StarWarsCharacterDto t) {
    return StarWarsCharacter(
      name: t.name ?? '',
      urlImage: t.url ?? '',
      homeWorld: t.homeworld ?? '',
      birthYear: t.birthYear ?? '',
    );
  }
}
