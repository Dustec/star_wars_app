import 'package:flutter/material.dart';

class ListViewInfiniteScroll extends StatelessWidget {
  const ListViewInfiniteScroll({
    Key? key,
    required this.itemCount,
    required this.fetchMoreData,
    required this.showBottomLoader,
    required this.itemBuilder,
    this.itemsOffset = 4,
    this.bottomLoaderWidget,
  }) : super(key: key);

  final int itemCount;
  final VoidCallback? fetchMoreData;
  final int itemsOffset;
  final Widget? bottomLoaderWidget;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final bool showBottomLoader;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: itemCount + (showBottomLoader ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == itemCount - itemsOffset && showBottomLoader == false) {
          fetchMoreData?.call();
        }
        if (index == itemCount) {
          return bottomLoaderWidget ??
              Container(
                height: 100,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 8),
                child: const CircularProgressIndicator(),
              );
        }
        return itemBuilder(context, index);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
