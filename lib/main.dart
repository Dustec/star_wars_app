import 'package:flutter/material.dart';

import 'features/splash/presentation/splash_page.dart';
import 'core/presentation/resources/color_palette.dart';

void main() {
  runApp(const StarWarsApp());
}

class StarWarsApp extends StatelessWidget {
  const StarWarsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          colorScheme: const ColorScheme.dark(
        secondary: ColorPalette.accent,
      )),
      home: const SplashPage(),
    );
  }
}
