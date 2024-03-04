import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/widgets/shimmer.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../bloc/timeline_bloc.dart';
import '../widgets/timetable_body.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage>
    with AutomaticKeepAliveClientMixin {
  final TimelineBloc timelineBloc = sl<TimelineBloc>();
  final now = DateTime.now();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  DateTime? startMonth;

  @override
  void initState() {
    super.initState();
    final ProfileProvider user =
        Provider.of<ProfileProvider>(context, listen: false);
    startMonth = DateTime.now();
    monthController.text = DateFormat("MMMM").format(DateTime.now());
    yearController.text = DateFormat("yyyy").format(DateTime.now());
    timelineBloc.add(GetTimeLineData(
        startDate: DateTime(now.year, now.month, 1),
        endDate: DateTime(now.year, now.month + 1, 0),
        idCompany: user.profileData.idCompany!,
        idVendor: user.profileData.idVendor!));
  }

  void monthPicker() {
    final ProfileProvider user =
        Provider.of<ProfileProvider>(context, listen: false);
    showMonthPicker(
      headerColor: const Color(0xff27385E),
      selectedMonthBackgroundColor: const Color(0xff27385E),
      unselectedMonthTextColor: const Color(0xff27385E),
      confirmWidget: const Text(
        "ตกลง",
        style: TextStyle(color: Color(0xff27385E), fontSize: 17),
      ),
      cancelWidget: const Text(
        "ยกเลิก",
        style: TextStyle(color: Colors.red, fontSize: 17),
      ),
      context: context,
      initialDate: startMonth,
    ).then((date) {
      if (date != null) {
        setState(() {
          startMonth = date;
          monthController.text = DateFormat("MMMM").format(date);
          yearController.text = DateFormat("yyyy").format(date);
          timelineBloc.add(GetTimeLineData(
              startDate: DateTime(date.year, date.month, 1),
              endDate: DateTime(date.year, date.month + 1, 0),
              idCompany: user.profileData.idCompany!,
              idVendor: user.profileData.idVendor!));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final allLoading = Provider.of<ProfileProvider>(context);
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 90,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 0.7),
                    child: const Text(
                      "เดือน",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      controller: monthController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffC4C4C4)),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffC4C4C4)),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 0.7),
                    child: const Text(
                      "ปี",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      controller: yearController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffC4C4C4)),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffC4C4C4)),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 0.7),
                child: InkWell(
                  onTap: monthPicker,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: const Color.fromRGBO(235, 195, 28, 1),
                        border: Border.all(color: Colors.transparent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(17))),
                    child: const Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => timelineBloc,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).devicePixelRatio * 5),
          child: RefreshIndicator(
            onRefresh: () async {
              startMonth = DateTime.now();
              monthController.text = DateFormat("MMMM").format(DateTime.now());
              yearController.text = DateFormat("yyyy").format(DateTime.now());
              timelineBloc.add(GetTimeLineData(
                  startDate: DateTime(now.year, now.month, 1),
                  endDate: DateTime(now.year, now.month + 1, 0),
                  idCompany: allLoading.profileData.idCompany!,
                  idVendor: allLoading.profileData.idVendor!));
            },
            child: BlocBuilder<TimelineBloc, TimelineState>(
              builder: (context, state) {
                if (state is TimelineInitial) {
                  return const Center(
                      child: Text(
                    "กำลังโหลดข้อมูล",
                    style: TextStyle(),
                  ));
                } else if (state.status == FetchStatus.fetching ||
                    allLoading.isLoading) {
                  return ShimmerComponent(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                  );
                } else if (state.status == FetchStatus.success) {
                  return TimeTableBody(
                    attendanceData: state.attendanceData,
                    showingData: state.showingData,
                    reasons: state.reasonData,
                    payrollData: state.payrollData!,
                  );
                } else if (state.status == FetchStatus.failed) {
                  return Text("เกิดข้อผิดพลาด ${state.error}");
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    monthController.dispose();
    yearController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
