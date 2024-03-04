import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/widgets/shimmer.dart';
import '../../../../../core/features/profile/manager/presentation/provider/manager_profile_provider.dart';
import '../bloc/waiting_status_bloc.dart';
import '../providers/radio_button_provider.dart';
import '../widgets/expanlist_widget/expan_list.dart';
import '../widgets/widgets.dart';

class WaitingStatusPage extends StatefulWidget {
  const WaitingStatusPage({super.key});

  @override
  State<WaitingStatusPage> createState() => _WaitingStatusPageState();
}

class _WaitingStatusPageState extends State<WaitingStatusPage> {
  final waitingStatusBloc = sl<WaitingStatusBloc>();
  final TextEditingController textFieldController = TextEditingController();

  Future<void> displayTextInputDialog(BuildContext context) async {
    final item =
        Provider.of<ManagerRadioButtonProvider>(context, listen: false);
    final managerProfile =
        Provider.of<ManagerProfileProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'ยืนยันการไม่อนุมัติรายการ',
            style: TextStyle(),
          ),
          content: TextField(
            maxLines: 5,
            controller: textFieldController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              hintText: "เหตุผลที่ไม่อนุมัติ",
              hintStyle: TextStyle(fontSize: 14),
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                textFieldController.text = "";
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('ยืนยัน'),
              onPressed: () {
                if (item.type == "ขอลา") {
                  waitingStatusBloc.add(IsApproveLeaveWaitingStatus(
                      indexes: List<int>.from(item.selectedFlag),
                      idLeaveEmployeesWithdraw: const [],
                      leaveRequestLists: item.leaveData,
                      withdrawLeaveRequestLists: item.withdrawData,
                      isApprove: 0,
                      comment: ""));
                } else if (item.type == "ขอรับรองเวลาทำงาน" ||
                    item.type == "ขอทำงานล่วงเวลา") {
                  waitingStatusBloc.add(IsApproveRequestTimeWaitingStatus(
                    idManager: managerProfile.profileData.idManagerEmployee!,
                    indexes: List<int>.from(item.selectedFlag),
                    type: item.type,
                    commentManagerLV1: textFieldController.text,
                    commentManagerLV2: textFieldController.text,
                    isManagerLV1Approve: 0,
                  ));
                }
                item.unSelectAll();
                item.clearAllData();
                waitingStatusBloc.add(GetWaitingStatus(
                    start: null,
                    end: null,
                    managerData: managerProfile.profileData));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ManagerRadioButtonProvider>(context);
    final managerProfile = Provider.of<ManagerProfileProvider>(context);

    return Scaffold(
      appBar: appBar(context, "รออนุมัติ"),
      body: BlocProvider(
        create: (context) => waitingStatusBloc,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          child: Stack(
            children: [
              Column(
                children: [
                  RadioButtonMenu(
                      waitingStatusBloc: waitingStatusBloc,
                      managerData: managerProfile.profileData),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "รออนุมัติ ${item.dataLength()} รายการ",
                        style: const TextStyle(
                            color: Color(0xffFF364B),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (item.isSelectAll == false) {
                              item.selectAll(item.dataLength());
                              item.setSelectAll(true);
                            } else {
                              item.unSelectAll();
                              item.setSelectAll(false);
                            }
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  item.isSelectAll
                                      ? const Color(0xffFF364B)
                                      : const Color.fromRGBO(235, 195, 28, 1))),
                          child: Text(
                            item.isSelectAll ? "ยกเลิก" : "เลือกทั้งหมด",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  BlocConsumer<WaitingStatusBloc, WaitingStatusState>(listener:
                      (BuildContext context, WaitingStatusState state) {
                    if (state is WaitingStatusLoaded) {
                      item.setData(
                          state.leaveNotApproveData,
                          state.requestTimeData,
                          state.withdrawLeaveData,
                          state.payrollSetting,
                          state.dataNotApproveRequestTime,
                          state.dataNotApproveOt);
                    }
                    if (state is WaitingStatusSendRequestFailed) {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          confirmBtnText: "ปิด",
                          confirmBtnColor: const Color(0xffE46A76),
                          title: "เกิดข้อผิดพลาด",
                          text:
                              "ไม่สามารถส่งข้อมูลอนุมัติคำขอได้ กรุณาติดต่อแอดมิน");
                      waitingStatusBloc.add(GetWaitingStatus(
                          start: null,
                          end: null,
                          managerData: managerProfile.profileData));
                    } else if (state is WaitingStatusSendRequestSuccess) {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        confirmBtnText: "ปิด",
                        confirmBtnColor: const Color(0xff33ad65),
                        title: "ทำรายการสำเร็จ",
                      );
                      waitingStatusBloc.add(GetWaitingStatus(
                          start: null,
                          end: null,
                          managerData: managerProfile.profileData));
                    }
                  }, builder: (context, state) {
                    if (state is WaitingStatusInitial) {
                      return const Text("กำลังดึงข้อมูล...");
                    } else if (state is WaitingStatusLoading) {
                      return Expanded(
                          child: ShimmerComponent(
                              width: MediaQuery.of(context).size.width,
                              height: 100));
                    } else if (state is WaitingStatusLoaded) {
                      return ExpansionList(
                        leaveData: state.leaveNotApproveData,
                        requestTimeData: state.requestTimeData,
                        withdrawData: state.withdrawLeaveData,
                        payrollSettingData: state.payrollSetting,
                        dataRequestTime: state.dataNotApproveRequestTime,
                        dataRequestOT: state.dataNotApproveOt,
                        bloc: waitingStatusBloc,
                      );
                    } else if (state is WaitingStatusFailure) {
                      return const Text("error");
                    } else {
                      return const Text("ไม่พบข้อมูล");
                    }
                  })
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Visibility(
                  visible: item.selectedFlag.isNotEmpty,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xff27385E),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(color: Colors.transparent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xffFF364B))),
                          onPressed: () {
                            displayTextInputDialog(context);
                          },
                          child: Text(
                              "ไม่อนุมัติ ${item.selectedFlag.length} รายการ",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff30B98F))),
                          onPressed: () {
                            if (item.type == "ขอลา") {
                              waitingStatusBloc.add(IsApproveLeaveWaitingStatus(
                                  indexes: List<int>.from(item.selectedFlag),
                                  idLeaveEmployeesWithdraw: const [],
                                  leaveRequestLists: item.leaveData,
                                  withdrawLeaveRequestLists: item.withdrawData,
                                  isApprove: 1,
                                  comment: ""));
                            } else if (item.type == "ขอรับรองเวลาทำงาน" ||
                                item.type == "ขอทำงานล่วงเวลา") {
                              waitingStatusBloc
                                  .add(IsApproveRequestTimeWaitingStatus(
                                idManager: managerProfile
                                    .profileData.idManagerEmployee!,
                                indexes: List<int>.from(item.selectedFlag),
                                type: item.type,
                                commentManagerLV1: "",
                                commentManagerLV2: "",
                                isManagerLV1Approve: 1,
                              ));
                            } else if (item.type == "ขอเปลี่ยนกะ") {}
                            item.unSelectAll();
                            item.clearAllData();
                            waitingStatusBloc.add(GetWaitingStatus(
                                start: null,
                                end: null,
                                managerData: managerProfile.profileData));
                          },
                          child: Text(
                            "อนุมัติ ${item.selectedFlag.length} รายการ",
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
