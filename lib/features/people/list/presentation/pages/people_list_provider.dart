import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/features/people/list/presentation/cubit/people_list_router.dart';
import 'package:star_wars_app/features/star_wars_api/domain/star_wars_favorites_usecases.dart';
import 'package:star_wars_app/features/user_favorites/db/user_favs_db_source.dart';

import '../../../../../di/injector.dart';
import '../cubit/people_list_cubit.dart';
import 'people_list.dart';

class PeopleListProvider extends StatelessWidget {
  const PeopleListProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PeopleListCubit(
        starWarsFavs: StarWarsFavoritesUseCasesImp(
          favDbSource: UserFavDbSource(),
          remoteRepo: injector.get(),
        ),
        router: PeopleListRouterImp(context),
      ),
      child: const PeopleList(),
    );
  }
}
