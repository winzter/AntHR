import 'package:flutter/material.dart';

class GifPics extends StatelessWidget {
  const GifPics({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/images/dollar2.gif",
                  width: 70,
                )
              ],
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/wallet.gif",
                  width: 150,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/images/dollar1.gif",
                  width: 70,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
