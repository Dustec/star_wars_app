import 'package:flutter/material.dart';

import '../resources/images.dart';

class StarWarsFavIcon extends StatelessWidget {
  const StarWarsFavIcon({
    Key? key,
    required this.isFavorite,
  }) : super(key: key);

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
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
