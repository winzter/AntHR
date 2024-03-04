import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TimeLineShimmer extends StatelessWidget {
  final double width;
  final double height;
  const TimeLineShimmer({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            top: 5.0, left: 5, right: 5, bottom: 0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child:Container(
                    width: width,
                    height: height,
                    decoration: ShapeDecoration(
                        color: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
                    ),
                  )),
            );
          },)
    );
  }
}
