import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/timeline_entity.dart';
import '../status_icon_text.dart';
import 'day_status.dart';

Color dayColors(TimeLineEntity data) {
  switch (DateFormat('EE').format(data.date!)) {
    case "จ.":
      return const Color(0xffFFD953);
    case "อ.":
      return  const Color(0xffFFB8E3);
    case "พ.":
      return const Color(0xff6ADFBB);
    case "พฤ.":
      return const Color(0xffFFA25F);
    case "ศ.":
      return const Color(0xff85CCFF);
    case "ส.":
      return const Color(0xffCE90FF);
    case "อา.":
      return const Color(0xffFF5F5F);
    default:
      return const Color(0xffFF5F5F);
  }
}

PreferredSizeWidget tabData(TimeLineEntity data) {
  return Tab(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "ตารางกะ : ${data.pattern!.workingTypeName}",
          style: const TextStyle(fontSize: 17),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "เวลาทำงาน",
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 5,
            ),
            if (data.pattern!.isWorkingDay == 0) ...[
              Text(
                data.pattern!.nameShiftType ?? "",
                style: const TextStyle(fontSize: 17),
              )
            ] else if (data.holiday != null) ...[
              const Text(
                "วันหยุดประจำปี",
                style: TextStyle(fontSize: 17),
              )
            ] else ...[
              Text(
                "${data.pattern!.timeIn!.substring(0, 5)} - ${data.pattern!.timeOut!.substring(0, 5)}",
                style: const TextStyle(fontSize: 17),
              )
            ]
          ],
        )
      ],
    ),
  );
}

Widget showDate(TimeLineEntity data) {
  String dateTH = DateFormat('EEEE ที่  d  MMMM  yyyy').format(data.date!);
  return Text(dateTH, style: const TextStyle(color: Colors.black),
  );
}

Widget reuseContainer(String title,BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).devicePixelRatio*7,
      vertical: MediaQuery.of(context).devicePixelRatio*3,),
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "-",
                style: TextStyle(fontSize: 18),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget showDetail(TimeLineEntity data , BuildContext context) {
  bool isLeave = false;
  if(data.leave!.isNotEmpty){
    for(var i in data.leave!){
      if(i.isApprove == 1){
        isLeave = true;
        break;
      }
    }
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).devicePixelRatio*7,
            vertical: MediaQuery.of(context).devicePixelRatio*3,),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ]
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "เวลาเข้า/ออกงาน",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (isLeave) ...[
                    Row(children: [
                      SvgPicture.asset(
                        "assets/icons/break.svg",
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        data.leave![0].name ?? "",
                        style: const TextStyle(fontSize: 17),
                      ),
                      const SizedBox(
                        width: 5,
                      )
                    ],)
                  ]
                  else if (data.absent == true) ...[
                    Row(children: [
                      SvgPicture.asset(
                        "assets/icons/cancel.svg",
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "ขาดงาน",
                        style: TextStyle(fontSize: 17),
                      )
                    ])
                  ]
                  else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          data.attendance!.round1!.checkIn != null
                              ? Text(
                            "เข้า ${data.attendance!.round1!.checkIn!.attendanceTextTime}",
                            style: const TextStyle(fontSize: 18),
                          )
                              : const Text(
                            "เข้า -",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          data.attendance!.round1!.checkOut != null
                              ? Text(
                            "ออก ${data.attendance!.round1!.checkOut!.attendanceTextTime}",
                            style: const TextStyle(fontSize: 18),
                          )
                              : const Text(
                            "ออก -",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ],

                ],
              ),
              if(data.leave!.isEmpty && !data.absent!)...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    data.attendance!.round2!.checkIn != null
                        ? Text(
                      "เข้า ${data.attendance!.round2!.checkIn!.attendanceTextTime}",
                      style: const TextStyle(fontSize: 18),
                    )
                        : const Text(
                      "เข้า -",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    data.attendance!.round2!.checkOut != null
                        ? Text(
                      "ออก ${data.attendance!.round2!.checkOut!.attendanceTextTime}",
                      style: const TextStyle(fontSize: 18),
                    )
                        : const Text(
                      "ออก -",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                )
              ]

            ],
          ),
        ),
      ),
      // data.ot!.isNotEmpty?
      // OtStatus(data:data)
      // :reuseContainer("ค่าล่วงเวลา", "-", "-",context),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).devicePixelRatio*7,
          vertical: MediaQuery.of(context).devicePixelRatio*3,),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ]
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "สถานะ",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              StatusIconText(data: data,)
            ],
          ),
        ),
      ),
      data.isLate!?
      const DayStatus(title: "มาสาย", fontColor: Colors.red, bgColor: Color(0xffFFD7DB))
          :reuseContainer("มาสาย",context),
      data.isEarlyOut!?
      const DayStatus(title: "กลับก่อน", fontColor: Colors.red, bgColor: Color(0xffFFD7DB))
          :reuseContainer("กลับก่อน",context),
      SizedBox(
        height: MediaQuery.of(context).size.height*0.12,
      )
    ],
  );
}