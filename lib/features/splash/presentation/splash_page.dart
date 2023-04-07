import 'package:flutter/material.dart';

import '../../../core/presentation/resources/images.dart';
import '../../home/presentation/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateToHome());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.starWarsBackground),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Hero(
              tag: Images.starWarsLogo,
              child: Image.asset(Images.starWarsLogo)),
        ),
      ),
    );
  }

  void _navigateToHome() {
    Future<void>.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (BuildContext context) {
          return const HomePage();
        }),
      );
    });
  }
}
