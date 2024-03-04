import 'package:flutter/material.dart';
import 'package:anthr/features/user/summary_shfit_ot/domain/entities/shift_ot_entity.dart';
import 'package:intl/intl.dart';

class CardDayData extends StatefulWidget {
  final ShiftAndOtEntity data;
  final int index;
  const CardDayData({super.key, required this.data, required this.index});

  @override
  State<CardDayData> createState() => _CardDayDataState();
}

class _CardDayDataState extends State<CardDayData> {

  Widget listTile(String title, String amount, Color color, [String detail = "0.00",bool isLoss = false]) {
    return detail != "0.00"
        ? ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Color(0xff3D6670),fontSize: 18),
      ),
      trailing: title == "ขาดงาน"?
            Text("${detail.toString()} วัน",style: TextStyle(color: color, fontSize: 18))
          :Text(
        amount,
        style: TextStyle(color: color, fontSize: 18),
      ),
      subtitle: Text(
        (title != "ขาดงาน" && title != "มาสาย/กลับก่อน")?"$detail ชม." :"${DateFormat("dd MMM yyyy").format(widget.data.dock!.start!)} - ${DateFormat("dd MMM yyyy").format(widget.data.dock!.end!)}",
        style: const TextStyle(color: Color(0xffC4C4C4),fontSize: 18),
      ),
    )
        : ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Color(0xff3D6670),fontSize: 18),
      ),
      trailing: title == "ขาดงาน"?
          Text("$detail วัน",style: TextStyle(color: color, fontSize: 18))
          :Text(
        isLoss? "-$amount":amount,
        style: TextStyle(color: color, fontSize: 18),
      ),
      subtitle: Text(
        (title != "ขาดงาน" && title != "มาสาย/กลับก่อน")?"$detail ชม." :"${DateFormat("dd MMM yyyy").format(widget.data.dock!.start!)} - ${DateFormat("dd MMM yyyy").format(widget.data.dock!.end!)}",
        style: const TextStyle(color: Color(0xffC4C4C4),fontSize: 18),
      ),
    );
  }

  Widget profitBox() {
    double sum = 0;
    if(widget.data.dataTable![widget.index].otOneAmount!= null
        && widget.data.dataTable![widget.index].otOneFiveAmount != null
        && widget.data.dataTable![widget.index].otTwoAmount != null
        && widget.data.dataTable![widget.index].otThreeAmount != null){
      sum = ( widget.data.dataTable![widget.index].otOneAmount! + widget.data.dataTable![widget.index].otOneFiveAmount!
          + widget.data.dataTable![widget.index].otTwoAmount! + widget.data.dataTable![widget.index].otThreeAmount! +
          widget.data.dataTable![widget.index].shiftMorning! + widget.data.dataTable![widget.index].shiftNoon! +
          widget.data.dataTable![widget.index].shiftNight! - widget.data.dock!.lateEarly!.amount! - widget.data.dock!.absent!.amount!);
    }

    Color color;
    String text;
    if (sum < 0) {
      color = Colors.redAccent;
      text = "-฿$sum";
    }
    else if(sum == 0){
      color = const Color(0xff41BE06);
      text = "฿$sum";
    }
    else {
      color = const Color(0xff41BE06);
      text = "+฿$sum";
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  bool contains(String text){
    return text.contains("OFF");
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xff27385E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if(contains(widget.data.dataTable![widget.index].dataRender!.nameShiftType!.toString()))...[
                    Text(
                      "${DateFormat('dd MMM yyyy').format(widget.data.dataTable![widget.index].dateText!)} (หยุด)",
                      style: const TextStyle(color: Colors.white, fontSize: 15.5),
                    ),
                  ]
                  else...[
                    Text(
                      "${DateFormat('dd MMM yyyy').format(widget.data.dataTable![widget.index].dateText!)} "
                          "(${widget.data.dataTable![widget.index].dataRender!.timeIn!.substring(0,5)} "
                          "- ${widget.data.dataTable![widget.index].dataRender!.timeOut!.substring(0,5)})",
                      style: const TextStyle(color: Colors.white, fontSize: 15.5),
                    ),
                  ],
                  profitBox()
                ],
              ),
            ),
            if(widget.data.dataTable![widget.index].otOneAmount != null
                && widget.data.dataTable![widget.index].otOneFiveAmount != null
                && widget.data.dataTable![widget.index].otTwoAmount != null
                && widget.data.dataTable![widget.index].otThreeAmount != null)...[
              listTile("OT 1", "${widget.data.dataTable![widget.index].otOneAmount}", const Color(0xff30B98F), widget.data.dataTable![widget.index].otOneHours!.toStringAsFixed(2)),
              listTile("OT 1.5", "${widget.data.dataTable![widget.index].otOneFiveAmount}", const Color(0xff30B98F),widget.data.dataTable![widget.index].otOneFiveHours!.toStringAsFixed(2)),
              listTile("OT 2", "${widget.data.dataTable![widget.index].otTwoAmount}", const Color(0xff30B98F),widget.data.dataTable![widget.index].otTwoHours!.toStringAsFixed(2)),
              listTile("OT 3", "${widget.data.dataTable![widget.index].otThreeAmount}", const Color(0xff30B98F),widget.data.dataTable![widget.index].otThreeHours!.toStringAsFixed(2)),
              listTile("ค่ากะเช้า", "${widget.data.dataTable![widget.index].shiftMorning}", const Color(0xff30B98F)),
              listTile("ค่ากะบ่าย", "${widget.data.dataTable![widget.index].shiftNoon}", const Color(0xff30B98F)),
              listTile("ค่ากะดึก", "${widget.data.dataTable![widget.index].shiftNight}", const Color(0xff30B98F)),
              listTile("มาสาย/กลับก่อน", "${widget.data.dock!.lateEarly!.amount}", const Color(0xffFF6575),widget.data.dock!.lateEarly!.value!.toStringAsFixed(2),true),
              listTile("ขาดงาน", "${widget.data.dock!.absent!.amount}", const Color(0xffFF6575),widget.data.dock!.absent!.value!.toStringAsFixed(2),true),
            ]else...[
              const Padding(
                padding: EdgeInsets.all(50.0),
                child: Center(child: Text("ไม่มีข้อมูล",style: TextStyle(fontSize: 20),),),
              )
            ]

          ],
        ),
      ),
    );
  }

}