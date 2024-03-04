import 'package:flutter/material.dart';
import '../../domain/entities/timeline_entity.dart';
import 'day_detail/day_detail_widgets.dart';

class StatusIconText extends StatelessWidget {
  final TimeLineEntity data;
  const StatusIconText({super.key, required this.data});

  String otApproveStatus(OtEntity data){
    if(data.isDoubleApproval == 1){
      if(data.isManagerLv2Approve == 1){
        return "อนุมัติ";
      }else if(data.isManagerLv2Approve == null){
        return "รออนุมัติ";
      }else{
        return "ไม่อนุมัติ";
      }
    }else{
      if(data.isManagerLv1Approve == 1){
        return "อนุมัติ";
      }
      else if(data.isManagerLv1Approve == null){
        return "รออนุมัติ";
      }else{
        return "ไม่อนุมัติ";
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    bool isIconCheck = false;
    if (data.leave!.isNotEmpty) {
      if (data.leave![0].isApprove == null) {
        isIconCheck = true;
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      child: Column(
        children: [
          if (data.leave != null && data.leave!.isNotEmpty && isIconCheck) ...[
            LeaveRequestDetail(leaveData: data.leave![0],)
          ],
          if (data.ot != null && data.ot!.isNotEmpty) ...[
            OtRequestDetail(e: data.ot![0],)
          ],
          if (data.requestTime != null && data.requestTime!.isNotEmpty) ...[
            RequestTimeDetail(e: data.requestTime![0],)
          ],
          if(data.requestTime == null && data.ot!.isEmpty && data.leave== null)...[
            const Text("-")
          ]
        ],
      ),
    );
  }
}