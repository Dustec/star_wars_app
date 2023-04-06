import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:star_wars_app/features/star_wars_api/data/model/star_wars_character_dto.dart';

part 'star_wars_get_people_response.g.dart';

@JsonSerializable()
class StarWarsGetPeopleResponseDto {
  StarWarsGetPeopleResponseDto({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory StarWarsGetPeopleResponseDto.fromJson(Map<String, dynamic> json) =>
      _$StarWarsGetPeopleResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$StarWarsGetPeopleResponseDtoToJson(this);

  final int? count;
  final String? next;
  final String? previous;
  final List<StarWarsCharacterDto>? results;
}
