import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../components/tabbar_menu.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import 'leave_authorities_page.dart';
import 'leave_history_page.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {

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
      child: const TabBarMenu(
        childrenWidget: [LeaveAuthorityPage(),LeaveHistoryPage()],
        svgPaths: ["assets/icons/leave_auth.svg", "assets/icons/history.svg"],
        title: ["สิทธิการลา", "ประวัติ"],
        width: 20,
      ),
    );
  }
}
