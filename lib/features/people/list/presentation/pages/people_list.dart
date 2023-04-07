import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/core/presentation/widgets/list_view_infinite_scroll.dart';

import '../cubit/people_list_cubit.dart';
import '../widgets/people_card.dart';

class PeopleList extends StatelessWidget {
  const PeopleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PeopleListCubit cubit = context.read();
    return BlocBuilder<PeopleListCubit, PeopleListState>(
        builder: (BuildContext context, PeopleListState state) {
      if (state.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return ListViewInfiniteScroll(
        fetchMoreData: cubit.fetchMoreData,
        showBottomLoader: state.isBottomLoading,
        itemCount: state.peopleList.length,
        itemBuilder: (BuildContext context, int index) {
          return PeopleTile(
            onTap: () {},
            isFavorite: false,
            item: state.peopleList[index],
          );
        },
      );
    });
  }
}
