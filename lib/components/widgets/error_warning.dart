import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class ErrorWarning extends StatelessWidget {
  final String errorMsg;
  const ErrorWarning({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ]
              ),
              child: Column(
                children: [
                  SvgPicture.asset("assets/icons/cancel.svg",width: 55,),
                  const SizedBox(height: 15),
                  const Text("เกิดข้อผิดพลาด",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          errorMsg,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}