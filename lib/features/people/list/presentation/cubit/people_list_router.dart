import 'package:flutter/material.dart';
import 'package:star_wars_app/features/people/detail/presentation/pages/detail_provider.dart';
import 'package:star_wars_app/features/star_wars_api/domain/models/star_wars_character.dart';

abstract class PeopleListRouter {
  Future<StarWarsFavCharacter?> navigateToDetail(
    StarWarsFavCharacter character,
  );
}

class PeopleListRouterImp implements PeopleListRouter {
  PeopleListRouterImp(
    this.context,
  );

  final BuildContext context;

  @override
  Future<StarWarsFavCharacter?> navigateToDetail(
    StarWarsFavCharacter character,
  ) {
    return Navigator.of(context).push<StarWarsFavCharacter?>(
      MaterialPageRoute<StarWarsFavCharacter?>(builder: (BuildContext context) {
        return DetailProvider(character: character);
      }),
    );
  }
}
