import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/payslip.dart';

class PayslipDetail extends StatefulWidget {
  final List<PayslipEntity> data;
  const PayslipDetail({super.key, required this.data});

  @override
  State<PayslipDetail> createState() => _PayslipDetailState();
}

class _PayslipDetailState extends State<PayslipDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.data.isNotEmpty) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "จ่ายสุทธิ       ",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "฿ ${NumberFormat("#,###.##").format(widget.data[0].totalEarnings! - widget.data[0].totalDeductions!)}",
                style: const TextStyle(color: Colors.white, fontSize: 27),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Column(
                    children: [
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
                        "เงินได้",
                        style: TextStyle(
                            color: Color(0xff94AFB6), fontSize: 15),
                      ),
                      Text(
                        "฿${NumberFormat("#,###.##").format(widget.data[0].totalEarnings!)}",
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
                    children: [
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
                      const Text("เงินหัก",
                          style: TextStyle(
                              color: Color(0xff94AFB6), fontSize: 15)),
                      Text(
                          "฿${NumberFormat("#,###.##").format(widget.data[0].totalDeductions)}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18))
                    ],
                  )
                ],
              ),
            ],
          )
        ] else ...[
          const Center(
              child: Text(
            "ไม่มีข้อมูล",
            style: TextStyle(color: Colors.white),
          ))
        ]
      ],
    );
  }
}
