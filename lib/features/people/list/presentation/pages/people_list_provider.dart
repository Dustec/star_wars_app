import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/features/people/list/presentation/cubit/people_list_router.dart';

import '../../../../../di/injector.dart';
import '../cubit/people_list_cubit.dart';
import 'people_list.dart';

class PeopleListProvider extends StatelessWidget {
  const PeopleListProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PeopleListCubit(
        starWarsRepo: injector.get(),
        router: PeopleListRouterImp(context),
      ),
      child: const PeopleList(),
    );
  }
}
