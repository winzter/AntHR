import 'package:flutter/material.dart';

class OneLineText extends StatelessWidget {
  final String text;
  const OneLineText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 13, color: Color(0xff757575)),
    );
  }
}
