import 'package:flutter/material.dart';

class Loading extends StatelessWidget {

  final Color color;
  const Loading({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: color,)
        ],
      ),
    );
  }
}
