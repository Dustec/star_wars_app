import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({
    Key? key,
    Widget? title,
    Color? backgroundColor,
  }) : super(
          key: key,
          title: title,
          backgroundColor: backgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        );
}
