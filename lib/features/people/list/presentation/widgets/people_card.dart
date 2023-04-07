import 'package:flutter/material.dart';

import '../../../../../core/presentation/widgets/texts/body_text.dart';
import '../../../../../core/presentation/widgets/texts/title_text.dart';
import '../../../../star_wars_api/domain/models/star_wars_character.dart';

class PeopleTile extends StatelessWidget {
  const PeopleTile({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  final StarWarsCharacter item;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: TitleText(item.name),
      subtitle: BodyText(item.birthYear),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
