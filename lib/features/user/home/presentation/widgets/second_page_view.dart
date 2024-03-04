import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/features/attendance/presentation/provider/attendance_provider.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';


class SecondPageView extends StatelessWidget {
  const SecondPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceProvider attendanceProvider = Provider.of<AttendanceProvider>(context);
    final ProfileProvider user = Provider.of<ProfileProvider>(context);
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "สถานะลงเวลา",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23,color: Colors.white),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                user.isLoading == false?Container(
                  decoration: BoxDecoration(
                      color: const Color(0x80EAEDF2), borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).devicePixelRatio * 7.5,
                      vertical: MediaQuery.of(context).devicePixelRatio * 4),
                  child: Column(
                    children: [
                      if (attendanceProvider.attendanceData.isNotEmpty && attendanceProvider.attendanceData[1].attendance!.round1!.checkIn != null) ...[
                        const Text(
                          "ลงชื่อเข้าสำเร็จ",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400,color: Colors.white),
                        ),
                        Text(
                            "เวลา ${attendanceProvider.attendanceData[1].attendance!.round1!.checkIn!.attendanceTextTime}",
                            style: const TextStyle(fontSize: 16,color: Colors.white)),
                      ] else ...[
                        const Text(
                          "ยังไม่ลงชื่อเข้า",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400,color: Colors.white),
                        ),
                        const Text("-", style: TextStyle(fontSize: 16,color: Colors.white)),
                      ]
                    ],
                  ),
                ):Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 70,
                      decoration: ShapeDecoration(
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    )),
                user.isLoading == false?Container(
                  decoration: BoxDecoration(
                      color: const Color(0x80EAEDF2), borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).devicePixelRatio * 7.5,
                      vertical: MediaQuery.of(context).devicePixelRatio * 4),
                  child: Column(
                    children: [
                      if (attendanceProvider.attendanceData.isNotEmpty && attendanceProvider.attendanceData[1].attendance!.round1!.checkOut != null) ...[
                        const Text(
                          "ลงชื่อออกสำเร็จ",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400,color: Colors.white),
                        ),
                        Text(
                            "เวลา ${attendanceProvider.attendanceData[1].attendance!.round1!.checkOut!.attendanceTextTime}",
                            style: const TextStyle(fontSize: 16,color: Colors.white)),
                      ] else ...[
                        const Text(
                          "ยังไม่ลงชื่อออก",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400,color: Colors.white),
                        ),
                        const Text("-", style: TextStyle(fontSize: 16,color: Colors.white)),
                      ]
                    ],
                  ),
                ):Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 70,
                      decoration: ShapeDecoration(
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    )),
              ],
            )
          ],
        ),
        user.isLoading == false?Positioned(
            left: MediaQuery.of(context).size.width * 0.21,
            top: MediaQuery.of(context).size.height * 0.05,
            child: attendanceProvider.attendanceData.isNotEmpty &&  attendanceProvider.attendanceData[1].attendance!.round1!.checkIn != null
                ? SvgPicture.asset("assets/icons/approve.svg")
                : SvgPicture.asset("assets/icons/not_approve.svg")
        ):const SizedBox(),
        user.isLoading == false?Positioned(
            right: MediaQuery.of(context).size.width * 0.22,
            top: MediaQuery.of(context).size.height * 0.05,
            child:attendanceProvider.attendanceData.isNotEmpty &&  attendanceProvider.attendanceData[1].attendance!.round1!.checkOut != null
                ? SvgPicture.asset("assets/icons/approve.svg")
                : SvgPicture.asset("assets/icons/not_approve.svg")
        ):const SizedBox()
      ]
    );
  }
}
