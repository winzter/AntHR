import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/entities.dart';
import '../../pages/month_leave_list.dart';

class LeaveOverviewEachMonth extends StatelessWidget {
  final DateTime? date;
  final OverviewEntity? overviewData;

  const LeaveOverviewEachMonth({super.key, this.date, this.overviewData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => MonthLeaveList(date: date,overviewData:overviewData),));
        },
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("การลาทั้งหมด${date == null ? ' - ' : DateFormat(
                        "เดือนMMMM").format(date!)}",
                        style: const TextStyle(
                            color: Color(0xff757575),
                            fontSize: 18)),
                  ],
                ),
              ),
              const Expanded(
                  flex: 10,
                  child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Color(0xffc4c4c4),
                    ),),
            ],
          ),
        ),
      ),
    );
  }
}
