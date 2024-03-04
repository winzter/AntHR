import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../components/widgets/gap.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import 'individual_detail/individual_detail.dart';
import '../widgets/widgets.dart';

class WorkingTimePage extends StatefulWidget {
  const WorkingTimePage({super.key});

  @override
  State<WorkingTimePage> createState() => _WorkingTimePageState();
}

class _WorkingTimePageState extends State<WorkingTimePage> with SingleTickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

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
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ]
              ),
              child: Column(
                children: [
                  SvgPicture.asset("assets/icons/cancel.svg",width: 55,),
                  const Gap(height: 15),
                  const Text("ฟีเจอร์นี้ยังไม่เปิดให้บริการ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
        ],
      )
      // child: DefaultTabController(
      //   length: 3,
      //   child: Stack(
      //     children: [
      //       Positioned(
      //         top: 0,
      //         left: 0,
      //         right: 0,
      //         child: SizedBox(
      //           height: 100,
      //           child: AppBar(
      //             elevation: 0,
      //             toolbarHeight: 80,
      //             flexibleSpace: Container(
      //               decoration: const BoxDecoration(
      //                   gradient:  LinearGradient(
      //                       begin: Alignment.topLeft,
      //                       end: Alignment.bottomRight,
      //                       colors: [
      //                         Color(0xff27385E),
      //                         Color(0xff277B89),
      //                         Color(0xffFFCA11),
      //                       ])
      //               ),
      //             ),
      //             title: TabBar(
      //               controller: tabController,
      //               onTap: (value) {
      //                 setState(() {
      //                   tabController.index = value;
      //                 });
      //               },
      //               indicatorWeight: 5,
      //               labelPadding: const EdgeInsets.all(0),
      //               labelColor: Colors.white,
      //               indicator: const BoxDecoration(
      //                   gradient: LinearGradient(colors: [ Color(0xffFFCA11),Color(0xff275F77),])),
      //               indicatorPadding: const EdgeInsets.only(top:30,left: 25,right: 25),
      //               unselectedLabelColor: const Color(0xffC4C4C4),
      //               tabs:  const [
      //                 Text("ข้อมูลรายวัน",
      //                   style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
      //                 Text("ข้อมูลรายบุคคล",
      //                   style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //       Positioned(
      //         top: 80,
      //         left: 0,
      //         right: 0,
      //         bottom: 0,
      //         child: TabBarView(
      //           controller: tabController,
      //           physics: const NeverScrollableScrollPhysics(),
      //           children: const [
      //             EmployeeStatusTabBar(),
      //             IndividualDetail(),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
