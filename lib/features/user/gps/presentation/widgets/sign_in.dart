import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/attendance/presentation/provider/attendance_provider.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../pages/google_map/display_map.dart';

class SignIn extends StatefulWidget {
  final bool isCheckIn;
  const SignIn({super.key, required this.isCheckIn});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
        margin: const EdgeInsets.only(bottom: 15),
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
                  DateFormat("E dd/MM/yyyy").format(DateTime.now()),
                  style: const TextStyle(
                    fontSize: 20,color: Colors.black
                  ),
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
                  attendanceProvider.attendanceData.isNotEmpty && (attendanceProvider.attendanceData[1].attendance!.round1!.checkIn != null)?
            attendanceProvider.attendanceData[1].attendance!.round1!.checkIn!.attendanceTextTime!:"",
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
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).devicePixelRatio*3,),
                child: const Text(
                  // attendanceProvider.isCheckIn ? "ลงชื่อสำเร็จ" :
                  "ลงชื่อเข้า",
                  style: TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w500,color: Colors.white),
                ),
              ),
              icon:
              // attendanceProvider.isCheckIn
              //     ? SvgPicture.asset(
              //   "assets/icons/approve.svg",
              //   width: 25,
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
                    // attendanceProvider.isCheckIn
                    // ? Colors.grey
                    // :
                    allLoading.isLoading?Colors.grey:const Color(0xff30B98F)),
              ),
              onPressed: () {
                if(!allLoading.isLoading){
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => const DisplayGoogleMap(checkInOut: true,))).then((value) => attendanceProvider.getAttendanceData());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}