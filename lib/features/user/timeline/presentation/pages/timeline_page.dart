import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../components/tabbar_menu.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import 'calendar_page.dart';
import 'time_table_page.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({super.key});

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Future<bool> onBackPress() async{
    final NavIndex navigationProvider = Provider.of<NavIndex>(context,listen: false);
    navigationProvider.controller.jumpToPage(0);
    navigationProvider.setIndex(0);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: const TabBarMenu(childrenWidget: [
        TimeTablePage(),
        CalendarPage()
      ], svgPaths: [
        "assets/icons/calendar-clock.svg",
        "assets/icons/calendar-note.svg"
      ], title: [
        "ตารางเวลา",
        "ปฏิทิน"
      ]),
    );
  }
}
