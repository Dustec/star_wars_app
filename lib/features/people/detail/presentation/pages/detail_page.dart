import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/resources/images.dart';
import '../../../../../core/presentation/widgets/star_wars_fav_icon.dart';
import '../../../../../core/presentation/widgets/texts/title_text.dart';

import '../cubit/detail_cubit.dart';
import '../widgets/planet_card.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.name,
    required this.isFavorite,
  }) : super(key: key);

  final String name;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Images.starsBackground,
              ),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        title: TitleText(name),
        centerTitle: false,
        actions: [
          StarWarsFavIcon(isFavorite: isFavorite),
        ],
      ),
      body: BlocBuilder<DetailCubit, DetailState>(
          builder: (BuildContext context, DetailState state) {
        if (state.isLoading || state.planet == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SafeArea(
          child: PlanetCard(
            planet: state.planet!,
          ),
        );
      }),
      floatingActionButton: Container(
        height: 50,
        width: 100,
        padding: const EdgeInsets.only(bottom: 4, right: 4),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Images.millenniumFalcon,
            ),
            fit: BoxFit.fitHeight,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
