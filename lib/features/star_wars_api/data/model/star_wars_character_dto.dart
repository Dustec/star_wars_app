import 'package:freezed_annotation/freezed_annotation.dart';

part 'star_wars_character_dto.g.dart';

@JsonSerializable()
class StarWarsCharacterDto {
  const StarWarsCharacterDto({
    this.name,
    this.url,
    this.homeworld,
    this.birthYear,
  });

  factory StarWarsCharacterDto.fromJson(Map<String, dynamic> json) =>
      _$StarWarsCharacterDtoFromJson(json);
  Map<String, dynamic> toJson() => _$StarWarsCharacterDtoToJson(this);

  final String? name;
  final String? url;
  final String? homeworld;
  @JsonKey(name: 'birth_year')
  final String? birthYear;
}
