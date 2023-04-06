import 'package:star_wars_app/core/domain/contracts/mapper.dart';
import 'package:star_wars_app/features/star_wars_api/data/model/star_wars_character_dto.dart';
import 'package:star_wars_app/features/star_wars_api/domain/models/star_wars_charater.dart';

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
