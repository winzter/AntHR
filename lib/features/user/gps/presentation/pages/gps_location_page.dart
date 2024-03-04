import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../components/widgets/gap.dart';
import '../../../../../core/features/attendance/presentation/provider/attendance_provider.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import '../widgets/widgets.dart';

class GpsLocationPage extends StatefulWidget {
  const GpsLocationPage({super.key});

  @override
  State<GpsLocationPage> createState() => _GpsLocationPageState();
}

class _GpsLocationPageState extends State<GpsLocationPage> {

  Future<bool> onBackPress() async{
    final NavIndex navigationProvider = Provider.of<NavIndex>(context,listen: false);
    navigationProvider.controller.jumpToPage(0);
    navigationProvider.setIndex(0);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context,listen: false);
    return PopScope(
      canPop: true,
      onPopInvoked: (bool test)=> onBackPress,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child:  RefreshIndicator(
            onRefresh: ()async=> attendanceProvider.getAttendanceData(),
            child: const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                  children: [
                    Gap(height: 15),
                    Header(),
                    Gap(height: 20),
                    DigiClock(),
                    Gap(height: 20),
                    SignIn(
                      isCheckIn: true,
                    ),
                    SignOut(
                      isAlreadyCheck: false,
                    ),
                    Gap(
                      height: 150,
                    )
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
