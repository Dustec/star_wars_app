import 'package:freezed_annotation/freezed_annotation.dart';

part 'star_wars_character_dto.g.dart';

@JsonSerializable()
class StarWarsCharacter {
  const StarWarsCharacter({
    required this.name,
    required this.url,
    required this.homeworld,
    required this.birthYear,
  });

  factory StarWarsCharacter.fromJson(Map<String, dynamic> json) =>
      _$StarWarsCharacterFromJson(json);
  Map<String, dynamic> toJson() => _$StarWarsCharacterToJson(this);

  final String name;
  final String url;
  final String homeworld;
  @JsonKey(name: 'birth_year')
  final String birthYear;
}
