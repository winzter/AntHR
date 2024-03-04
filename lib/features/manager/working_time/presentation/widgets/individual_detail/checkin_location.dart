import 'package:flutter/material.dart';
import '../../../../../../core/features/attendance/domain/entities/attendance_entity.dart';

class CheckInLocation extends StatelessWidget {
  final AttendanceEntity data;
  const CheckInLocation({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 50,
            child:  (data.attendance!.round1!.checkIn != null
                && data.holiday == null
                )
              ? Center(
                child: Text(data.attendance!.round1!.checkIn!.gpsLocationsName
                    ?? "เช็ค null",
            style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff757575)),),
              )
              : const Text(""),),
          Expanded(
            flex: 50,
            child: (data.attendance!.round1!.checkOut != null
                && data.holiday == null
                )
              ? Center(
                child: Text(data.attendance!.round1!.checkOut!.gpsLocationsName
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
