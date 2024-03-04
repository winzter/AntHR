import 'package:anthr/features/user/timeline/domain/entities/reason_entity.dart';
import 'package:day/day.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../injection_container.dart';
import '../../domain/entities/entities.dart';
import '../bloc/timeline_bloc.dart';
import '../widgets/appbar.dart';
import '../widgets/time_line_body/ot_hours_show.dart';
import 'confirm_page.dart';

class RequestTimeForm extends StatefulWidget {
  final int index;
  final TimeLineEntity data;
  final List<TimeLineEntity> attendanceData;
  final List<ReasonsTimeLineRequest> reasons;
  final List<PayrollSettingTimeLine> payrollData;
  const RequestTimeForm({
    super.key,
    required this.index,
    required this.data,
    required this.attendanceData,
    required this.reasons,
    required this.payrollData,
  });

  @override
  State<RequestTimeForm> createState() => _RequestTimeFormState();
}

class _RequestTimeFormState extends State<RequestTimeForm> {
  final TimelineBloc timelineBloc = sl<TimelineBloc>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  List<String> hours = List.generate(24, (index) => index.toString().padLeft(2, '0'));
  final List<String> requestTypes = ["ขอรับรองเวลาทำงาน", "ขอทำงานล่วงเวลา"];
  List<String> minutes = List.generate(60, (index) => index.toString().padLeft(2, '0'));

  // * input for make time request.
  String? requestType;
  ReasonsTimeLineRequest? reasonType;
  List<String?> startTime = [null, null];
  List<String?> endTime = [null, null];
  DateTime? startDate;
  DateTime? endDate;
  String note = "";
  bool isFirstCheck = false;
  bool? isOT;
  CalculateTimeEntity? calculateTimeValue;

  Map<String,dynamic> err = {
    "isErr":false,
    "errMsg":null,
  };

