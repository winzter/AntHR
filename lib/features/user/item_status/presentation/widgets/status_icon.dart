import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class StatusListIcon extends StatelessWidget {
  const StatusListIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:  BoxDecoration(
            border: Border.all(color: const Color(0xffD9D9D9)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "สถานะต่างๆ",
              style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusIcon(title: "อนุมัติ", path: "assets/icons/approve.svg"),
                StatusIcon(
                    title: "ไม่อนุมัติ", path: "assets/icons/cancel.svg"),
                StatusIcon(
                    title: "รออนุมัติ", path: "assets/icons/question.svg"),
                StatusIcon(
                    title: "รอผู้อนุมัติลำดับที่ 1\nตรวจสอบ",
                    path: "assets/icons/one.svg"),
                StatusIcon(
                    title: "ยกเลิก\nรายการ",
                    path: "assets/icons/grey_cancle.svg"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatusIcon extends StatelessWidget {
  final String title;
  final String path;
  const StatusIcon({super.key, required this.title, required this.path});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          path,
          width: 20,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
