import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BenefitBox extends StatefulWidget {
  final String title;
  final num total;
  num profit1;
  num profit2;
  BenefitBox(
      {super.key,
      required this.title,
      required this.total,
      this.profit1 = 0,
      this.profit2 = 0});

  @override
  State<BenefitBox> createState() => _BenefitBoxState();
}

class _BenefitBoxState extends State<BenefitBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff275F77),
                Color.fromARGB(255, 45, 160, 126),
                Color(0xffEEAC19),
              ])),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.profit1 != 0
                    ? "+ ${NumberFormat("#,###.##").format(widget.profit1)}"
                    : "",
                style: const TextStyle(
                    color: Color(0xff6ADFBB), fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.profit2 != 0
                    ? "+ ${NumberFormat("#,###.##").format(widget.profit2)}"
                    : "",
                style: const TextStyle(
                    color: Color(0xff6ADFBB), fontSize: 16),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "รวม",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "฿ ${NumberFormat("#,###.##").format(widget.total)}",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
