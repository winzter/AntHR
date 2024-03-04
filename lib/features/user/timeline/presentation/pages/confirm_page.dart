import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../../domain/entities/entities.dart';
import '../bloc/timeline_bloc.dart';
import '../widgets/appbar.dart';
import 'success_page.dart';

class ConfirmPage extends StatelessWidget {
  final TimelineBloc bloc = sl<TimelineBloc>();
  final bool isOTRequest;
  final CalculateTimeEntity result;
  final DateTime start;
  final List<PayrollSettingTimeLine> payrollData;
  final DateTime end;
  final String requestType;
  final ReasonsTimeLineRequest reasonType;
  final String note;
  final TimeLineEntity data;

  ConfirmPage({super.key,
    required this.data,
    required this.start,
    required this.end,
    required this.requestType,
    required this.reasonType,
    required this.note,
    required this.result,
    required this.isOTRequest,
    required this.payrollData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).devicePixelRatio * 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "วันที่ทำงาน: ${DateFormat('dd/MM/yyyy').format(data.date!)}",
                          style: const TextStyle(
                              fontSize: 17, color: Colors.grey),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "เวลาทำงาน: ${data.pattern!.workingTypeName!} "
                          "(${data.pattern!.timeIn!.substring(0, 5)} "
                          "- ${data.pattern!.timeOut!.substring(0, 5)})",
                          style: const TextStyle(
                              fontSize: 17, color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex:30,
                      child: Text("ประเภท :",
                        style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex:70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(requestType,
                            style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w400,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex:30,
                      child: Text("วันที่เริ่ม :",
                        style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex:70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(DateFormat("dd/MM/yyyy").format(start),
                            style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w400,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex:30,
                      child: Text("เวลาที่เริ่ม :",
                        style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex:70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(DateFormat("HH : mm").format(start),
                            style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w400,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex:30,
                      child: Text("วันที่สิ้นสุด:",
                        style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex:70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(DateFormat("dd/MM/yyyy").format(end),
                            style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w400,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex:45,
                      child: Text("เวลาที่สิ้นสุด :",
                        style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex:70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(DateFormat("HH : mm").format(end),
                            style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w400,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isOTRequest,
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio * 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex:40,
                        child: Text("จำนวนชั่วโมง :",
                          style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        flex:70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if(result.xWorkingMonthlyHoliday > 0)...[
                              Text("OT x ${payrollData[0].xWorkingMonthlyHoliday}    ${(result.xWorkingMonthlyHoliday/60).toStringAsFixed(2)} ชม.",
                                style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w400,),
                              ),
                            ],
                            if(result.xOT > 0)...[
                              Text("OT x ${payrollData[0].xOt}   ${(result.xOT/60).toStringAsFixed(2)} ชม.",
                                style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w400,),
                              ),
                            ],
                            if(result.xOTHoliday > 0)...[
                              Text("OT x ${payrollData[0].xOtHoliday}    ${(result.xOTHoliday/60).toStringAsFixed(2)} ชม.",
                                style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w400,),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex:35,
                      child: Text("เหตุผล :",
                        style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex:70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(reasonType.name.toString(),
                              style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w400,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex:40,
                      child: Text("เหตุผลเพิ่มเติม :",
                        style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex:50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(note==""?"-":note,
                              softWrap: true,
                              style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w400,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 10,
                    bottom: MediaQuery.of(context).devicePixelRatio * 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: const Color(0xff007AFE)),
                    onPressed: () {
                      ProfileProvider profileData = Provider.of<ProfileProvider>(context,listen: false);
                      bloc.add(SendTimeRequestData(
                          result: result,
                          idEmployee: profileData.profileData.idEmp!,
                          idRequestType: isOTRequest?2:1,
                          requestReason: reasonType.idRequestReason!,
                          otherReason: note,
                          start: start,
                          end: end,
                          workEndDate: data.date!,
                          note: note,
                          profileData: profileData.profileData));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                          SuccessPage(
                            isOTRequest: isOTRequest,
                            result: result,
                            start: start,
                            end: end,
                            requestType: requestType,
                            reasonType: reasonType,
                            note: note,
                            data: data,
                            bloc: bloc,
                            payrollData: payrollData,)));
                    },
                    child: const Text(
                      "ยืนยัน",
                      style: TextStyle(
                          color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
