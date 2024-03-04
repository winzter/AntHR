import 'package:flutter/material.dart';
import '../../../overview/presentation/pages/overview_main_page.dart';
import '../../../waiting_status/presentation/pages/waiting_status.dart';
import 'circle_icon.dart';

class MenuCircle extends StatelessWidget {
  const MenuCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.006,
        ),
         Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleIcons(
              ["assets/manager/home_page/overview.svg","assets/manager/home_page/overview.svg"],
              "มุมมองภาพรวม",
              // page: OverviewMainPage(),
              page: null,
              isDisable: true,
              index: 0,
              isLogOut: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const CircleIcons(
              ["assets/manager/home_page/user_profile.svg","assets/manager/home_page/user_profile.svg"],
              "พนักงาน",
              page: null,
              isDisable: true,
              index: 0,
              isLogOut: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const CircleIcons(["assets/manager/home_page/travelling.svg","assets/manager/home_page/travelling.svg"], "บันทึกการเดินทาง",
                page: null, isDisable: true, index: 0,isLogOut: false,),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleIcons(
              ["assets/manager/home_page/time_table.svg","assets/manager/home_page/time_table.svg"],
              "เวลาทำงาน",
              page: null,
              isDisable: true,
              index: 0,//TODO แก้เป็น 2
              isLogOut: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const CircleIcons(
              ["assets/manager/home_page/list_status.svg","assets/manager/home_page/list_status.svg"],
              "ประวัติสถานะรายการ",
              page: null,
              isDisable: true,
              index: 0,
              isLogOut: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const CircleIcons(
              ["assets/manager/home_page/list_status.svg","assets/manager/home_page/list_status.svg"],
              "ออกจากระบบ",
              page: null,
              isDisable: false,
              index: 0,
              isLogOut: true,
            ),

          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleIcons(["assets/manager/home_page/wait_list.svg","assets/manager/home_page/wait_list.svg"], "รออนุมัติ",
                page: WaitingStatusPage(), isDisable: false, index: 0,isLogOut: false,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const CircleIcons(
                ["assets/manager/home_page/request_leave.svg","assets/manager/home_page/request_leave.svg"], "การลา",
                page: null, isDisable: true, index: 0,isLogOut: false,),
          ],
        )
      ],
    );
  }
}