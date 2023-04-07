import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/resources/images.dart';
import '../../../../../core/presentation/widgets/star_wars_fav_icon.dart';
import '../../../../../core/presentation/widgets/texts/title_text.dart';
import '../../../../star_wars_api/domain/models/star_wars_character.dart';
import '../cubit/detail_cubit.dart';
import '../widgets/planet_card.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.character,
  }) : super(key: key);

  final StarWarsFavCharacter character;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    _isFavorite = widget.character.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final item = StarWarsFavCharacter(
          name: widget.character.name,
          url: widget.character.url,
          homeWorld: widget.character.homeWorld,
          birthYear: widget.character.birthYear,
          isFavorite: _isFavorite,
        );
        Navigator.pop(context, item);
        return false;
      },
      child: Scaffold(
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
          title: TitleText(widget.character.name),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              iconSize: 50,
              icon: StarWarsFavIcon(
                isFavorite: _isFavorite,
              ),
            ),
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
      ),
    );
  }
}
