import 'package:flutter/material.dart';

import '../../../core/presentation/resources/images.dart';
import '../../../core/presentation/widgets/base_app_bar.dart';
import '../../../core/presentation/widgets/base_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: Hero(
          tag: Images.starWarsLogo,
          child: Image.asset(
            Images.starWarsLogo,
            width: 120,
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: const Center(
        child: Text('HOME'),
      ),
    );
  }
}
