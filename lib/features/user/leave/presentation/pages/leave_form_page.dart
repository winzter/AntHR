import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../injection_container.dart';
import '../../domain/entities/entities.dart';
import '../bloc/leave_bloc.dart';
import '../widgets/appbar.dart';
import 'confirm_page.dart';
// import 'confirm_page.dart';

class LeaveFormPage extends StatefulWidget {
  final List<LeaveAuthorityEntity> data;
  final List<LeaveHistoryEntity> historyData;
  final List<double> remaining;
  final List<double> used;
  final Map<String,List<double>> leaveUsedData;
  const LeaveFormPage({super.key, required this.data, required this.remaining, required this.historyData,required this.used, required this.leaveUsedData});

  @override
  State<LeaveFormPage> createState() => _LeaveFormPageState();
}

class _LeaveFormPageState extends State<LeaveFormPage> {
  final LeaveBloc leaveBloc = sl<LeaveBloc>();
  List<String> leaveList = [];
  List<DayCannotLeave> dayCannotLeave = [];
  List<String> hours = List.generate(24, (index) => index.toString().padLeft(2,'0'));
  List<String> minutes = ["00","30"];

  // * input for make leave request.
  String? leaveType;
  List<String> startTime = ["00","00"];
  List<String> endTime = ["00","00"];
  late DateTime startDate;
  late DateTime endDate;
  String note = "";

  String fileName = "No file selected";
  bool isUpload = false;
  String filePath = "";
  late File fileSend;
  FilePickerResult? result;
  int? minLeave;
  Map<String,bool> isLocked = {
    'fullday':true,
    'time':true,
  };
  double used = 0;

  void lockCheck(){
    setState(() {
      if(minLeave == null){
        isLocked['full'] = false;
        isLocked['time'] = false;
      }else if(minLeave == 100){
        isLocked['full'] = false;
        isLocked['time'] = true;
        isFullDay = true;
      }else if(minLeave == 500){
        isLocked['full'] = false;
        isLocked['time'] = true;
      }else if(minLeave == 10 || minLeave == 30){
        isLocked['full'] = false;
        isLocked['time'] = false;
      }else if(minLeave == 5 && leaveType != "ลาชั่วโมง Compensate"){
        isLocked['full'] = false;
        isLocked['time'] = false;
      }else if(leaveType == "ลาชั่วโมง Compensate"){
        isLocked['full'] = true;
        isLocked['time'] = false;
        isFullDay = false;
      }
    });
  }

