import 'package:flutter/material.dart';
import 'package:star_wars_app/core/presentation/resources/images.dart';

class StarWarsFavIcon extends StatelessWidget {
  const StarWarsFavIcon({
    Key? key,
    required this.isFavorite,
  }) : super(key: key);

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
        ),
        image: isFavorite
            ? const DecorationImage(
                image: AssetImage(Images.deathStar),
                fit: BoxFit.contain,
              )
            : null,
      ),
    );
  }
}
