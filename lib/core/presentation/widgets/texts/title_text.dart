import 'package:flutter/material.dart';

class TitleText extends Text {
  const TitleText(
    String text, {
    Key? key,
    TextAlign textAlign = TextAlign.start,
  }) : super(
          text,
          key: key,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: textAlign,
        );
}
