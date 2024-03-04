import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../bloc/WorkRecord_bloc.dart';
import '../pages/map_page.dart';

class WorkRecordBody extends StatelessWidget {
  final WorkRecordBloc workRecordBloc = sl<WorkRecordBloc>();

  WorkRecordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context);
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
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).devicePixelRatio * 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "${profileProvider.profileData.firstname ?? "ไม่ระบุ"} ${profileProvider.profileData.lastname ?? "ไม่ระบุ"}",
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).devicePixelRatio * 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              recordButton(
                title: 'บันทึกจุดเริ่ม',
                color: const Color(0xff87DC45),
                context: context,
                isCheck: true,
              ),
              const SizedBox(
                height: 15,
              ),
              recordButton(
                title: 'บันทึกจุดสิ้นสุด',
                color: const Color(0xffDC4545),
                context: context,
                isCheck: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget recordButton({
  required String title,
  required Color color,
  required BuildContext context,
  required bool isCheck,
}) {
  return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapPage(
                isCheck: isCheck,
              ),
            ));
      },
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout_sharp),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 19),
            )
          ],
        ),
      ));
}
