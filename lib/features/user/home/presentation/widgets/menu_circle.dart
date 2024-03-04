import 'package:anthr/features/user/payslip/presentation/pages/national_id_auth.dart';
import 'package:flutter/material.dart';
import 'package:anthr/features/user/summary_shfit_ot/presentation/pages/shift_ot_page.dart';
// import 'package:anthr/features/user/working_record/presentation/pages/work_record_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import '../../../item_status/presentation/pages/item_status_page.dart';
import '../../../payslip/presentation/pages/payslip_page.dart';
// import '../../../travelling/presentation/pages/travelling_page.dart';

class CircleIcons extends StatelessWidget {
  final List<String> img;
  final String title;
  final Widget? page;
  final bool isDisable;
  final int index;

  const CircleIcons(this.img, this.title,
      {super.key,
        required this.page,
        required this.index,
        required this.isDisable});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavIndex>(context);
    return GestureDetector(
      onTap: () {
        if (page != null && isDisable == false) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page!));
        } else if(isDisable == false){
          navigationProvider.controller.jumpToPage(index);
          navigationProvider.setIndex(index);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.015),
            decoration:  BoxDecoration(
              color: isDisable ? const Color(0xffc4c4c4) : const Color(0xff275F77),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 0.75))
              ],
              shape: BoxShape.circle,
            ),
            child:
            SvgPicture.asset(
              isDisable? img[0]:img[1],
              width: MediaQuery.of(context).size.width * 0.04,
              height: MediaQuery.of(context).size.height * 0.05,
            )
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.015,
          ),
          Text(
            title,
            style: TextStyle(color: isDisable? Colors.grey : const Color(0xff275F77)),
          )
        ],
      ),
    );
  }
}

class CircleIconsWIthNull extends StatelessWidget {
  final String title;
  final Widget? page;
  final bool isDisable;
  final int index;
  final IconData? icons;

  const CircleIconsWIthNull(
      this.title, {
        super.key,
        required this.page,
        required this.index,
        required this.isDisable,
        required this.icons,
      });

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavIndex>(context);
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page!));
        } else {
          navigationProvider.controller.jumpToPage(index);
          navigationProvider.setIndex(index);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.3,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.015),
              decoration:  BoxDecoration(
                color: icons == null?Colors.transparent : isDisable? const Color(0xffc4c4c4):const Color(0xff275F77),
                shape: BoxShape.circle,
                boxShadow: icons == null?[] :const [

                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 0.75))
                ],
              ),
              child: Icon(
                icons,
                color: Colors.white,
                size: 42,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Text(
            title,
            style:  TextStyle(color: isDisable? Colors.grey:const Color(0xff275F77)),
          )
        ],
      ),
    );
  }
}
/*-------------------------------------------------*/

/* Slide menu with circle icons */
class MenuCircle extends StatelessWidget {
  const MenuCircle({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileProvider userData = Provider.of<ProfileProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.035,
        ),
         Row(
          children: [
            CircleIcons(
              const ["assets/icons/grey_profile.svg","assets/icons/user_profile.svg"],
              "ประวัติส่วนตัว",
              page: null,
              isDisable: userData.isLoading,
              index: 4,
            ),
            CircleIcons(
              const ["assets/icons/grey_timetable.svg","assets/icons/time_table.svg"],
              "ตารางเวลาทำงาน",
              page: null,
              isDisable: userData.isLoading,
              index: 1,
            ),
            CircleIcons(
              const ["assets/icons/grey_leave.svg","assets/icons/request_leave.svg"],
              "ลางาน",
              page: null,
              isDisable: userData.isLoading,
              index: 3,
            ),
            CircleIcons(
              const ["assets/icons/grey_list_status.svg","assets/icons/list_status.svg"],
              "สถานะรายการ",
              page: const ItemStatusPage(),
              isDisable: userData.isLoading,
              index: 0,
            ),
            // CircleIcons(
            //   ["assets/icons/grey_time_manage.svg","assets/icons/time_manage.svg"],
            //   "จัดการเวลาทำงาน",
            //   page: null,
            //   isDisable: false,
            //   index: 0,
            // ),
            // CircleIconsWIthNull(
            //   "ลงเวลา Bluetooth",
            //   page: null,
            //   isDisable: userData.isLoading,
            //   index: 0,
            //   icons: Icons.bluetooth_connected,
            // ),
            const CircleIconsWIthNull(
              "บันทึกเวลาทำงาน",
              // page: WorkRecordPage(),
              page: null,
              // isDisable: userData.isLoading,
              isDisable: true,
              index: 0,
              icons: Icons.work_history,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Row(
          children: [
            CircleIcons(
                const ["assets/icons/grey_shift_ot.svg","assets/icons/shift_ot.svg"], "สรุปค่ากะและ OT",
                page: const SummaryShiftAndOTPage(), isDisable: userData.isLoading, index: 0),
            CircleIcons(
                const ["assets/icons/grey_payslip.svg","assets/icons/payslip.svg"], "สลิปเงินเดือน",
                page: userData.isLoading
                    ? null
                    : (userData.isPayslipValidate
                    ? const PaySlip()
                    : const NationalIdAuth()), isDisable: userData.isLoading, index: 0),
            const CircleIcons(["assets/icons/grey_learning.svg","assets/icons/learning.svg"], "อบรม",
                page: null, isDisable: true, index: 0),
            const CircleIcons(
                ["assets/icons/grey_mypaper.svg","assets/icons/my_paper.svg"], "เอกสารของฉัน",
                page: null, isDisable: true, index: 0),
            const CircleIcons(
                ["assets/icons/grey_travelling.svg","assets/icons/travelling.svg"], "บันทึกการเดินทาง",
                // page: const TravellingPage(),
                page: null,
                // isDisable: userData.isLoading,
                isDisable: true,
                index: 0,
            ),
            // const CircleIconsWIthNull(
            //   "",
            //   page: null,
            //   isDisable: true,
            //   index: 0,
            //   icons: null,
            // ),
          ],
        ),
      ],
    );
  }
}