import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../../../components/widgets/loading.dart';
import '../../../../../../core/features/attendance/domain/entities/attendance_entity.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/individual_detail/workingtime_individual_bloc.dart';

class SuccessPage extends StatelessWidget {
  final bool isOTRequest;
  final CalculateTimeEntity result;
  final DateTime start;
  final DateTime end;
  final String requestType;
  final String reasonType;
  final String note;
  final AttendanceEntity data;
  final WorkingTimeIndividualBloc bloc;
  const SuccessPage(
      {super.key,
      required this.isOTRequest,
      required this.result,
      required this.start,
      required this.end,
      required this.requestType,
      required this.reasonType,
      required this.note,
      required this.data,
      required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                    Color(0xff275F77),
                    Color(0xff27385E),
                  ])),
            ),
            centerTitle: true,
            title: const Text(
              'รายการคำขอ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: BlocBuilder<WorkingTimeIndividualBloc, WorkingTimeIndividualState>(
            builder: (BuildContext context, state) {
              if (state is WorkingTimeIndividualLoading) {
                return const Loading(color: Colors.blueAccent,);
              } else if (state is WorkingTimeIndividualFailure) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).devicePixelRatio * 10,
                      ),
                      child: Text("เกิดข้อผิดพลาด ${state.error}",style: const TextStyle(fontSize: 17),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).devicePixelRatio * 10,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.065,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: const Color(0xff007AFE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            int count = 0;
                            Navigator.of(context)
                                .popUntil((_) => count++ >= 4);
                          },
                          child: const Text(
                            "ย้อนกลับ",
                            style: TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is SendTimeRequestSuccess) {
                return Stack(children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [Color(0xff275F77), Color(0xff27385E)])),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).devicePixelRatio * 7),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).devicePixelRatio * 10,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).devicePixelRatio * 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .devicePixelRatio *
                                                  5),
                                          child: SvgPicture.asset(
                                            "assets/icons/success.svg",
                                            width: 100,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .devicePixelRatio *
                                                  5),
                                          child: const Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ทำรายการคำขอสำเร็จ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .devicePixelRatio *
                                                  5),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              const Expanded(
                                                flex: 30,
                                                child: Text("ประเภท",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ),
                                              Expanded(
                                                flex: 60,
                                                child: Text(requestType,
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        fontSize: 18)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .devicePixelRatio *
                                                  5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Expanded(
                                                flex: 70,
                                                child: Text("วันที่เริ่ม",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ),
                                              Expanded(
                                                flex: 40,
                                                child: Text(
                                                    DateFormat("dd/MM/yyyy")
                                                        .format(start),
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        fontSize: 18)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .devicePixelRatio *
                                                  5),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 70,
                                                child: Text("เวลาที่เริ่ม",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ),
                                              Expanded(
                                                flex: 30,
                                                child: Text(
                                                    DateFormat("HH : mm")
                                                        .format(start),
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        fontSize: 18)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .devicePixelRatio *
                                                  5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Expanded(
                                                flex: 70,
                                                child: Text("วันที่สิ้นสุด",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ),
                                              Expanded(
                                                flex: 40,
                                                child: Text(
                                                    DateFormat("dd/MM/yyyy")
                                                        .format(end),
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        fontSize: 18)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .devicePixelRatio * 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Expanded(
                                                flex: 70,
                                                child: Text("เวลาที่สิ้นสุด",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ),
                                              Expanded(
                                                flex: 30,
                                                child: Text(
                                                    DateFormat("HH : mm")
                                                        .format(end),
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        fontSize: 18)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: isOTRequest,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                    .devicePixelRatio *
                                                    5),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                const Expanded(
                                                  flex: 45,
                                                  child: Text(
                                                    "จำนวนชั่วโมง :",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.w400),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 70,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "OT x 1    ${(result.xWorkingMonthlyHoliday / 60).toStringAsFixed(2)} ชม.",
                                                        textAlign:
                                                        TextAlign.end,
                                                        style:
                                                        const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "OT x 1.5   ${(result.xOT / 60).toStringAsFixed(2)} ชม.",
                                                        textAlign:
                                                        TextAlign.end,
                                                        style:
                                                        const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "OT x 3    ${(result.xOTHoliday / 60).toStringAsFixed(2)} ชม.",
                                                        textAlign:
                                                        TextAlign.end,
                                                        style:
                                                        const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.w400,
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
                                              top: MediaQuery.of(context)
                                                  .devicePixelRatio *
                                                  5),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const Expanded(
                                                flex: 35,
                                                child: Text(
                                                  "เหตุผล :",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 70,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        reasonType,
                                                        textAlign:
                                                        TextAlign.end,
                                                        style:
                                                        const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.w400,
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
                                              top: MediaQuery.of(context).devicePixelRatio * 5,
                                              bottom: MediaQuery.of(context).devicePixelRatio * 10),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const Expanded(
                                                flex: 50,
                                                child: Text(
                                                  "เหตุผลเพิ่มเติม :",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 50,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        note==""?"-":note,
                                                        textAlign: TextAlign.end,
                                                        softWrap: true,
                                                        style: const TextStyle(
                                                          fontSize: 18,
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
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).devicePixelRatio * 10,
                                  ),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 5,
                                          backgroundColor:
                                          const Color(0xff007AFE)),
                                      onPressed: () {
                                        int count = 0;
                                        Navigator.of(context)
                                            .popUntil((_) => count++ >= 4);
                                      },
                                      child: const Text(
                                        "เสร็จสิ้น",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]);
              }
              else {
                return Container();
              }
            },
          )),
    );
  }
}
