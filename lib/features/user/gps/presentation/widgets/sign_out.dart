import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/attendance/presentation/provider/attendance_provider.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../pages/google_map/display_map.dart';

class SignOut extends StatefulWidget {
  final bool isAlreadyCheck;
  const SignOut({super.key, required this.isAlreadyCheck});

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    final allLoading = Provider.of<ProfileProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).devicePixelRatio*25),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical:MediaQuery.of(context).devicePixelRatio*5,
          horizontal:MediaQuery.of(context).devicePixelRatio*5,
        ),
        margin:  EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio*4),
        decoration: BoxDecoration(
          color: const Color(0xffC8D6ED),
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.13),
              offset: Offset(0, 0),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // "จ. 18/4/66",
                  DateFormat("E dd/MM/yy").format(DateTime.now()),
                  style: const TextStyle(fontSize: 20,color: Colors.black),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  attendanceProvider.attendanceData.isNotEmpty && (attendanceProvider.attendanceData[1].attendance!.round1!.checkOut != null)?
                  attendanceProvider.attendanceData[1].attendance!.round1!.checkOut!.attendanceTextTime!:"",
                  style: const TextStyle(
                      fontSize: 19,color: Color(0xff27385E)
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton.icon(
              label: Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).devicePixelRatio*3),
                child: const Text(
                  // attendanceProvider.isCheckOut ? "ลงชื่อสำเร็จ" :
                  "ลงชื่อออก",
                  style: TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w500,color: Colors.white),
                ),
              ),
              icon:
              // attendanceProvider.isCheckOut
              //     ? SvgPicture.asset(
              //   "assets/icons/approve.svg",
              //   width: 30,
              // )
              //     :
              const Icon(Icons.location_on_rounded,color: Colors.white),
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                    // attendanceProvider.isCheckOut
                    // ? Colors.grey
                    // :
                    allLoading.isLoading?Colors.grey: const Color(0xffFF6575)),
              ),
              onPressed: () {
                if(!allLoading.isLoading){
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => const DisplayGoogleMap(checkInOut: false,))).then((value) => attendanceProvider.getAttendanceData());
                }

              },
            ),
          ],
        ),
      ),
    );
  }
}