import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/waiting_status_bloc.dart';
import '../../providers/radio_button_provider.dart';
import 'list_item.dart';

class ExpansionList extends StatefulWidget {
  final List<LeaveRequestManager> leaveData;
  final List<RequestTimeManager> requestTimeData;
  final List<WithdrawLeaveManager> withdrawData;
  final List<PayrollSetting> payrollSettingData;
  final List<dynamic> dataRequestTime;
  final List<dynamic> dataRequestOT;
  final WaitingStatusBloc bloc;

  const ExpansionList({super.key,
    required this.leaveData,
    required this.requestTimeData,
    required this.withdrawData,
    required this.dataRequestTime,
    required this.dataRequestOT,
    required this.payrollSettingData,
    required this.bloc,});

  @override
  State<ExpansionList> createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ExpansionList> {

  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<ManagerRadioButtonProvider>(context);
    return Expanded(
      child:  ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: (() {
           if (radioProvider.type == "ขอลา" && widget.leaveData.isNotEmpty) {
              return widget.leaveData.length;
            }
            else if (radioProvider.type == "ขอรับรองเวลาทำงาน" && widget.requestTimeData.isNotEmpty) {
              return widget.dataRequestTime.length;
            }
            else if (radioProvider.type == "ขอทำงานล่วงเวลา" && widget.requestTimeData.isNotEmpty) {
              return widget.dataRequestOT.length;
            } // เหลือรอเปลี่ยนกะ
            else {
             return 0;
            }
          })(),
          itemBuilder: (context, index) {
            if (radioProvider.type == "ขอลา") {
              return widget.leaveData.isEmpty?const Center(child: Text("ไม่พบข้อมูล",style: TextStyle(color: Colors.black),),):ListItems(
                  index: index,
                  dataLeave: widget.leaveData[index],
                  withdrawData: widget.withdrawData,
                  // type:radioProvider.type,
                  payrollSettingData: widget.payrollSettingData,
                  bloc: widget.bloc,
                  isSelectAll: radioProvider.isSelectAll,
              );
            }
            else if (radioProvider.type == "ขอรับรองเวลาทำงาน") {
              return ListItems(
                index: index,
                requestTime: widget.dataRequestTime[index],
                withdrawData: widget.withdrawData,
                // type:radioProvider.type,
                payrollSettingData: widget.payrollSettingData,
                bloc: widget.bloc,
                isSelectAll: radioProvider.isSelectAll,
              );
            }
            else if(radioProvider.type == "ขอทำงานล่วงเวลา"){
              return ListItems(
                index: index,
                requestTime: widget.dataRequestOT[index],
                withdrawData: widget.withdrawData,
                // type:radioProvider.type,
                payrollSettingData: widget.payrollSettingData,
                bloc: widget.bloc,
                isSelectAll: radioProvider.isSelectAll,
              );
            }
            return Container();
          })
    );
  }
}
