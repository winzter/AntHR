import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/timeline_entity.dart';
class LeaveRequestDetail extends StatelessWidget {

  final LeaveEntity leaveData;
  const LeaveRequestDetail({super.key, required this.leaveData});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/break.svg"),
                const SizedBox(
                  width: 5,
                ),
                Text(leaveData.name!,style: const TextStyle(fontSize: 18),)
              ],),
            ExpandChild(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("สถานะ : ",style: TextStyle(fontSize: 17),),
                        Flexible(child: Text(leaveData.isApprove == null?'รออนุมัติ':leaveData.isApprove == 1?'อนุมัติแล้ว':'ไม่อนุมัติ',style: const TextStyle(fontSize: 17))),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("ประเภท : ",style: TextStyle(fontSize: 17)),
                        Flexible(child: Text("${leaveData.name}",style: const TextStyle(fontSize: 17))),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("เวลา : ",style: TextStyle(fontSize: 17)),
                        Text("${DateFormat("HH:mm").format(leaveData.start!)} - ${DateFormat("HH:mm").format(leaveData.end!)}",style: const TextStyle(fontSize: 17)),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("วันที่ : ",style: TextStyle(fontSize: 17)),
                        Text("${DateFormat("dd/MM/yy").format(leaveData.start!)} - ${DateFormat("dd/MM/yy").format(leaveData.end!)}",style: const TextStyle(fontSize: 17)),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("เหตุผลเพิ่มเติม : ",style: TextStyle(fontSize: 17)),
                        Flexible(child: Text("${(leaveData.description??'') == ''?'-':leaveData.description}",style: const TextStyle(fontSize: 17))),
                      ],
                    ),
                    const SizedBox(height: 3),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
