import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../../../core/features/attendance/presentation/provider/attendance_provider.dart';
import '../../../../../core/features/login/presentation/pages/login_page.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../../../../../injection_container.dart';
import '../../../leave/presentation/bloc/leave_bloc.dart';
import '../../../payslip/presentation/provider/payslip_provider.dart';
import '../../../summary_shfit_ot/presentation/bloc/shift_ot_bloc.dart';
import '../provider/leave_provider.dart';
import '../widgets/appbar.dart';
import '../widgets/chart.dart';
import '../widgets/menu_circle.dart';
import '../widgets/menu_tabbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin{
  final DateTime now = DateTime.now();
  final LeaveBloc leaveAuthBloc = sl<LeaveBloc>();
  final ShiftOtBloc shiftOtBloc = sl<ShiftOtBloc>();
  late ProfileProvider profileProvider;
  late AttendanceProvider attendanceProvider;
  late GetPayslipProvider payslipProvider;
  late WaitingProvider waitingProvider;

  bool isError = false;
  // int currentPageIndex = 0;

  isLoading() async{
   try{
     profileProvider = ProfileProvider.of(context, listen: false);
     payslipProvider = GetPayslipProvider.of(context, listen: false);
     attendanceProvider = AttendanceProvider.of(context,listen: false);
     waitingProvider = WaitingProvider.of(context,listen: false);
     profileProvider.setIsLoading(true);
     await attendanceProvider.getAttendanceData().then((value) => isError = value);
     await profileProvider.getProfileData().then((value) => isError = value);
     await payslipProvider.getPreviousPayslipData().then((value) => isError = value);
     await waitingProvider.getAllData().then((value) => isError = value);
     if(isError){
       await QuickAlert.show(
           context: context,
           type: QuickAlertType.error,
           confirmBtnText: 'ตกลง',
           title: 'เกิดข้อผิดพลาด',
           text: "ไม่สามารถดึงข้อมูลได้ \nตรวจสอบอินเทอร์เน็ตของท่าน หรือ ติดต่อแอดมิน",
           confirmBtnColor: const Color(0xffE46A76),
           onConfirmBtnTap: () async{
             await LoginStorage.deleteAll();
             Navigator.pushReplacement(
               context,
               MaterialPageRoute(builder: (context) => const LoginPage()),
             );
           });
       await LoginStorage.deleteAll();
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => const LoginPage()),
       );
     }
     else{
       leaveAuthBloc.add(GetAllLeaveData());
       if (now.day >= 28) {
         shiftOtBloc.add(getShiftOT(
             start: DateFormat('yyyy-MM-dd')
                 .format(DateTime(now.year, now.month + 1, 1))));
       } else {
         shiftOtBloc.add(getShiftOT(
             start: DateFormat('yyyy-MM-dd')
                 .format(DateTime(now.year, now.month, 1))));
       }
       setState(() {
         waitingProvider.isApprove();
         waitingProvider.isNotApprove();
       });
       profileProvider.setIsLoading(false);
     }
   }catch(e){
     await QuickAlert.show(
         context: context,
         type: QuickAlertType.error,
         confirmBtnText: 'ตกลง',
         title: 'ไม่สามารถดึงข้อมูลของผู้ใช้ได้',
         text: "ตรวจสอบอินเทอร์เน็ตของท่าน หรือ ติดต่อแอดมิน",
         confirmBtnColor: const Color(0xffE46A76),
         onConfirmBtnTap: () async{
           await LoginStorage.deleteAll();
           Navigator.pushReplacement(
             context,
             MaterialPageRoute(builder: (context) => const LoginPage()),
           );
         });
     await LoginStorage.deleteAll();
     Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => const LoginPage()),
     );
     Logger().e("$e");
   }

  }
  @override
  void initState(){
    super.initState();
    isLoading();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<LeaveBloc>(
          create: (BuildContext context) => leaveAuthBloc,
        ),
        BlocProvider<ShiftOtBloc>(
          create: (BuildContext context) => shiftOtBloc,
        ),
      ],
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: ()async{
            isLoading();
        },
          child: Stack(
            children: [
              const Appbar(),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: double.infinity,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: const [MenuCircle()],
                          ),
                        ),
                         Row(children: [
                          Expanded(
                            child: ChartVacation(
                              bloc: leaveAuthBloc,
                            ),
                          ),
                          Expanded(
                            child: ChartDeduction(
                              bloc: shiftOtBloc,),
                          )
                        ]),
                        Padding(
                          padding: EdgeInsets.only(
                              left:
                              MediaQuery.of(context).devicePixelRatio * 9,
                              bottom:
                              MediaQuery.of(context).devicePixelRatio * 0.9),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "รายการคำขอ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        const WaitingStatus()
                      ],
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

  @override
  bool get wantKeepAlive => true;
}
