import 'package:flutter/material.dart';
import 'package:star_wars_app/core/presentation/resources/images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(Images.starWarsLogo),
      ),
    );
  }
}
