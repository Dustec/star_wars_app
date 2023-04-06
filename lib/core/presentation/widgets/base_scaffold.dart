import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    Key? key,
    this.appBar,
    this.extendBodyBehindAppBar = true,
    this.floatingActionButton,
    required this.body,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final bool extendBodyBehindAppBar;
  final Widget? floatingActionButton;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
