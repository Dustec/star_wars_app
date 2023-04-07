import 'package:flutter/material.dart';
import 'package:star_wars_app/core/presentation/resources/images.dart';
import 'package:star_wars_app/core/presentation/widgets/star_wars_fav_icon.dart';
import 'package:star_wars_app/core/presentation/widgets/texts/title_text.dart';

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
        title: TitleText(' $name'),
        centerTitle: false,
        actions: [
          StarWarsFavIcon(isFavorite: isFavorite),
        ],
      ),
      body: Center(
        child: TitleText('Detail: $name'),
      ),
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
