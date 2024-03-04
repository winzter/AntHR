import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/features/attendance/domain/entities/attendance_entity.dart';

class StatusIconText extends StatelessWidget {
  final AttendanceEntity data;
  const StatusIconText({super.key, required this.data});

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
      child: Column(
        children: [
          if (data.leave!= null && isIconCheck) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SvgPicture.asset("assets/icons/break.svg"),
              const SizedBox(
                width: 5,
              ),
              Text(data.leave![0].name!,style: const TextStyle(fontSize: 18),)
            ],),
          ],
          if (data.ot!.isNotEmpty) ...[
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SvgPicture.asset("assets/icons/ot.svg"),
              const SizedBox(
                width: 5,
              ),
              Text(data.ot![0].name!,style: const TextStyle(fontSize: 18),)
            ],)
          ],
          if (data.requestTime!.isNotEmpty) ...[
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SvgPicture.asset("assets/icons/guarantee.svg"),
              const SizedBox(
                width: 5,
              ),
              Text(data.requestTime![0].name??"ขอรับรองเวลาทำงาน",style: const TextStyle(fontSize: 18),)
            ],)
          ],
          if(data.requestTime!.isEmpty && data.ot!.isEmpty && data.leave== null)...[
            const Text("-",style: TextStyle())
          ]
        ],
      ),
    );
  }
}