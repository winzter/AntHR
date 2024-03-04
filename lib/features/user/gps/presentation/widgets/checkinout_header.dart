import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class CheckInOutHeader extends StatelessWidget {
  const CheckInOutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_month,
                          color: Colors.blueGrey),
                      SizedBox(
                        width: 5,
                      ),
                      Text("วันที่", style: TextStyle(color: Colors.blueGrey, fontSize: 18)),
                    ],
                  ),
                  Text(
                    DateFormat('dd MMM yyyy').format(DateTime.now()),
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                          Icons.access_time_outlined,
                          color: Colors.blueGrey),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "เวลา",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                      ),
                    ],
                  ),
                  DigitalClock(
                    showSecondsDigit: false,
                    hourMinuteDigitTextStyle:
                    const TextStyle(
                        fontSize: 19,
                        color: Colors.black),
                    colon: const Text(":",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 19)),
                  )
                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}