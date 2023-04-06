import 'package:flutter/material.dart';

class TitleText extends Text {
  const TitleText(String text, {Key? key})
      : super(
          text,
          key: key,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
}
