import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/entities.dart';
import '../bloc/leave_bloc.dart';

class LeaveHistoryList extends StatelessWidget {
  final List<LeaveHistoryEntity> leaveHistory;
  final LeaveBloc bloc;
  const LeaveHistoryList({super.key, required this.leaveHistory,required this.bloc});

  Future confirmDelete(BuildContext context,LeaveHistoryEntity leaveHistory,int index) async{
    await showDialog(context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Center(child: Column(
            children: [
              Icon(Icons.dangerous_outlined , color: Color(0xFFF15E5E),size: 60,),
              Text('คุณแน่ใจใช่ไหม?',style: TextStyle(color: Color(0xff75838F)),),
            ],
          )),
          content:  Column(mainAxisSize: MainAxisSize.min,
            children: [
              const Text("ประเภทการลา",style: TextStyle(fontSize: 14,color: Color(0xffAFB9C2)),),
              Text(leaveHistory.name!,style: const TextStyle(),),
              const Text("วันที่เริ่ม",style: TextStyle(fontSize: 14,color: Color(0xffAFB9C2)),),
              const SizedBox(height: 5,),
              Text(DateFormat('dd/MM/yyyy').format(leaveHistory.start!),style: const TextStyle(fontSize: 17),),
              const SizedBox(height: 5,),
              const Text("วันที่สิ้นสุด",style: TextStyle(fontSize: 14,color: Color(0xffAFB9C2)),),
              const SizedBox(height: 5,),
              Text(DateFormat('dd/MM/yyyy').format(leaveHistory.end!),style: const TextStyle(fontSize: 17),),
            ],),
          actions: [
            TextButton(
              child:  const Text('ยกเลิก',style: TextStyle(color: Color(0xffA5AFBA))),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFFF15E5E)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust the radius here
                    ),)
              ),
              child: const Text('ยืนยัน',style: TextStyle(color: Colors.white)),
              onPressed: () {
                  bloc.add(DeleteLeaveHistoryData(leaveHistory: leaveHistory, index: index));
                return Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return leaveHistory.isNotEmpty ?ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: leaveHistory.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          leaveHistory[index].name ?? "ไม่ระบุ",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(
                          "assets/icons/bin.svg",
                          width: 12,
                        ),
                        onTap: ()=> confirmDelete(
                            context,
                            leaveHistory[index],
                            index
                        ),
                      ),
                      if (leaveHistory[index].isApprove == 1)
                        SvgPicture.asset("assets/icons/pass.svg"),
                      if (leaveHistory[index].isApprove == null)
                        SvgPicture.asset("assets/icons/wait.svg"),
                      if (leaveHistory[index].isApprove == 0)
                        SvgPicture.asset("assets/icons/notpass.svg")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "เริ่มต้น",
                        style: TextStyle(fontSize: 17),
                      ),
                      Text("สิ้นสุด",
                          style: TextStyle(fontSize: 17))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            DateFormat('dd/MM/yyyy')
                                .format(
                                leaveHistory[index].start ??
                                    DateTime.now()),
                            style: const TextStyle(fontSize: 17)),
                        Text(
                            DateFormat('dd/MM/yyyy')
                                .format(
                                leaveHistory[index].end ??
                                    DateTime.now()),
                            style: const TextStyle(fontSize: 17))
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            leaveHistory[index].isFullDay != 1
                                ? DateFormat('HH:mm').format(
                                leaveHistory[index].start ??
                                    DateTime.now())
                                : "",
                            style: const TextStyle(fontSize: 17)),
                        Text(
                            leaveHistory[index].isFullDay != 1
                                ? DateFormat('HH:mm').format(
                                leaveHistory[index].end ??
                                    DateTime.now())
                                : "",
                            style: const TextStyle(fontSize: 17))
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                            "หมายเหตุ : ${leaveHistory[index].description ?? '-'}",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff757575))),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }):const Center(child: Text("ไม่พบประวัติการลา",style: TextStyle(fontSize: 18),),);
  }
}

