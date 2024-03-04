import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:anthr/features/user/leave/presentation/pages/success_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../../domain/entities/entities.dart';
import '../bloc/leave_bloc.dart';
import '../widgets/appbar.dart';
// import 'success_page.dart';

class ConfirmPage extends StatelessWidget {
  final LeaveBloc bloc = sl<LeaveBloc>();
  final bool isFullDay;
  final double used;
  final DateTime start;
  final DateTime end;
  final String leaveType;
  final String note;
  final List<LeaveAuthorityEntity> data;
  final Map<String, List<double>> leaveUsedData;
  final List<double> remaining;
  final FilePickerResult? filePath;

  ConfirmPage(
      {super.key,
      required this.data,
      required this.start,
      required this.end,
      required this.leaveType,
      required this.note,
      required this.used,
      required this.isFullDay,
      required this.remaining,
      required this.filePath,
      required this.leaveUsedData});

  @override
  Widget build(BuildContext context) {
    var leaveRemain = leaveUsedData[leaveType]![1] - used;
    final ProfileProvider userInfo = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: BlocProvider(
        create: (context) => bloc,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).devicePixelRatio * 10),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 30,
                          child: Text(
                            "ประเภท :",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  leaveType,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                        top: MediaQuery.of(context).devicePixelRatio * 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 30,
                          child: Text(
                            "วันที่เริ่ม :",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                DateFormat("dd/MM/yyyy").format(start),
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !isFullDay,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 30,
                            child: Text(
                              "เวลาที่เริ่ม :",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Expanded(
                            flex: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  DateFormat("HH : mm").format(start),
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 30,
                          child: Text(
                            "วันที่สิ้นสุด:",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                DateFormat("dd/MM/yyyy").format(end),
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !isFullDay,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 45,
                            child: Text(
                              "เวลาที่สิ้นสุด :",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Expanded(
                            flex: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  DateFormat("HH : mm").format(end),
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 40,
                          child: Text(
                            "จำนวนวัน :",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${used.toStringAsFixed(2)} วัน",
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
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
                        top: MediaQuery.of(context).devicePixelRatio * 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 40,
                          child: Text(
                            "สิทธิคงเหลือ :",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (leaveType == "วันหยุดพักผ่อนประจำปี") ...[
                                (leaveUsedData["วันหยุดพักผ่อนประจำปี"]![1] -
                                            used <=
                                        0)
                                    ? (data[0].leaveValue! - used < 0
                                        ? const Text("สิทธิการลาไม่เพียงพอ",
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.red))
                                        : Text(
                                            "${data[0].leaveValue!.toStringAsFixed(2)} วัน",
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey.shade500)))
                                    : Text(
                                        "${leaveUsedData["วันหยุดพักผ่อนประจำปี"]![1] - used} วัน",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade500))
                              ] else ...[
                                (leaveRemain) < 0
                                    ? const Text(
                                        "สิทธิการลาไม่เพียงพอ",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red),
                                      )
                                    : Text(
                                        leaveRemain > 100
                                            ? 'ไม่จำกัด'
                                            : "${(leaveRemain).toStringAsFixed(2)} วัน",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade500),
                                      )
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 40,
                          child: Text(
                            "หมายเหตุ :",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  note == "" ? "-" : note,
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                        top: MediaQuery.of(context).devicePixelRatio * 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 40,
                          child: Text(
                            "ไฟล์แนบ :",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  filePath == null
                                      ? "-"
                                      : filePath!.files.first.name.toString(),
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                            backgroundColor:
                                (leaveUsedData[leaveType]![1] - used) < 0
                                    ? const Color(0xffC4C4C4)
                                    : const Color(0xff007AFE)),
                        onPressed: () {
                          if ((leaveUsedData[leaveType]![1] - used) >= 0) {
                            ProfileProvider profileData = Provider.of<ProfileProvider>(context, listen: false);
                            bloc.add(SendLeaveRequestData(
                              idManager: profileData.profileData.managerLv1Id!,
                              idHoliday: null,
                              idEmployees: profileData.profileData.idEmp!,
                              isFullDay: isFullDay,
                              leaveType: leaveType,
                              startDay: start,
                              endDay: end,
                              note: note,
                              file: filePath,
                              leaveAuth: data,
                              used: double.parse(used.toStringAsFixed(2)),
                              remaining: double.parse((leaveUsedData[leaveType]![1] - used).toStringAsFixed(2)),
                              managerEmail: userInfo.profileData.managerLv1Email,
                            ));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuccessPage(
                                  bloc: bloc,
                                  isFullDay: isFullDay,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "ยืนยัน",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          ),

      ),
    );
  }
}
