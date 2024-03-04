import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardDayDetail extends StatefulWidget {
  final double sumOT;
  final double sumShiftMorning;
  final double sumShiftNoon;
  final double sumShiftNight;
  final double sumLoss;

  const CardDayDetail({super.key,required this.sumOT, required this.sumShiftMorning, required this.sumShiftNoon, required this.sumShiftNight, required this.sumLoss});

  @override
  State<CardDayDetail> createState() => _CardDayDetailState();
}

class _CardDayDetailState extends State<CardDayDetail> {


  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ค่าOT ฿ ${NumberFormat("#,###.##").format(widget.sumOT)}",
            style: const TextStyle(
                color: Colors.white, fontSize: 15),
          ),
          Text(
            "ค่าเข้ากะเช้า  ฿ ${NumberFormat("#,###.##").format(widget.sumShiftMorning)}",
            /* ****************************************************************************** */
            style: const TextStyle(
                color: Colors.white, fontSize: 15),
          )
        ],
      ),
      const SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ค่าเข้ากะบ่าย  ฿ ${NumberFormat("#,###.##").format(widget.sumShiftNoon)}",
            style: const TextStyle(
                color: Colors.white, fontSize: 15),
          ),
          Text(
            "ค่าเข้ากะค่ำ  ฿ ${NumberFormat("#,###.##").format(widget.sumShiftNight)}",
            /* ****************************************************************************** */
            style: const TextStyle(
                color: Colors.white, fontSize: 15),
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Column(
                children:  [
                  CircleAvatar(
                    backgroundColor: Color(0xff30B98F),
                    child: Icon(
                      Icons.arrow_downward_sharp,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "เงินได้สุทธิ",
                    style: TextStyle(
                        color: Color(0xff94AFB6),
                        fontSize: 15),
                  ),
                  Text(
                    "฿${NumberFormat("#,###.##").format(widget.sumShiftNight+widget.sumShiftNoon+widget.sumShiftMorning+widget.sumOT)}",
                    /* ****************************************************************************** */
                    style: const TextStyle(
                        color: Colors.white, fontSize: 18),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              const Column(
                children:  [
                  CircleAvatar(
                    backgroundColor: Color(0xffFF6575),
                    child: Icon(
                      Icons.arrow_upward_sharp,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "เงินหักสุทธิ",
                    style: TextStyle(
                        color: Color(0xff94AFB6),
                        fontSize: 15),
                  ),
                  Text(
                    "฿${NumberFormat("#,###.##").format(widget.sumLoss)}",
                    /* ****************************************************************************** */
                    style: const TextStyle(
                        color: Colors.white, fontSize: 18),
                  )
                ],
              )
            ],
          ),
        ],
      )
    ],);
  }
}