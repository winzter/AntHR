import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/entities.dart';

class OtRequestDetail extends StatelessWidget {
  final OtEntity e;
  const OtRequestDetail({super.key, required this.e});

  String otApproveStatus(OtEntity data){
    if(data.isDoubleApproval == 1){
      if(data.isManagerLv2Approve == 1){
        return "อนุมัติ";
      }else if(data.isManagerLv2Approve == null){
        return "รออนุมัติ";
      }else{
        return "ไม่อนุมัติ";
      }
    }else{
      if(data.isManagerLv1Approve == 1){
        return "อนุมัติ";
      }
      else if(data.isManagerLv1Approve == null){
        return "รออนุมัติ";
      }else{
        return "ไม่อนุมัติ";
      }
    }
  }
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
                SvgPicture.asset("assets/icons/ot.svg"),
                const SizedBox(
                  width: 5,
                ),
                Text(e.name!,style: const TextStyle(fontSize: 18),)
              ],
            ),
            ExpandChild(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    if(e.xOt != 0)...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(e.isManagerLv1Approve == 1? "assets/icons/approve.svg"
                              :(e.isManagerLv1Approve == null ?"assets/icons/one.svg":"assets/icons/cancel.svg"),width: 25),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("OT x 1.5 = ${(e.xOt!/60).toStringAsFixed(2)} ชั่วโมง ",style: const TextStyle(fontSize: 18),)
                        ],),
                      const SizedBox(height: 5,),
                    ],
                    if(e.xWorkingDailyHoliday != 0 || e.xWorkingMonthlyHoliday != 0)...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(e.isManagerLv1Approve == 1? "assets/icons/approve.svg"
                              :(e.isManagerLv1Approve == null ?"assets/icons/one.svg":"assets/icons/cancel.svg"),width: 25,),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("OT x 1 = ${(e.xWorkingDailyHoliday != 0? e.xWorkingDailyHoliday!/60 :e.xWorkingMonthlyHoliday!/60).toStringAsFixed(2)} ชั่วโมง "
                            ,style: const TextStyle(fontSize: 18),)
                        ],),
                      const SizedBox(height: 5,),
                    ],
                    if(e.xOtHoliday != 0)...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(e.isManagerLv2Approve == 1? "assets/icons/approve.svg"
                              :(e.isManagerLv2Approve == null ?"assets/icons/two.svg":"assets/icons/notpass.svg")),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("OT x 3 = ${(e.xOtHoliday!/60).toStringAsFixed(2)} ชั่วโมง ",style: const TextStyle(fontSize: 18),)
                        ],),
                      const SizedBox(height: 5,),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("สถานะ : ",style: TextStyle(fontSize: 17)),
                        Text(otApproveStatus(e),style: const TextStyle(fontSize: 17)),
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
                        Flexible(child: Text(e.reasonName??"-",style: const TextStyle(fontSize: 17))),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("เหตุผลเพิ่มเติม : ",style: TextStyle(fontSize: 17)),
                        Flexible(child: Text("${e.otherReason == ''?'-':e.otherReason}",style: const TextStyle(fontSize: 17),textAlign: TextAlign.end,)),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("ความคิดเห็น Lv1 : ",style: TextStyle(fontSize: 17)),
                        Flexible(child: Text("${e.commentManagerLv1 == ''||e.commentManagerLv1 == null?'-':e.commentManagerLv1}",style: const TextStyle(fontSize: 17))),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("ความคิดเห็น Lv2 : ",style: TextStyle(fontSize: 17)),
                        Flexible(child: Text("${e.commentManagerLv2 == ''||e.commentManagerLv2 == null?'-':e.commentManagerLv2}",style: const TextStyle(fontSize: 17))),
                      ],
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
