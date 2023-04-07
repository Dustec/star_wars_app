import 'package:freezed_annotation/freezed_annotation.dart';

part 'star_wars_planet_dto.g.dart';

@JsonSerializable()
class StarWarsPlanetDto {
  const StarWarsPlanetDto({
    this.name,
    this.climate,
    this.gravity,
    this.diameter,
    this.population,
    this.terrain,
  });

  factory StarWarsPlanetDto.fromJson(Map<String, dynamic> json) =>
      _$StarWarsPlanetDtoFromJson(json);
  Map<String, dynamic> toJson() => _$StarWarsPlanetDtoToJson(this);

  final String? name;
  final String? climate;
  final String? gravity;
  final String? diameter;
  final String? population;
  final String? terrain;
}
