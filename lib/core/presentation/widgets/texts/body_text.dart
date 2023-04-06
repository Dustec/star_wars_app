import 'package:flutter/material.dart';

class BodyText extends Text {
  const BodyText(String text, {Key? key})
      : super(
          text,
          key: key,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        );
}
