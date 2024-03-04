import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../domain/entities/entities.dart';

class IsCheckInRoundTwo extends StatelessWidget {
  final TimeLineEntity data;
  const IsCheckInRoundTwo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
      child: Row(
        children: [
          Expanded(
            flex: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: data.attendance!.round2!.checkIn != null
                        ? const Color(0xffD8F2DC)
                        : Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        if (data.attendance!.round2!.checkIn != null)...[
                          if (data.attendance!.round2!.checkIn!.idAttendanceType == 1)...[
                            SvgPicture.asset("assets/icons/green_location.svg")
                          ]
                          else if (data.attendance!.round2!.checkIn!.idAttendanceType == 5)...[
                            SvgPicture.asset("assets/icons/green_barcode.svg")
                          ]
                          else if (data.attendance!.round2!.checkIn != null &&
                                data.attendance!.round2!.checkIn!.idAttendanceType == 4)...[
                              const Icon(
                                Icons.gps_fixed,
                                color: Color(0xff229A16),
                              )
                            ]
                            else...[
                                SvgPicture.asset("assets/icons/green_finger.svg"),
                              ]
                        ],
                        const SizedBox(width: 5),
                        Text(
                          (data.attendance!.round2!.checkIn != null && data.attendance!.round2!.checkIn!.attendanceTextTime != null)
                              ? data.attendance!.round2!.checkIn!.attendanceTextTime!
                              : "",
                          style: const TextStyle(
                            color: Color(0xff229A16),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: data.attendance!.round2!.checkOut != null
                        ? const Color(0xffFFD7DB)
                        : Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        if (data.attendance!.round2!.checkOut != null)...[
                          if (data.attendance!.round2!.checkOut!.idAttendanceType == 1)...[
                            SvgPicture.asset("assets/icons/red_location.svg")
                          ]
                          else if (data.attendance!.round2!.checkOut!.idAttendanceType == 5)...[
                            SvgPicture.asset("assets/icons/red_barcode.svg")
                          ]
                          else if (data.attendance!.round2!.checkOut != null &&
                                data.attendance!.round2!.checkOut!.idAttendanceType == 4)...[
                              const Icon(
                                Icons.gps_fixed,
                                color: Color(0xffB72136),
                              )
                            ]
                            else...[
                                SvgPicture.asset("assets/icons/red_finger.svg"),
                              ]
                        ],
                        const SizedBox(width: 5),
                        Text(
                          ( data.attendance!.round2!.checkOut != null
                              && data.attendance!.round2!.checkOut!.attendanceTextTime != null)
                              ? data.attendance!.round2!.checkOut!.attendanceTextTime!
                              : "",
                          style: const TextStyle(
                            color: Color(0xffB72136),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
