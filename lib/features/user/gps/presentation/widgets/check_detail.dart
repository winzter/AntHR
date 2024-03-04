import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:anthr/core/features/profile/user/presentation/provider/profile_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../../core/features/attendance/presentation/provider/attendance_provider.dart';
import '../bloc/gps_bloc.dart';
import 'widgets.dart';

class CheckDetail extends StatefulWidget {
  final bool checkInOut;
  final GlobalKey<FormState> formKey;
  final GpsBloc bloc;

  const CheckDetail(
      {super.key,
      required this.checkInOut,
      required this.formKey,
      required this.bloc});

  @override
  State<CheckDetail> createState() => _CheckDetailState();
}

class _CheckDetailState extends State<CheckDetail> {
  @override
  Widget build(BuildContext context) {
    final AttendanceProvider attendanceProvider =
        Provider.of<AttendanceProvider>(context);
    final ProfileProvider profile = Provider.of<ProfileProvider>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white),
      child: Column(
        children: [
          Text(
            "บันทึกเวลา${widget.checkInOut ? 'เข้า' : 'ออก'}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 15,
          ),
          const CheckInOutHeader(),
          const CheckInOutBody(),
          BlocBuilder<GpsBloc, GpsState>(builder: (context, state) {
            if (state.status == FetchStatus.fetching) {
              return const Text("กำลังดึงข้อมูล...");
            } else if (state.isPoint) {
              return Column(
                children: [
                  if (state.address != null) ...[
                    AddressDetail(address: state.address!)
                  ],
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              state.address != null
                                  ? (widget.checkInOut
                                      ? const Color(0xff30B98F)
                                      : Colors.red)
                                  : Colors.grey),
                        ),
                        onPressed: () async {
                          if (state.address != null &&
                              widget.formKey.currentState!.validate()) {
                            await QuickAlert.show(
                              context: context,
                              autoCloseDuration: const Duration(seconds: 1),
                              type: QuickAlertType.loading,
                              title: 'กำลังลงชื่อ...',
                              text: DateFormat('วันที่ dd MMM yyyy').format(
                                DateTime.now(),
                              ),
                            );
                            widget.checkInOut
                                ? attendanceProvider.setIsCheckIn(true)
                                : attendanceProvider.setIsCheckOut(true);
                            widget.bloc.add(SendGPSLocation(
                                attendanceDateTime:
                                    DateFormat('yyyy-MM-dd HH:mm:ss')
                                        .format(DateTime.now()),
                                isCheckIn: widget.checkInOut ? 1 : 0,
                                idAttendanceType: 4,
                                idGpsLocation: attendanceProvider.idGpsLocation,
                                idEmployee: profile.profileData.idEmp!,
                                idCompany: profile.profileData.idCompany!));
                            await QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                confirmBtnText: 'ยืนยัน',
                                title: 'ลงชื่อสำเร็จ!',
                                confirmBtnColor: const Color(0xff30B98F),
                                onConfirmBtnTap: () {
                                  Navigator.pop(context);
                                });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            widget.checkInOut
                                ? "ยืนยันเวลาเข้างาน"
                                : "ยืนยันเวลาออกงาน",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        )),
                  ),
                ],
              );
            } else if (state.status == FetchStatus.selected) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField2(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorStyle: TextStyle(fontSize: 14),
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "เลือกสถานที่";
                        } else if (attendanceProvider.isAtStatus == false) {
                          return "คุณไม่ได้อยู้ในพื้นที่ทำงาน";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      hint: const Text(
                        "เลือกสถานที่",
                        style: TextStyle(
                            fontFamily: 'kanit',
                            fontSize: 18,
                            color: Colors.grey),
                      ),
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      items: state.dropDownData,
                      onChanged: (String? value) {
                        widget.bloc
                            .add(ChangeLocation(selectedLocation: value!));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              (widget.checkInOut
                                  ? const Color(0xff30B98F)
                                  : Colors.red)),
                        ),
                        onPressed: () async {
                          if (widget.formKey.currentState!.validate()) {
                            widget.checkInOut
                                ? attendanceProvider.setIsCheckIn(true)
                                : attendanceProvider.setIsCheckOut(true);
                            widget.bloc.add(SendGPSLocation(
                                attendanceDateTime:
                                    DateFormat('yyyy-MM-dd HH:mm:ss')
                                        .format(DateTime.now()),
                                isCheckIn: widget.checkInOut ? 1 : 0,
                                idAttendanceType: 1,
                                idGpsLocation: attendanceProvider.idGpsLocation,
                                idEmployee: profile.profileData.idEmp!,
                                idCompany: profile.profileData.idCompany!));
                            await QuickAlert.show(
                              context: context,
                              autoCloseDuration: const Duration(seconds: 1),
                              type: QuickAlertType.loading,
                              title: 'กำลังลงชื่อ...',
                              text: DateFormat('วันที่ dd MMM yyyy').format(
                                DateTime.now(),
                              ),
                            );
                            await QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                confirmBtnText: 'ยืนยัน',
                                title: 'ลงชื่อสำเร็จ!',
                                onConfirmBtnTap: () {
                                  Navigator.pop(context);
                                  // Navigator.pop(context);
                                  // navIndex.setIndex(0);
                                  // navIndex.controller.jumpToPage(0);
                                });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            widget.checkInOut
                                ? "ยืนยันเวลาเข้างาน"
                                : "ยืนยันเวลาออกงาน",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        )),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField2(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorStyle: TextStyle(fontSize: 14),
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "เลือกสถานที่";
                        } else if (attendanceProvider.isAtStatus == false) {
                          return "คุณไม่ได้อยู้ในพื้นที่ทำงาน";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      hint: const Text(
                        "เลือกสถานที่",
                        style: TextStyle(
                            fontFamily: 'kanit',
                            fontSize: 18,
                            color: Colors.grey),
                      ),
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      items: state.dropDownData,
                      onChanged: (String? value) {
                        widget.bloc
                            .add(ChangeLocation(selectedLocation: value!));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey)),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            widget.checkInOut
                                ? "ยืนยันเวลาเข้างาน"
                                : "ยืนยันเวลาออกงาน",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        )),
                  ),
                ],
              );
            }
          }),
          // dropdownLocation(),
        ],
      ),
    );
  }
}
