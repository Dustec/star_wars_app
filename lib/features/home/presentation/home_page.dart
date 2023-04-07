import 'package:flutter/material.dart';
import 'package:star_wars_app/features/people/list/presentation/pages/people_list_provider.dart';

import '../../../core/presentation/resources/images.dart';
import '../../../core/presentation/widgets/base_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const PeopleListProvider(),
    );
  }
}
