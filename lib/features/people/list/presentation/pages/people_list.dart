import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/presentation/widgets/list_view_infinite_scroll.dart';
import '../../../detail/presentation/pages/detail_provider.dart';
import '../../../../star_wars_api/domain/models/star_wars_character.dart';

import '../cubit/people_list_cubit.dart';
import '../widgets/people_tile.dart';

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
          final StarWarsFavCharacter item = state.peopleList[index];
          return PeopleTile(
            onTap: () => _navigateToDetail(context, item),
            isFavorite: item.isFavorite,
            item: item,
            onAddFavorite: () => cubit.onAddFavorite(item.url),
            onRemoveFavorite: () => cubit.onRemoveFavorite(item.url),
          );
        },
      );
    });
  }

  void _navigateToDetail(BuildContext context, StarWarsFavCharacter item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return DetailProvider(character: item);
      }),
    );
  }
}