  Future<void> pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: widget.data.date!,
      firstDate: widget.data.date!,
      lastDate: widget.attendanceData[widget.index + 2].date!,
    );
    if (date != null) {
      setState(() {
        if (isStartDate) {
          startDate = date;
          startDateController.text = DateFormat('dd/MM/yyyy').format(date);
        } else {
          endDate = date;
          endDateController.text = DateFormat('dd/MM/yyyy').format(date);
        }
      });
    }
  }

  bool checkOverlapWorkingTime(
      List<TimeLineEntity> data ,
      DateTime startDate ,
      DateTime endDate,
      List<String?>timeStart,
      List<String>timeEnd){

    // Day startTimeDate = Day.fromDateTime(DateTime(
    //   startDate.year,
    //   startDate.month,
    //   startDate.day,
    //   int.parse(timeStart[0]!),
    //   int.parse(timeStart[1]!),
    // ));
    // Day endTimeDate = Day.fromDateTime(DateTime(
    //   endDate.year,
    //   endDate.month,
    //   endDate.day,
    //   int.parse(timeEnd[0]),
    //   int.parse(timeEnd[1]),
    // ));
    // int indexStart = data.indexWhere((element) => element.date == startDate);
    // int indexEnd = data.indexWhere((element) => element.date == endDate);
    //
    // Day preStart = Day.fromDateTime(DateTime(
    //   data[indexStart-1].date!.year,
    //   data[indexStart-1].date!.month,
    //   data[indexStart-1].date!.day,
    //   int.parse(data[indexStart-1].pattern!.timeIn!.substring(0,2)),
    //   int.parse(data[indexStart-1].pattern!.timeIn!.substring(3,5)),
    // ));
    // Day preEnd = preStart.add(data[indexStart-1].pattern!.workingHours!, "minute")!;
    //
    // int curIsWorking = (data[indexStart].pattern!.isWorkingDay == 1
    //     && data[indexStart].holiday == null
    //     && !data[indexStart].isCompensation!)? 1: 0;
    // Day curStart = Day.fromDateTime(DateTime(
    //   data[indexStart].date!.year,
    //   data[indexStart].date!.month,
    //   data[indexStart].date!.day,
    //   int.parse(data[indexStart].pattern!.timeIn!.substring(0,2)),
    //   int.parse(data[indexStart].pattern!.timeIn!.substring(3,5)),
    // ));
    // Day curEnd = curStart.add(data[indexStart].pattern!.workingHours!, "minute")!;
    //
    // int nextIsWorking = (data[endDate.day == startDate.day?indexEnd+1:indexEnd].pattern!.isWorkingDay == 1
    //     && data[endDate.day == startDate.day?indexEnd+1:indexEnd].holiday == null
    //     && !data[endDate.day == startDate.day?indexEnd+1:indexEnd].isCompensation!)? 1: 0;
    // Day nextStart = Day.fromDateTime(DateTime(
    //   data[endDate.day == startDate.day?indexEnd+1:indexEnd].date!.year,
    //   data[endDate.day == startDate.day?indexEnd+1:indexEnd].date!.month,
    //   data[endDate.day == startDate.day?indexEnd+1:indexEnd].date!.day,
    //   int.parse(data[endDate.day == startDate.day?indexEnd+1:indexEnd].pattern!.timeIn!.substring(0,2)),
    //   int.parse(data[endDate.day == startDate.day?indexEnd+1:indexEnd].pattern!.timeIn!.substring(3,5)),
    // ));
    // Day nextEnd = nextStart.add(data[endDate.day == startDate.day?indexEnd+1:indexEnd].pattern!.workingHours!, "minute")!;
    //
    // if(startDate == endDate){
    //   if(curIsWorking == 1){
    //     if(((startTimeDate.isAfter(curStart) && startTimeDate.isBefore(curEnd))
    //         || startTimeDate == curStart)
    //         || ((endTimeDate.isBefore(curEnd) && endTimeDate.isAfter(curStart))
    //             || endTimeDate == curEnd || endTimeDate.isAfter(nextStart))){
    //       log("${ nextStart}");
    //         return true;
    //     }
    //     return false;
    //   }
    //   return false;
    // }
    // else if(startDate.isBefore(endDate)) {
    //   if(curIsWorking == 0 && nextIsWorking == 0){
    //     return false;
    //   }
    //   else if(curIsWorking == 0 && nextIsWorking == 1){
    //     if(endTimeDate.isAfter(nextStart)){
    //       return true;
    //     }
    //     return false;
    //   }
    //   else if(curIsWorking == 1 && nextIsWorking == 0){
    //     if(((startTimeDate.isAfter(curStart) && startTimeDate.isBefore(curEnd))
    //         || startTimeDate == curStart)
    //         || ((endTimeDate.isBefore(curEnd) && endTimeDate.isAfter(curStart)) || endTimeDate == curEnd)){
    //       return true;
    //     }
    //     return false;
    //   }
    //   else{
    //     if(((startTimeDate.isAfter(curStart) && startTimeDate.isBefore(curEnd))
    //         || startTimeDate == curStart)
    //         || ((endTimeDate.isBefore(curEnd) && endTimeDate.isAfter(curStart)) || endTimeDate == curEnd)){
    //       return true;
    //     }
    //     else if((((startTimeDate.isAfter(nextStart) && startTimeDate.isBefore(nextEnd))
    //         || startTimeDate == nextStart || startTimeDate.isBefore(preEnd))
    //         || ((endTimeDate.isBefore(curEnd) && endTimeDate.isAfter(curStart)) || endTimeDate == nextEnd))){
    //       return true;
    //     }
    //   }
    //   return false;
    // }
    return true;
  }

  List<DropdownMenuItem<ReasonsTimeLineRequest>> reasons(List<ReasonsTimeLineRequest> items) {
    final List<DropdownMenuItem<ReasonsTimeLineRequest>> menuItems = [];
    for (final ReasonsTimeLineRequest item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<ReasonsTimeLineRequest>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                item.name!,
                style: const TextStyle(
                  fontSize: 18,fontFamily: 'kanit'
                ),
              ),
            ),
          ),
        ],
      );
    }
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    isFirstCheck = widget.data.attendance!.round1!.checkOut != null
        && widget.data.attendance!.round1!.checkIn != null;
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).devicePixelRatio * 10),
            child: Form(
              key: formKey,
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
                              "วันที่ทำงาน: ${DateFormat('dd/MM/yyyy').format(widget.data.date!)}",
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.grey),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "เวลาทำงาน: ${widget.data.pattern!.workingTypeName!} "
                              "(${widget.data.pattern!.timeIn!.substring(0, 5)} "
                              "- ${widget.data.pattern!.timeOut!.substring(0, 5)})",
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.grey),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ประเภท",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                          // width: 250,
                          child: DropdownButtonFormField2(
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                errorStyle: TextStyle(fontSize: 15),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "เลือกประเภทคำขอ";
                                }
                                else if(reasonType == "ขอรับรองเวลาทำงาน"
                                    && widget.attendanceData.any((element) => element.date == startDate && element.requestTime != null))
                                {
                                  return "มีรายการคำขออยู่แล้ว";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                              hint: const Text(
                                "เลือกประเภทคำขอ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey,fontFamily: 'kanit'),
                              ),
                              isExpanded: true,
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              items: requestTypes
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(fontSize: 18,fontFamily: 'kanit'),
                                    ));
                              }).toList(),
                              onChanged: (String? value) {
                                DateTime start;
                                DateTime end;
                                requestType = value!;
                                reasonType = null;
                                setState(() {
                                  if(value == "ขอทำงานล่วงเวลา"){
                                    if(isFirstCheck && widget.data.pattern!.isWorkingDay == 1){
                                      start = widget.data.attendance!.round1!.checkIn!.attendanceDateTime!;
                                      end = widget.data.attendance!.round1!.checkOut!.attendanceDateTime!;
                                      startDateController.text =
                                          DateFormat("dd/MM/yyyy").format(start);
                                      endDateController.text =
                                          DateFormat("dd/MM/yyyy").format(end);
                                      startDate = DateTime(
                                          start.year, start.month, start.day);
                                      endDate = DateTime(
                                          end.year, end.month, end.day);
                                      startTime.insert(0, widget.data.pattern!.timeOut!.substring(0, 2));
                                      startTime.insert(1, widget.data.pattern!.timeOut!.substring(3, 5));
                                      endTime.insert(0, widget.data.attendance!.round1!.checkOut!.attendanceTextTime!.substring(0, 2));
                                      endTime.insert(1, widget.data.attendance!.round1!.checkOut!.attendanceTextTime!.substring(3));
                                    }
                                    else if(widget.data.pattern!.isWorkingDay == 0 || widget.data.holiday != null){
                                      start = widget.data.date!;
                                      startDateController.text = DateFormat("dd/MM/yyyy").format(start);
                                      endDateController.text = DateFormat("dd/MM/yyyy").format(start);
                                      startDate = DateTime(start.year, start.month, start.day);
                                      endDate = DateTime(start.year, start.month, start.day);
                                      startTime[0] = widget.data.pattern!.timeIn!.substring(0, 2);
                                      startTime[1] = widget.data.pattern!.timeIn!.substring(3, 5);
                                      endTime[0] = widget.data.pattern!.timeOut!.substring(0, 2);
                                      endTime[1] = widget.data.pattern!.timeOut!.substring(3, 5);
                                    }
                                    else{
                                      start = widget.data.date!;
                                      startDateController.text = DateFormat("dd/MM/yyyy").format(start);
                                      endDateController.text = DateFormat("dd/MM/yyyy").format(start);
                                      startDate = DateTime(start.year, start.month, start.day);
                                      endDate = DateTime(start.year, start.month, start.day);
                                      startTime[0] = widget.data.pattern!.timeOut!.substring(0, 2);
                                      startTime[1] = widget.data.pattern!.timeOut!.substring(3, 5);
                                    }
                                    if (startDate != null &&
                                        endDate != null &&
                                        endTime[0] != null &&
                                        endTime[1] != null &&
                                        startTime[0] != null &&
                                        startTime[1] != null) {
                                      DateTime startRequestDate = DateTime(
                                          startDate!.year,
                                          startDate!.month,
                                          startDate!.day,
                                          int.parse(startTime[0]!),
                                          int.parse(startTime[1]!));
                                      DateTime endRequestDate = DateTime(
                                          endDate!.year,
                                          endDate!.month,
                                          endDate!.day,
                                          int.parse(endTime[0]!),
                                          int.parse(endTime[1]!));
                                      calculateTimeValue = calculateOT(
                                          startRequestDate,
                                          endRequestDate,
                                          widget.attendanceData,
                                          2,
                                          startDate!);
                                    }

                                    // int afterWorkTimeHour = int.parse(widget.data.pattern!.timeOut!.substring(0,2));
                                    // int afterWorkTimeMinute = int.parse(widget.data.pattern!.timeOut!.substring(3,5));
                                    // startDateController.text = DateFormat("dd/MM/yyyy").format(widget.data.date!);
                                    // endDateController.text = DateFormat("dd/MM/yyyy").format(widget.data.date!);
                                    // endDate = widget.data.date!;
                                    // startDate = widget.data.date!;
                                    // startTime.insert(0, afterWorkTimeHour.toString());
                                    // startTime.insert(1, afterWorkTimeMinute.toString()) ;
                                  }
                                  else{
                                    startDateController.text = "";
                                    endDateController.text = "";
                                    startDate = null;
                                    startTime[0] = null;
                                    startTime[1] = null;
                                    endTime[0] = null;
                                    endTime[1] = null;
                                  }
                                });

                              }),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "วันที่เริ่ม",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                          child: TextFormField(
                            onTap: () => pickDate(context, true),
                            controller: startDateController,
                            readOnly: true,
                            style: const TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "เลือกวันที่";
                              }else if( endDate != null ){
                                if(endDate!.isBefore(startDate!)){
                                  return "กรอกวันที่ไม่ถูกต้อง";
                                }
                              }
                              // else if(requestType == "ขอทำงานล่วงเวลา"
                              //     && startDate != null && endDate != null){
                              //   if(checkOverlapWorkingTime(widget.attendanceData,startDate!,endDate!,startTime,endTime)){
                              //     return "ไม่สามารถทำรายการในเวลาทำงานปกติได้";
                              //   }
                              //
                              // }
                              return null;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                suffixIcon: Icon(Icons.calendar_month),
                                hintText: "วัน/เดือน/ปี",
                                hintStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15))),
                                errorStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "เวลาที่เริ่ม",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField2(
                                  iconStyleData: const IconStyleData(
                                      icon: Icon(Icons.access_time_outlined)),
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    errorStyle: TextStyle(fontSize: 14),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(15))),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "เลือกชั่วโมง";
                                    }
                                    else if(startDate != null && endDate != null && startTime[0] != null && startTime[1] != null){
                                      if(DateTime(endDate!.year,endDate!.month,endDate!.day,int.parse(endTime[0]!),int.parse(endTime[1]!))
                                          .isBefore(DateTime(startDate!.year,startDate!.month,startDate!.day,int.parse(startTime[0]!),int.parse(startTime[1]!)))
                                      ){
                                        return "กรอกเวลาไม่ถูกต้อง";
                                      }
                                    }
                                    // else if(requestType == "ขอทำงานล่วงเวลา"
                                    //     && startDate != null && endDate != null && startTime[0]!=null && startTime[1]!=null){
                                    //   if(checkOverlapWorkingTime(widget.attendanceData,startDate!,endDate!,startTime,endTime)){
                                    //     return "ไม่สามารถทำรายการในเวลาทำงานปกติได้";
                                    //   }
                                    // }
                                    return null;
                                  },
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  hint: const Text(
                                    "ชั่วโมง",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey,fontFamily: 'kanit'),
                                  ),
                                  value: startTime[0],
                                  isExpanded: true,
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  items: hours.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 18,fontFamily: 'kanit'),
                                        ));
                                  }).toList(),
                                  onChanged: (String? value) {
                                    startTime[0] = value!;
                                    if ((startDate != null &&
                                        endDate != null &&
                                        endTime[0] != null &&
                                        endTime[1] != null &&
                                        startTime[0] != null &&
                                        startTime[1] != null) && requestType == "ขอทำงานล่วงเวลา") {
                                      DateTime startRequestDate = DateTime(
                                          startDate!.year,
                                          startDate!.month,
                                          startDate!.day,
                                          int.parse(startTime[0]!),
                                          int.parse(startTime[1]!));
                                      DateTime endRequestDate = DateTime(
                                          endDate!.year,
                                          endDate!.month,
                                          endDate!.day,
                                          int.parse(endTime[0]!),
                                          int.parse(endTime[1]!));
                                      calculateTimeValue = calculateOT(
                                          startRequestDate,
                                          endRequestDate,
                                          widget.attendanceData,
                                          2,
                                          startDate!);
                                    }
                                    setState((){});
                                  }),
                            ),
                            const Text(
                              "  ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: DropdownButtonFormField2(
                                  iconStyleData: const IconStyleData(
                                      icon: Icon(Icons.access_time_outlined)),
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    errorStyle: TextStyle(fontSize: 14),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(15))),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "เลือกนาที";
                                    }else if(
                                     startDate != null && endDate != null && startTime[0] != null && startTime[1] != null
                                    ){
                                      if(DateTime(endDate!.year,endDate!.month,endDate!.day,int.parse(endTime[0]!),int.parse(endTime[1]!))
                                          .isBefore(DateTime(startDate!.year,startDate!.month,startDate!.day,int.parse(startTime[0]!),int.parse(startTime[1]!)))){
                                        return "กรอกเวลาไม่ถูกต้อง";
                                      }
                                    }
                                    // else if(requestType == "ขอทำงานล่วงเวลา"
                                    //     && startDate != null && endDate != null && startTime[0] != null && startTime[1] != null){
                                    //   if(checkOverlapWorkingTime(widget.attendanceData,startDate!,endDate!,startTime,endTime!)){
                                    //     return "ไม่สามารถทำรายการในเวลาทำงานปกติได้";
                                    //   }
                                    //
                                    // }
                                    return null;
                                  },
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  hint: const Text(
                                    "นาที",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey,fontFamily: 'kanit'),
                                  ),
                                  isExpanded: true,
                                  value: startTime[1],
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  items: minutes.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 18,fontFamily: 'kanit'),
                                        ));
                                  }).toList(),
                                  onChanged: (String? value) {
                                    startTime[1] = value!;
                                    if ((startDate != null &&
                                        endDate != null &&
                                        endTime[0] != null &&
                                        endTime[1] != null &&
                                        startTime[0] != null &&
                                        startTime[1] != null) && requestType == "ขอทำงานล่วงเวลา") {
                                      DateTime startRequestDate = DateTime(
                                          startDate!.year,
                                          startDate!.month,
                                          startDate!.day,
                                          int.parse(startTime[0]!),
                                          int.parse(startTime[1]!));
                                      DateTime endRequestDate = DateTime(
                                          endDate!.year,
                                          endDate!.month,
                                          endDate!.day,
                                          int.parse(endTime[0]!),
                                          int.parse(endTime[1]!));
                                      calculateTimeValue = calculateOT(
                                          startRequestDate,
                                          endRequestDate,
                                          widget.attendanceData,
                                          2,
                                          startDate!);
                                    }
                                    setState((){});
                                  }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "วันที่สิ้นสุด",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                          child: TextFormField(
                            onTap: () => pickDate(context, false),
                            controller: endDateController,
                            readOnly: true,
                            style: const TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "เลือกวันที่";
                              }else if(startDate!= null && endDate != null){
                                if(endDate!.isBefore(startDate!)){
                                  return "กรอกวันที่ไม่ถูกต้อง";
                                }

                              }
                              // else if(requestType == "ขอทำงานล่วงเวลา"
                              //     && startDate != null && endDate != null && startTime[0]!=null &&startTime[1] != null){
                              //   if(checkOverlapWorkingTime(widget.attendanceData,startDate!,endDate!,startTime,endTime!)){
                              //     return "ไม่สามารถทำรายการในเวลาทำงานปกติได้";
                              //   }
                              //
                              // }
                              return null;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                suffixIcon: Icon(Icons.calendar_month),
                                hintText: "วัน/เดือน/ปี",
                                hintStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                errorStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "เวลาที่สิ้นสุด",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(
                              // height: 35,
                              // width: 120,
                              child: DropdownButtonFormField2(
                                value: endTime[0],
                                  iconStyleData: const IconStyleData(
                                      icon: Icon(Icons.access_time_outlined)),
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    errorStyle: TextStyle(fontSize: 14),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(15))),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "เลือกชั่วโมง";
                                    }
                                    else if(startDate != null && endDate != null){
                                      if(
                                      DateTime(endDate!.year,endDate!.month,endDate!.day,int.parse(endTime[0]!),int.parse(endTime[1]!))
                                          .isBefore(DateTime(startDate!.year,startDate!.month,startDate!.day,int.parse(startTime[0]!),int.parse(startTime[1]!)))
                                      ){
                                        return "กรอกเวลาไม่ถูกต้อง";
                                      }

                                    }
                                    // else if(requestType == "ขอทำงานล่วงเวลา"
                                    //     && checkOverlapWorkingTime(widget.attendanceData,startDate!,endDate!,startTime,endTime)){
                                    //   return "ไม่สามารถทำรายการในเวลาทำงานปกติได้";
                                    // }
                                    return null;
                                  },
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  hint: const Text(
                                    "ชั่วโมง",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey,fontFamily: 'kanit'),
                                  ),
                                  isExpanded: true,
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  items: hours.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 18,fontFamily: 'kanit'),
                                        ));
                                  }).toList(),
                                  onChanged: (String? value) {
                                    endTime[0] = value!;
                                    if ((startDate != null &&
                                        endDate != null &&
                                        endTime[0] != null &&
                                        endTime[1] != null &&
                                        startTime[0] != null &&
                                        startTime[1] != null) && requestType == "ขอทำงานล่วงเวลา") {
                                      DateTime startRequestDate = DateTime(
                                          startDate!.year,
                                          startDate!.month,
                                          startDate!.day,
                                          int.parse(startTime[0]!),
                                          int.parse(startTime[1]!));
                                      DateTime endRequestDate = DateTime(
                                          endDate!.year,
                                          endDate!.month,
                                          endDate!.day,
                                          int.parse(endTime[0]!),
                                          int.parse(endTime[1]!));
                                      calculateTimeValue = calculateOT(
                                          startRequestDate,
                                          endRequestDate,
                                          widget.attendanceData,
                                          2,
                                          startDate!);
                                    }
                                    setState((){});
                                  }),
                            ),
                            const Text(
                              "  ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              // height: 35,
                              // width: 120,
                              child: DropdownButtonFormField2(
                                  value: endTime[1],
                                  iconStyleData: const IconStyleData(
                                      icon: Icon(Icons.access_time_outlined)),
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    errorStyle: TextStyle(fontSize: 14),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(15))),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "เลือกนาที";
                                    }else if(startDate != null && endDate != null){
                                      if(
                                          DateTime(endDate!.year,endDate!.month,endDate!.day,int.parse(endTime[0]!),int.parse(endTime[1]!))
                                              .isBefore(DateTime(startDate!.year,startDate!.month,startDate!.day,int.parse(startTime[0]!),int.parse(startTime[1]!)))
                                      ){
                                        return "กรอกเวลาไม่ถูกต้อง";
                                      }
                                    }
                                    // else if(requestType == "ขอทำงานล่วงเวลา"
                                    //     && checkOverlapWorkingTime(widget.attendanceData,startDate!,endDate!,startTime,endTime)){
                                    //   return "ไม่สามารถทำรายการในเวลาทำงานปกติได้";
                                    // }
                                    return null;
                                  },
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  hint: const Text(
                                    "นาที",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey,fontFamily: 'kanit'),
                                  ),
                                  isExpanded: true,
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  items: minutes.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 18,fontFamily: 'kanit'),
                                        ));
                                  }).toList(),
                                  onChanged: (String? value) {
                                    endTime[1] = value!;
                                    if ((startDate != null &&
                                        endDate != null &&
                                        endTime[0] != null &&
                                        endTime[1] != null &&
                                        startTime[0] != null &&
                                        startTime[1] != null) && requestType == "ขอทำงานล่วงเวลา") {
                                      DateTime startRequestDate = DateTime(
                                          startDate!.year,
                                          startDate!.month,
                                          startDate!.day,
                                          int.parse(startTime[0]!),
                                          int.parse(startTime[1]!));
                                      DateTime endRequestDate = DateTime(
                                          endDate!.year,
                                          endDate!.month,
                                          endDate!.day,
                                          int.parse(endTime[0]!),
                                          int.parse(endTime[1]!));
                                      calculateTimeValue = calculateOT(
                                          startRequestDate,
                                          endRequestDate,
                                          widget.attendanceData,
                                          2,
                                          startDate!);
                                    }
                                    setState((){});
                                  }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "เหตุผล",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                          // width: 250,
                          child: DropdownButtonFormField2<ReasonsTimeLineRequest>(
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                errorStyle: TextStyle(fontSize: 14),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                              value: reasonType,
                              validator: (value) {
                                if (value == null) {
                                  return "เลือกเหตุผล";
                                }
                                else if(
                                requestType == "ขอทำงานล่วงเวลา"?
                                widget.attendanceData.any((element) =>
                                element.date == startDate
                                    && element.ot!.isNotEmpty
                                    && element.ot!.any((element) => element.reasonName == reasonType!.name!)):false)
                                {
                                  return "มีเหตุผลนี้อยู่แล้ว";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                              hint: const Text(
                                "เลือกเหตุผล",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey,fontFamily: 'kanit'),
                              ),
                              isExpanded: true,
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              items: reasons(widget.reasons),
                              onChanged: (ReasonsTimeLineRequest? value) {
                                reasonType = value!;
                                if (startDate != null &&
                                    endDate != null &&
                                    endTime[0] != null &&
                                    endTime[1] != null &&
                                    startTime[0] != null &&
                                    startTime[1] != null) {
                                  DateTime startRequestDate = DateTime(
                                      startDate!.year,
                                      startDate!.month,
                                      startDate!.day,
                                      int.parse(startTime[0]!),
                                      int.parse(startTime[1]!));
                                  DateTime endRequestDate = DateTime(
                                      endDate!.year,
                                      endDate!.month,
                                      endDate!.day,
                                      int.parse(endTime[0]!),
                                      int.parse(endTime[1]!));
                                  calculateTimeValue = calculateOT(
                                      startRequestDate,
                                      endRequestDate,
                                      widget.attendanceData,
                                      2,
                                      startDate!);
                                }
                                setState(() {

                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "เหตุผลเพิ่มเติม",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                          // height: 35,
                          // width: 250,
                          child: TextFormField(
                            maxLines: 5,
                            style: const TextStyle(),
                            onChanged: (String text){
                              note = text;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                hintText: "หมายเหตุเพิ่มเติม",
                                hintStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                errorStyle: TextStyle()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (calculateTimeValue != null && requestType == "ขอทำงานล่วงเวลา") ...[
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "จำนวนชั่วโมง",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          if(!err['isErr'])...[
                            if (calculateTimeValue!.xOT != 0)
                              OTHoursShow(
                                title: 'OT x ${widget.payrollData[0].xOt}',
                                otValue:
                                "${(calculateTimeValue!.xOT / 60).toStringAsFixed(2)} ชม.",
                              ),
                            if (calculateTimeValue!.xWorkingMonthlyHoliday != 0)
                              OTHoursShow(
                                title: 'OT x ${widget.payrollData[0].xWorkingMonthlyHoliday}',
                                otValue:
                                "${(calculateTimeValue!.xWorkingMonthlyHoliday / 60).toStringAsFixed(2)} ชม.",
                              ),
                            if (calculateTimeValue!.xWorkingDailyHoliday != 0)
                              OTHoursShow(
                                title: 'OT x ${widget.payrollData[0].xWorkingDailyHoliday}',
                                otValue:
                                "${(calculateTimeValue!.xWorkingDailyHoliday / 60).toStringAsFixed(2)} ชม.",
                              ),
                            if (calculateTimeValue!.xOTHoliday != 0)
                              OTHoursShow(
                                title: 'OT x ${widget.payrollData[0].xOtHoliday}',
                                otValue:
                                "${(calculateTimeValue!.xOTHoliday / 60).toStringAsFixed(2)} ชม.",
                              ),
                          ]
                          else...[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).devicePixelRatio * 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    err['errMsg'],
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w500,color: Colors.red),
                                  ),
                                ],
                              ),
                            )
                          ]
                        ],
                      ),
                    )
                  ],
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10,
                        bottom: MediaQuery.of(context).devicePixelRatio * 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor:err["isErr"]?Colors.grey: const Color(0xff007AFE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate() && !err["isErr"]) {
                            DateTime startRequestDate = DateTime(
                                startDate!.year,
                                startDate!.month,
                                startDate!.day,
                                int.parse(startTime[0]!),
                                int.parse(startTime[1]!));
                            DateTime endRequestDate = DateTime(
                                endDate!.year,
                                endDate!.month,
                                endDate!.day,
                                int.parse(endTime[0]!),
                                int.parse(endTime[1]!));
                            var result =  calculateOT(
                                startRequestDate,
                                endRequestDate,
                                widget.attendanceData,
                                2,
                                startDate!
                            );
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ConfirmPage(
                                data: widget.data,
                                start:startRequestDate,
                                end:endRequestDate,
                                requestType: requestType!,
                                reasonType: reasonType!,
                                note: note,
                                result: result,
                                isOTRequest: requestType == "ขอทำงานล่วงเวลา",
                                payrollData: widget.payrollData,
                              );
                            }));
                          }
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }

  CalculateTimeEntity calculateOT(
      DateTime start,
      DateTime end,
      List<TimeLineEntity> attendanceData,
      int idPaymentType,
      DateTime now
      ) {
    Day startTime = Day.fromDateTime(start);
    Day endTime = Day.fromDateTime(end);

    int index = attendanceData.indexWhere((element) => element.date == now);

    int preIsWorking = (attendanceData[index].pattern!.isWorkingDay == 1
        && attendanceData[index].holiday == null) ? 1: 0;
    Day preStart = Day.fromDateTime(DateTime(
      attendanceData[index-1].date!.year,
      attendanceData[index-1].date!.month,
      attendanceData[index-1].date!.day,
      int.parse(attendanceData[index-1].pattern!.timeIn!.substring(0,2)),
      int.parse(attendanceData[index-1].pattern!.timeIn!.substring(3,5)),
    ));
    Day preEnd = preStart.add(attendanceData[index-1].pattern!.workingHours!, "minute")!;
    int prePeriod = attendanceData[index-1].pattern!.period!;

    int curIsWorking = (attendanceData[index].pattern!.isWorkingDay == 1
        && attendanceData[index].holiday == null)? 1: 0;
    Day curStart = Day.fromDateTime(DateTime(
      attendanceData[index].date!.year,
      attendanceData[index].date!.month,
      attendanceData[index].date!.day,
      int.parse(attendanceData[index].pattern!.timeIn!.substring(0,2)),
      int.parse(attendanceData[index].pattern!.timeIn!.substring(3,5)),
    ));
    Day curEnd = curStart.add(attendanceData[index].pattern!.workingHours!, "minute")!;
    int curPeriod = attendanceData[index].pattern!.period!;

    int nextIsWorking = (attendanceData[index+1].pattern!.isWorkingDay == 1
        && attendanceData[index+1].holiday == null)? 1: 0;
    Day nextStart = Day.fromDateTime(DateTime(
      attendanceData[index+1].date!.year,
      attendanceData[index+1].date!.month,
      attendanceData[index+1].date!.day,
      int.parse(attendanceData[index+1].pattern!.timeIn!.substring(0,2)),
      int.parse(attendanceData[index+1].pattern!.timeIn!.substring(3,5)),
    ));
    Day nextEnd = nextStart.add(attendanceData[index+1].pattern!.workingHours!, "minute")!;
    int nextPeriod = attendanceData[index+1].pattern!.period!;

    Day startBreakHourDate = Day.fromDateTime(DateTime(
      start.year,
      start.month,
      start.day,
      12,
      0,
    ));
    Day endBreakHourDate = Day.fromDateTime(DateTime(
      start.year,
      start.month,
      start.day,
      13,
      0,
    ));

    Day workStartDate = Day.fromDateTime(DateTime(
      attendanceData[index].date!.year,
      attendanceData[index].date!.month,
      attendanceData[index].date!.day,
      int.parse(attendanceData[index].pattern!.timeIn!.substring(0,2)),
      int.parse(attendanceData[index].pattern!.timeIn!.substring(3,5)),
    ));
    Day workEndDate = workStartDate.add(attendanceData[index].pattern!.workingHours!, "minute")!;

    int xOT = 0;
    int xOTHoliday = 0;
    int xWorkingDailyHoliday = 0;
    int	xWorkingMonthlyHoliday = 0;
    int overlapWorking = 0;
    err['isErr'] = false;
    if(startTime.isAfter(endTime)){
      setState(() {
        err['isErr'] = true;
        err['errMsg'] = "วันที่หรือเวลาไม่ถูกต้อง";
      });
    }
    else if(reasonType != null && reasonType! == "ทำงานเร่งด่วนช่วงพักเที่ยง"){
      if(startTime.isBefore(startBreakHourDate) || endTime.isAfter(endBreakHourDate)
      ) {
        setState(() {
        err['isErr'] = true;
        err['errMsg'] = "เวลาทำงานเร่งด่วนช่วงพักเที่ยงไม่ถูกต้อง";
      });
      }

    }
    else{
      setState(() {
        err['isErr'] = false;
        err['errMsg'] = null;
      });
    }

    if(attendanceData[index].pattern!.idWorkingType == 1){
      int ot_previous = (endTime.isBefore(preEnd)? endTime: preEnd).diff(startTime.isAfter(preStart)? startTime: preStart, 'minute');
      if(ot_previous > 0){
        if(preIsWorking == 1){
          overlapWorking += ot_previous;
        } else if(preIsWorking == 0){
          if(idPaymentType == 2){
            xWorkingMonthlyHoliday += ot_previous;
          } else if(idPaymentType == 1){
            xWorkingDailyHoliday += ot_previous;
          }
        }
      } else {
        ot_previous = 0;
      }

      int ot_pre_current = (endTime.isBefore(curStart)? endTime: curStart).diff(startTime.isAfter(preEnd)? startTime: preEnd, 'minute');
      if(ot_pre_current > 0){
        if(preIsWorking == 1){
          xOT += ot_pre_current;
        } else if(preIsWorking == 0){
          xOTHoliday += ot_pre_current;
        }
      } else {
        ot_pre_current = 0;
      }

      int ot_current = (endTime.isBefore(curEnd)? endTime: curEnd).diff(startTime.isAfter(curStart)? startTime: curStart, 'minute');
      if(ot_current > 0){
        if(curIsWorking == 1){
          // console.log("HI")
          overlapWorking += ot_current;
          // xOT += ot_previous
        } else if(curIsWorking == 0){
          if(idPaymentType == 2){
            xWorkingMonthlyHoliday += ot_current;
          } else if(idPaymentType == 1){
            xWorkingDailyHoliday += ot_current;
          }
        }
      } else {
        ot_current = 0;
      }

      int ot_pre_next = (endTime.isBefore(nextStart)? endTime: nextStart).diff(startTime.isAfter(curEnd)? startTime: curEnd, 'minute');
      // console.log("ot_pre_next", ot_pre_next)
      if(ot_pre_next > 0){

        if(curIsWorking == 1 && curPeriod == 3 && nextIsWorking == 0){
          xOTHoliday += ot_pre_next;
          // } else if (curIsWorking === 0 && curPeriod === 1 && nextIsWorking === 1 && nextPeriod === 3){
        } else if (curIsWorking == 0 && curPeriod == 1 && nextPeriod == 3){

          // let over730 = dayjs(end).diff(`${nextStart.format("YYYY-MM-DD")} 07:30:00`, 'minute', true)

          Day curTimeInPlusOneDay = curStart.add(1, 'day')!;

          int overCurTimeInPlusOneDay = (endTime.isBefore(nextStart)? endTime: nextStart).diff(curTimeInPlusOneDay, 'minute');

          if(overCurTimeInPlusOneDay > 0){
            if(idPaymentType == 2){
              xWorkingMonthlyHoliday += overCurTimeInPlusOneDay;
            } else if(idPaymentType == 1){
              xWorkingDailyHoliday += overCurTimeInPlusOneDay;
            }
            xOTHoliday += (ot_pre_next - overCurTimeInPlusOneDay);
            // if(over730 > 0){
            // 	if(idPaymentType === 2){
            // 		xWorkingMonthlyHoliday += over730;
            // 	} else if(idPaymentType === 1){
            // 		xWorkingDailyHoliday += over730;
            // 	}
            // 	xOTHoliday += (ot_pre_next - over730)
          } else {
            xOTHoliday += ot_pre_next;
          }
        } else if(curIsWorking == 1){
          xOT += ot_pre_next;
        } else if(curIsWorking == 0){
          xOTHoliday += ot_pre_next;
        }
      } else {
        ot_pre_next = 0;
      }

      int ot_next = (endTime.isBefore(nextEnd)? endTime: nextEnd).diff(startTime.isAfter(nextStart)? startTime: nextStart, 'minute');
      if(ot_next > 0){
        if(nextIsWorking == 1){
          overlapWorking += ot_next;
          // xOT += ot_previous
        } else if(nextIsWorking == 0){
          if(idPaymentType == 2){
            xWorkingMonthlyHoliday += ot_next;
          } else if(idPaymentType == 1){
            xWorkingDailyHoliday += ot_next;
          }
        }
      } else {
        ot_next = 0;
      }
    }

    if(attendanceData[index].pattern!.idWorkingType == 2){
      int ot_pre_current = (endTime.isBefore(curStart)? endTime: curStart).diff(startTime, 'minute');
      if(ot_pre_current > 0){
        if(curIsWorking == 1){
          xOT += ot_pre_current;
        } else if(curIsWorking == 0){
          xOTHoliday += ot_pre_current;
        }
      } else {
        ot_pre_current = 0;
      }

      int ot_prebreak = (endTime.isBefore(startBreakHourDate)? endTime: startBreakHourDate).diff(startTime.isAfter(curStart)? startTime: curStart, 'minute');
      if(ot_prebreak > 0){
        if(curIsWorking == 1){
          overlapWorking += ot_prebreak;
        } else if(curIsWorking == 0){
          if(idPaymentType == 2){
            xWorkingMonthlyHoliday += ot_prebreak;
          } else if(idPaymentType == 1){
            xWorkingDailyHoliday += ot_prebreak;
          }
        }
      }

      int ot_afterbreak = (endTime.isBefore(workEndDate)? endTime: workEndDate).diff(startTime.isAfter(endBreakHourDate)? startTime: endBreakHourDate, 'minute');
      if(ot_afterbreak > 0){
        if(curIsWorking == 1){
          overlapWorking += ot_afterbreak;
        } else if(curIsWorking == 0){
          if(idPaymentType == 2){
            xWorkingMonthlyHoliday += ot_afterbreak;
          } else if(idPaymentType == 1){
            xWorkingDailyHoliday += ot_afterbreak;
          }
        }
      }

      int ot_betweenbreak = (endTime.isBefore(endBreakHourDate)? endTime: endBreakHourDate).diff(startTime.isAfter(startBreakHourDate)? startTime: startBreakHourDate, 'minute');
      if(ot_betweenbreak > 0){
        if(reasonType != null && reasonType! == "ทำงานเร่งด่วนช่วงพักเที่ยง"){
          if (curIsWorking == 1) {
            xOT += ot_betweenbreak;
          } else {
            xOTHoliday += ot_betweenbreak;
          }
        }
      }


      int ot_afterTimeOut = (endTime).diff(startTime.isAfter(workEndDate)? startTime: workEndDate, 'minute');
      if(ot_afterTimeOut > 0){
        if(curIsWorking == 1){
          xOT += ot_afterTimeOut;
        } else if(curIsWorking == 0){
          xOTHoliday += ot_afterTimeOut;
        }
      }
    }

    CalculateTimeEntity result = CalculateTimeEntity(
        xOT: xOT,
        xOTHoliday: xOTHoliday,
        xWorkingDailyHoliday: xWorkingDailyHoliday,
        xWorkingMonthlyHoliday: xWorkingMonthlyHoliday,
        overlapWorking: overlapWorking);
    return result;
  }
}
