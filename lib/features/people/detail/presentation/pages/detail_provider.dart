import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/features/star_wars_api/domain/models/star_wars_character.dart';

import '../../../../../di/injector.dart';
import '../cubit/detail_cubit.dart';
import 'detail_page.dart';

class DetailProvider extends StatelessWidget {
  const DetailProvider({
    Key? key,
    required this.character,
  }) : super(key: key);

  final StarWarsFavCharacter character;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailCubit(
        starWarsRepo: injector.get(),
        character: character,
      ),
      child: DetailPage(
        name: character.name,
        isFavorite: character.isFavorite,
      ),
    );
  }
}
