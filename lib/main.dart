import 'dart:io';

import 'package:flutter/material.dart';
import 'package:star_wars_app/features/user_favorites/db/db.dart';

import 'core/presentation/resources/color_palette.dart';
import 'di/injector.dart';
import 'features/splash/presentation/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String path = Directory.current.path;
  await Db.instance.init(path);

  registerDependencies();
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
        primary: ColorPalette.accent,
        secondary: ColorPalette.accent,
      )),
      home: const SplashPage(),
    );
  }
}
