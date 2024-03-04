import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';


class CheckInOutBody extends StatelessWidget {
  const CheckInOutBody({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "สวัสดี...",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                "${profileProvider.profileData.firstname??"ไม่ระบุ"} ${profileProvider.profileData.lastname??"ไม่ระบุ"}",
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "สถานที่",
              style: TextStyle(
                fontSize: 17,
                color: Colors.blueGrey,
              ),
            )
          ],
        ),
      ],
    );
  }
}
