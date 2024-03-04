import 'package:flutter/material.dart';

class BackgroundImg extends StatelessWidget {

  final String imgPath;
  const BackgroundImg({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration:  BoxDecoration(
            image: DecorationImage(
              // image: AssetImage("assets/images/employees_list_manager/background_img.png"),
              image: AssetImage(imgPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Container(
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter,
        //           colors: [
        //             Colors.white.withOpacity(0),
        //             Colors.white.withOpacity(0.95)
        //           ])
        //   ),
        // ),
      ],
    );
  }
}
