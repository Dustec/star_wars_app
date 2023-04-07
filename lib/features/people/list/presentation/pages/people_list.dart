import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/core/presentation/widgets/texts/title_text.dart';
import 'package:star_wars_app/features/people/list/presentation/cubit/people_list_cubit.dart';

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

      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('textooooo'),
          );
        },
      );
    });
  }
}
