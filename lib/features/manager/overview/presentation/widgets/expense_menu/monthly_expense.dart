import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class MonthlyExpense extends StatelessWidget {

  final String title;
  final String svgPath;
  final double rate;
  const MonthlyExpense({super.key, required this.title, required this.svgPath, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).devicePixelRatio * 5,
          vertical: MediaQuery.of(context).devicePixelRatio * 6),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xfff1a3a3),
                Color(0xffFF5F5F),
              ])),
      child: Stack(
        children: [
          Positioned(
              top: (title == "รายจ่ายค่าล่วงเวลา" || title =="จ่ายอื่นๆ")?0:-30,
              child: SvgPicture.asset(svgPath)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(title,style: const TextStyle(color: Colors.white,fontSize: 16),),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(NumberFormat("#,###.##").format(rate),style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
                  const Text(
                    " บาท",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
