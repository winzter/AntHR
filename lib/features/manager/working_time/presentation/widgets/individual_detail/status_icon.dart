import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/features/attendance/domain/entities/attendance_entity.dart';

class StatusIcon extends StatelessWidget {
  final AttendanceEntity data;
  const StatusIcon({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    bool isIconCheck = false;
    if (data.leave!.isNotEmpty) {
      if (data.leave![0].isApprove == null) {
        isIconCheck = true;
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: Row(
        children: [
          if (data.leave!.isNotEmpty && isIconCheck) ...[
            SvgPicture.asset("assets/icons/break.svg"),
            const SizedBox(
              width: 5,
              height: 5,
            ),
          ],
          if (data.ot!.isNotEmpty) ...[
            SvgPicture.asset("assets/icons/ot.svg"),
            const SizedBox(
              width: 5,
              height: 5,
            ),
          ],
          if (data.requestTime!.isNotEmpty) ...[
            SvgPicture.asset("assets/icons/guarantee.svg"),
            const SizedBox(
              width: 5,
              height: 5,
            ),
          ]
        ],
      ),
    );
  }
}
