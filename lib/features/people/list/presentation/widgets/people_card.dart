import 'package:flutter/material.dart';
import 'package:star_wars_app/features/people/list/presentation/widgets/star_wars_fav_icon.dart';

import '../../../../../core/presentation/widgets/texts/body_text.dart';
import '../../../../../core/presentation/widgets/texts/title_text.dart';
import '../../../../star_wars_api/domain/models/star_wars_character.dart';

class PeopleTile extends StatelessWidget {
  const PeopleTile({
    Key? key,
    required this.item,
    this.onTap,
    required this.isFavorite,
    this.onFavoriteTap,
  }) : super(key: key);

  final StarWarsCharacter item;
  final void Function()? onTap;
  final bool isFavorite;
  final void Function()? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: IconButton(
        onPressed: onFavoriteTap,
        iconSize: 50,
        icon: StarWarsFavIcon(
          isFavorite: isFavorite,
        ),
      ),
      title: TitleText(item.name),
      subtitle: BodyText(item.birthYear),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
