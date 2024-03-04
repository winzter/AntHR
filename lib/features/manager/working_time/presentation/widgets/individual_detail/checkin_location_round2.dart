import 'package:flutter/material.dart';
import 'package:anthr/core/features/attendance/domain/entities/attendance_entity.dart';
class CheckInLocationRoundTwo extends StatelessWidget {
  final AttendanceEntity data;
  const CheckInLocationRoundTwo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 50,
            child:  (data.attendance!.round2!.checkIn != null && data.holiday == null)
                ? Center(
              child: Text(data.attendance!.round2!.checkIn!.gpsLocationsName
                  ?? "เช็ค null",
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff757575)),),
            )
                : const Text(""),),
          Expanded(
            flex: 50,
            child: (data.attendance!.round2!.checkOut != null && data.holiday == null)
                ? Center(
              child: Text(data.attendance!.round2!.checkOut!.gpsLocationsName
                  ?? "เช็ค null",
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(
                        0xff757575)),),
            )
                : const Text(""),)
        ],
      ),
    );
  }
}
