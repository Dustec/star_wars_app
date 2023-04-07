import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:star_wars_app/features/user_favorites/db/adapters/user_favs_db.dart';
import 'package:star_wars_app/features/user_favorites/db/constants/db_constants.dart';
import 'package:star_wars_app/features/user_favorites/db/db.dart';

import 'core/presentation/resources/color_palette.dart';
import 'di/injector.dart';
import 'features/splash/presentation/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Directory dir = await getApplicationDocumentsDirectory();
  await Db.instance.init(dir.path);
  await Db.instance.openDb<UserFav>(DbBoxes.userFavs);

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