  void showInSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'ข้อมูลซ้ำกับรายการอื่น',
        style: TextStyle(fontSize: 17,fontFamily: 'kanit'),
      ),
      backgroundColor: Color(0xffE46A76),
      behavior: SnackBarBehavior.floating,
    ));
  }
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isFullDay = true;

  Future<void> pickDate(BuildContext context,bool isStartDate) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2200),
    );
    if (date != null) {
      setState(() {
        if(isStartDate){
          startDate = date;
          startDateController.text = DateFormat('dd/MM/yyyy').format(date);
        }else{
          endDate = date;
          endDateController.text = DateFormat('dd/MM/yyyy').format(date);
        }
        if(startDate.day != endDate.day){
          isFullDay = true;
        }
      });
      used = calculateUsedDay(isFullDay, startDate, endDate, dayCannotLeave);
      leaveBloc.add(GetDayCannotLeaveData(start: startDate, end: endDate));
      setState((){});
    }
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      DateTime now = DateTime.now();
      startDate = DateTime.now();
      endDate = DateTime.now();
      startDateController.text = DateFormat('dd/MM/yyyy').format(startDate);
      endDateController.text = DateFormat('dd/MM/yyyy').format(endDate);
      leaveList = widget.data
          .map((e) => e.name)
          .where((name) => name != null)
          .toList()
          .cast<String>();
      used = calculateUsedDay(isFullDay, startDate, endDate,dayCannotLeave);
      leaveBloc.add(GetDayCannotLeaveData(start: startDate, end: endDate));
      startDate = DateTime(now.year,now.month,now.day,0,0,0,0,0);
      endDate = DateTime(now.year,now.month,now.day,0,0,0,0,0);
    });

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: BlocProvider(
      create: (context) => leaveBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).devicePixelRatio * 7 ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("ประเภท",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                                errorStyle: TextStyle(fontSize: 14),
                                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15))),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "เลือกประเภทการลา";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                              hint: const Text(
                                "เลือกประเภทการลา",
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
                              items: leaveList.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(fontSize: 18,fontFamily: 'kanit'),
                                    ));
                              }).toList(),
                              onChanged: (String? value) {
                                leaveType = value!;
                                minLeave = widget.data.firstWhere((element) => element.name == value).minLeave;
                                lockCheck();
                              }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                ),
                              ),
                              side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(
                                  color: !isFullDay?const Color(0xff007AFE):Colors.white, // Border color// Border width
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(isFullDay?const Color(0xff007AFE):Colors.white)
                          ),
                            onPressed: (){
                              setState(() {
                                if(minLeave != 5){
                                  isFullDay = true;
                                  startTime = ["00","00"];
                                  endTime = ["00","00"];
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("เต็มวัน",style: TextStyle( fontSize: 15,
                                  color: (minLeave == 100 || minLeave == 50 || minLeave == 30 || minLeave == 10 || minLeave == null) && isFullDay? Colors.white :const Color(0xff007AFE)),),
                            )),
                        ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                  ),
                                ),
                                side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                    color: !isFullDay && isLocked['time'] == false ?Colors.white:const Color(0xff007AFE), // Border color// Border width
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(!isFullDay && isLocked['time'] == false?const Color(0xff007AFE):Colors.white)
                            ),
                            onPressed: (){
                              if(isLocked['time'] == false){
                                isFullDay = false;
                              }
                              setState((){});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("ระบุเวลา",style: TextStyle(fontSize: 15,
                                  color: !isFullDay && isLocked['time'] == false? Colors.white :const Color(0xff007AFE)),),
                            ))
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
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                          // height: 35,
                          // width: 250,
                          child: TextFormField(
                            onTap: ()=>pickDate(context,true),
                            controller: startDateController,
                            readOnly: true,
                            style: const TextStyle(),
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return "เลือกวันที่";
                              }else if(startDate.isAfter(endDate)){
                                return "วันที่หรือเวลาไม่ถูกต้อง";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                suffixIcon: Icon(Icons.calendar_month),
                                hintText: "วัน/เดือน/ปี",
                                hintStyle: TextStyle( fontSize: 18, color: Colors.grey),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                errorStyle: TextStyle()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !isFullDay,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "เวลาที่เริ่ม",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                // height: 35,
                                // width: 120,
                                child: DropdownButtonFormField2(
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      errorStyle: TextStyle(fontSize: 14,fontFamily: 'kanit'),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "เลือกชั่วโมง";
                                      }else if(startDate.isAfter(endDate)){
                                        return "วันที่หรือเวลาไม่ถูกต้อง";
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    hint: const Text("ชั่วโมง",
                                      style: TextStyle(fontSize: 18, color: Colors.grey,fontFamily: 'kanit'),
                                    ),
                                    isExpanded: true,
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    items: hours.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                            style: const TextStyle(fontSize: 18,fontFamily: 'kanit'),
                                          ));
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState((){
                                        startTime[0]=value!;
                                        used = calculateUsedDay(
                                          isFullDay,
                                          DateTime(startDate.year,startDate.month,startDate.day,int.parse(startTime[0]),int.parse(startTime[1])),
                                          DateTime(endDate.year,endDate.month,endDate.day,int.parse(endTime[0]),int.parse(endTime[1])),
                                          dayCannotLeave,
                                        );
                                      });
                                    }),
                              ),
                              const Text(" : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              Expanded(
                                // width: 120,
                                child: DropdownButtonFormField2(
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      errorStyle: TextStyle(fontSize: 14,fontFamily: 'kanit'),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "เลือกนาที";
                                      }else if(startDate.isAfter(endDate)){
                                        return "วันที่หรือเวลาไม่ถูกต้อง";
                                      }
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
                                    items: minutes.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                            style: const TextStyle(fontSize: 18,fontFamily: 'kanit'),
                                          ));
                                    }).toList(),
                                    onChanged: (String? value) {
                                      startTime[1]=value!;
                                      used = calculateUsedDay(
                                        isFullDay,
                                        DateTime(startDate.year,startDate.month,startDate.day,int.parse(startTime[0]),int.parse(startTime[1])),
                                        DateTime(endDate.year,endDate.month,endDate.day,int.parse(endTime[0]),int.parse(endTime[1])),
                                        dayCannotLeave,
                                      );
                                    }),
                              ),
                            ],
                          )
                        ],
                      ),
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
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                          // height: 35,
                          // width: 250,
                          child: TextFormField(
                            onTap: ()=>pickDate(context,false),
                            controller: endDateController,
                            readOnly: true,
                            style: const TextStyle(),
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return "เลือกวันที่";
                              }else if(startDate.isAfter(endDate)){
                                return "วันที่หรือเวลาไม่ถูกต้อง";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                suffixIcon: Icon(Icons.calendar_month),
                                hintText: "วัน/เดือน/ปี",
                                hintStyle: TextStyle( fontSize: 18, color: Colors.grey),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                errorStyle: TextStyle()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible:!isFullDay,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "เวลาที่สิ้นสุด",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                // height: 35,
                                // width: 120,
                                child: DropdownButtonFormField2(
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      errorStyle: TextStyle(fontSize: 14,fontFamily: 'kanit'),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "เลือกชั่วโมง";
                                      }else if(startDate.isAfter(endDate)){
                                        return "วันที่หรือเวลาไม่ถูกต้อง";
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    hint: const Text("ชั่วโมง",
                                      style: TextStyle(fontSize: 18, color: Colors.grey,fontFamily: 'kanit'),
                                    ),
                                    isExpanded: true,
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    items: hours.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                            style: const TextStyle(fontSize: 18,fontFamily: 'kanit'),
                                          ));
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        endTime[0]=value!;
                                        used = calculateUsedDay(
                                          isFullDay,
                                          DateTime(startDate.year,startDate.month,startDate.day,int.parse(startTime[0]),int.parse(startTime[1])),
                                          DateTime(endDate.year,endDate.month,endDate.day,int.parse(endTime[0]),int.parse(endTime[1])),
                                          dayCannotLeave,
                                        );
                                      });
                                    }),
                              ),
                              const Text(" : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              Expanded(
                                // height: 35,
                                // width: 120,
                                child: DropdownButtonFormField2(
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      errorStyle: TextStyle(fontSize: 14,fontFamily: 'kanit'),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "เลือกนาที";
                                      }else if(startDate.isAfter(endDate)){
                                        return "วันที่หรือเวลาไม่ถูกต้อง";
                                      }
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
                                    items: minutes.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(fontSize: 18,fontFamily: 'kanit'),
                                          ));
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        endTime[1]=value!;
                                        used = calculateUsedDay(
                                          isFullDay,
                                          DateTime(startDate.year,startDate.month,startDate.day,int.parse(startTime[0]),int.parse(startTime[1])),
                                          DateTime(endDate.year,endDate.month,endDate.day,int.parse(endTime[0]),int.parse(endTime[1])),
                                          dayCannotLeave,
                                        );
                                      });
                                    }),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "หมายเหตุ",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                          // height: 35,
                          // width: 250,
                          child: TextFormField(
                            maxLines: 5,
                            // onTap: pickDateRange,
                            // controller: dateController,a
                            onChanged: (String value){
                              note = value;
                            },
                            style: const TextStyle(),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                hintText: "หมายเหตุเพิ่มเติม",
                                hintStyle: TextStyle(),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                errorStyle: TextStyle()),
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
                          "แนบไฟล์",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5,),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      result = await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['jpg', 'png', 'jpeg'],
                                        allowMultiple: false,
                                        withData: false,
                                        withReadStream: false,
                                      );
                                      if (result != null) {
                                        setState(() {
                                          isUpload = true;
                                          filePath = result!.files.single.path!;
                                          fileName = result!.files.first.name;
                                        });
                                      } else {
                                        return;
                                      }
                                    },
                                    icon: const Icon(Icons.folder),
                                    label: const Text(
                                      "เลือกไฟล์",
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        fileName,
                                        style: const TextStyle(),
                                      ),
                                      if (isUpload)
                                        InkWell(
                                          onTap: () async {
                                            File file = File(result!.files.single.path!);
                                            await file.delete();
                                            setState(() {
                                              isUpload = false;
                                              filePath = "";
                                              fileName = "No file selected";
                                              log("file is deleted!");
                                            });
                                            log(result!.files.single.path.toString());
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        )
                                    ],
                                  ),
                                  const Text(
                                    "*Allowed *.jpeg, *.jpg, *.png, max size of 3 MB",
                                    softWrap: true,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<LeaveBloc, LeaveState>(
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).devicePixelRatio * 10,
                            bottom:
                            MediaQuery.of(context).devicePixelRatio * 10),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "จำนวนการลา",
                                  style: TextStyle(fontSize: 19),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            if ((startDate.compareTo(endDate) > 0) || used < 0) ...[
                              const Text(
                                "*วันที่เริ่ม และ สิ้นสุดไม่ถูกต้อง",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ] else if(used > -1) ...[
                              Text(
                                "${used.toStringAsFixed(2)} วัน",
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]
                          ],
                        ),
                      );
                    }, listener: (BuildContext context, LeaveState state) {
                    if(state is LeaveLoaded){
                      dayCannotLeave = state.dayCannotLeave;
                      if(isFullDay){
                        used = calculateUsedDay(
                            isFullDay,
                            DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0, 0, 0),
                            DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0, 0, 0),state.dayCannotLeave);
                      }else {
                        used = calculateUsedDay(
                            isFullDay,
                            DateTime(startDate.year, startDate.month, startDate.day),
                            DateTime(endDate.year, endDate.month, endDate.day),dayCannotLeave);
                      }
                      setState(() {});
                    }
                  },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 5,
                        bottom: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "สิทธิคงเหลือ",
                              style: TextStyle(fontSize: 19),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (leaveType == "วันหยุดพักผ่อนประจำปี") ...[
                              // (widget.remaining[0] - used <= 0)
                              (widget.leaveUsedData["วันหยุดพักผ่อนประจำปี"]![1] - used <= 0)
                                  ? (widget.data[0].leaveValue! - used < 0
                                  ? const Text("สิทธิการลาไม่เพียงพอ",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.red))
                                  : Text(
                                "${widget.data[0].leaveValue!.toStringAsFixed(2)} วัน",
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),))
                                  : Text(
                                // "${widget.remaining[widget.data.indexWhere((element) => element.name == leaveType)] - used} วัน",
                                  "${widget.leaveUsedData[leaveType]![1] - used} วัน",
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ]
                            else ...[
                              leaveType != null
                              // ? (widget.remaining[widget.data.indexWhere((element) => element.name == leaveType)] - used) < 0
                                  ? (widget.leaveUsedData[leaveType]![1] - used) < 0
                                  ? const Text(
                                "สิทธิการลาไม่เพียงพอ",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red),
                              )
                                  : Text(
                                // "${(widget.remaining[widget.data.indexWhere((element) => element.name == leaveType)] - used).toStringAsFixed(2)} วัน",
                                (widget.leaveUsedData[leaveType]![1] - used) > 100?"ไม่จำกัด":
                                "${(widget.leaveUsedData[leaveType]![1] - used).toStringAsFixed(2)} วัน",
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                                  : const Text("-")
                            ]
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10,
                        bottom: MediaQuery.of(context).devicePixelRatio * 10
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: const Color(0xff007AFE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (widget.historyData.any(
                            (element) =>
                            DateFormat("dd-MM").format(element.start!) ==
                            DateFormat("dd-MM").format(startDate),
                            )) {
                              showInSnackBar(context);
                            }
                            else{
                              DateTime startRequestDate = DateTime(
                                  startDate.year,
                                  startDate.month,
                                  startDate.day,
                                  int.parse(startTime[0]),
                                  int.parse(startTime[1]));
                              DateTime endRequestDate = DateTime(
                                  endDate.year,
                                  endDate.month,
                                  endDate.day,
                                  int.parse(endTime[0]),
                                  int.parse(endTime[1]));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConfirmPage(
                                      data: widget.data,
                                      start: startRequestDate,
                                      end: endRequestDate,
                                      leaveType: leaveType!,
                                      note: note,
                                      used: calculateUsedDay(isFullDay, startRequestDate, endRequestDate,dayCannotLeave).abs(),
                                      isFullDay: isFullDay,
                                      remaining: widget.remaining,
                                      filePath: result,
                                      leaveUsedData: widget.leaveUsedData,
                                    )),
                              );
                            }

                          }
                        },
                        child: const Text("ยืนยัน",style: TextStyle(
                            color: Colors.white,
                          fontSize: 18
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
),
    );
  }

  double calculateUsedDay(
      bool isFullDay,
      DateTime startRequestDate ,
      DateTime endRequestDate,
      List<DayCannotLeave> dayCannotLeave ,

      ){
    double diffDay = 0;
    if (isFullDay) {
      diffDay = (endRequestDate.difference(startRequestDate).inDays+1).toDouble();
      return diffDay;
    } else {
      var numDiff = 0;
      int hourDiff = endRequestDate.hour - startRequestDate.hour;
      int minuteDiff = (endRequestDate.minute - startRequestDate.minute).abs();
      if (endRequestDate.hour > 12) {
        numDiff = -1;
      }
      double inDays = ((hourDiff + numDiff + (minuteDiff/60)) / 8);
      diffDay = double.parse(inDays.toStringAsFixed(2));
      // log("${diffDay}");
      return double.parse((inDays).toStringAsFixed(2));
    }
  }

  @override
  void dispose(){
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }
}
