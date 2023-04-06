import 'package:flutter/material.dart';

import 'features/splash/presentation/splash_page.dart';

void main() {
  runApp(const StarWarsApp());
}

class StarWarsApp extends StatelessWidget {
  const StarWarsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Star Wars App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: SplashPage(),
    );
  }
}
