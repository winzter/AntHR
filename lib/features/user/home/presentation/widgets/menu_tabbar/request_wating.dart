import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/leave_provider.dart';
import 'waiting_listtile.dart';

class DateTimeWorkingWaiting extends StatefulWidget {
  const DateTimeWorkingWaiting({super.key});

  @override
  State<DateTimeWorkingWaiting> createState() => _DateTimeWorkingWaitingState();
}

class _DateTimeWorkingWaitingState extends State<DateTimeWorkingWaiting> {

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<WaitingProvider>(context,listen:true);
    if (data.leaveNotApprove.isNotEmpty || data.requestTimeNotApprove.isNotEmpty) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: (data.requestTimeNotApprove.length + data.leaveNotApprove.length) < 2?
        (data.requestTimeNotApprove.length + data.leaveNotApprove.length):2,
        itemBuilder: (context, index) {
          if (index < data.requestTimeNotApprove.length) {
            return WaitingLisTile(requestTime: data.requestTimeNotApprove[index], dataLeave: null,);
          } else {
            return WaitingLisTile(
                dataLeave: data.leaveHistory[(index - data.requestTime.length).abs()], requestTime: null,);
          }
        },
      );
    } else {
      return const Center(
          child: Text(
            "ไม่พบรายการรออนุมัติ",
            style: TextStyle(fontSize: 17),
          ));
    }
  }
}