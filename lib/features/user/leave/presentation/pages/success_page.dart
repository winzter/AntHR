import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../../components/widgets/loading.dart';
import '../bloc/leave_bloc.dart';

class SuccessPage extends StatelessWidget {
  final bool isFullDay;
  final LeaveBloc bloc;
  const SuccessPage({super.key, required this.isFullDay, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height*0.1,
        scrolledUnderElevation: 0,
        elevation: 0,
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                    Color(0xff275F77),
                    Color(0xff27385E),
                  ])),
            ),
          ],
        ),
        centerTitle: true,
        title: const Text(
          'ทำรายการลา',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => bloc,
          child: Column(
            children: [
              Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color(0xff275F77),
                            Color(0xff27385E),
                          ])
                  ),
                ),
                BlocBuilder<LeaveBloc, LeaveState>(builder: (context, state) {
                  if(state is LeaveLoading){
                    return Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color(0xff275F77),
                                    Color(0xff27385E),
                                  ])
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height*0.7,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Loading(color: Colors.white),
                                SizedBox(height: 15,),
                                Text("กำลังส่งข้อมูล...",style: TextStyle(color: Colors.white),),
                              ],
                            )),
                      ],
                    );
                  }
                  else if(state is LeaveFailure){
                    Column(
                      children: [
                        Text("เกิดข้อผิดพลาด ${state.error}",style: const TextStyle(),),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).devicePixelRatio * 10,
                          ),
                          child: SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor:
                                  const Color(0xff007AFE)),
                              onPressed: () {
                                int count = 0;
                                Navigator.of(context)
                                    .popUntil((_) => count++ >= 3);
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
                    );
                  }
                  else if (state is LeaveResult) {
                    return Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color(0xff275F77),
                                    Color(0xff27385E),
                                  ])
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).devicePixelRatio * 7),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).devicePixelRatio * 10,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery.of(context).devicePixelRatio *
                                            10),
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
                                        ]),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context).devicePixelRatio * 5),
                                          child: SvgPicture.asset(
                                            "assets/icons/success.svg",
                                            width: 100,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(top: 12),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ทำรายการลาสำเร็จ",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 12),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("ประเภท",
                                                  style:
                                                  TextStyle(fontSize: 18)),
                                              Text(state.leaveType,
                                                  style:
                                                  const TextStyle(fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("วันที่เริ่ม",
                                                  style:
                                                  TextStyle(fontSize: 18)),
                                              Text(
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(state.startDay),
                                                  style:
                                                  const TextStyle(fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible:!isFullDay,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text("เวลาที่เริ่ม",
                                                    style:
                                                    TextStyle(fontSize: 18)),
                                                Text(
                                                    DateFormat("HH : mm").format(state.startDay),
                                                    style:
                                                    const TextStyle(fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("วันที่สิ้นสุด",
                                                  style:
                                                  TextStyle(fontSize: 18)),
                                              Text(
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(state.endDay),
                                                  style:
                                                  const TextStyle(fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible:!isFullDay,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text("เวลาที่สิ้นสุด",
                                                    style:
                                                    TextStyle(fontSize: 18)),
                                                Text(
                                                    DateFormat("HH : mm").format(state.endDay),
                                                    style:
                                                    const TextStyle(fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("จำนวนวันลา",
                                                  style:
                                                  TextStyle(fontSize: 18)),
                                              Text("${state.uses} วัน",
                                                  style:
                                                  const TextStyle(fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("สิทธิคงเหลือ",
                                                  style:
                                                  TextStyle(fontSize: 18)),
                                              Text("${state.remainNow} วัน",
                                                  style:
                                                  const TextStyle(fontSize: 18)),
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
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("หมายเหตุ",
                                                  style:
                                                  TextStyle(fontSize: 18)),
                                              Text(state.note == ""?"-":state.note,
                                                  style:
                                                  const TextStyle(fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                    MediaQuery.of(context).devicePixelRatio * 10,
                                  ),
                                  child: SizedBox(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 5,
                                          backgroundColor: const Color(0xff007AFE)),
                                      onPressed: () {
                                        bloc.add(GetAllLeaveData());
                                        int count = 0;
                                        Navigator.of(context)
                                            .popUntil((_) => count++ >= 3);
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
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                }),
              ]),

            ],
          ),
        ),
      ),
    );
  }
}
