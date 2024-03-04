import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/entities.dart';

class RequestTimeDetail extends StatelessWidget {

  final RequestTimeEntity e;
  const RequestTimeDetail({super.key, required this.e});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/guarantee.svg"),
                const SizedBox(
                  width: 5,
                ),
                Text(e.name!,style: const TextStyle(fontSize: 18),)
              ],),
            ExpandChild(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("สถานะ : ",style: TextStyle(fontSize: 17)),
                        Text(e.isManagerLv1Approve == 1?'อนุมัติแล้ว':(e.isManagerLv1Approve == 0?"ไม่อนุมัติ":'รออนุมัติ'),style: const TextStyle(fontSize: 17)),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("เวลา : ",style: TextStyle(fontSize: 17)),
                        Text("${DateFormat("HH:mm").format(e.start!)} - ${DateFormat("HH:mm").format(e.end!)}",style: const TextStyle(fontSize: 17)),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("วันที่ : ",style: TextStyle(fontSize: 17)),
                        Text("${DateFormat("dd/MM/yy").format(e.start!)} - ${DateFormat("dd/MM/yy").format(e.end!)}",style: const TextStyle(fontSize: 17)),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("เหตุผล : ",style: TextStyle(fontSize: 17)),
                        Flexible(child: Text(e.reasonName!,style: const TextStyle(fontSize: 17))),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("เหตุผลเพิ่มเติม : ",style: TextStyle(fontSize: 17)),
                        Flexible(child: Text("${e.otherReason == ''?'-':e.otherReason}",style: const TextStyle(fontSize: 17))),
                      ],
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
