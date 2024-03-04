import 'package:anthr/features/manager/working_time/presentation/pages/working_time_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import '../features/manager/home/presentaion/pages/home_page.dart';
import '../features/manager/waiting_status/presentation/pages/waiting_status.dart';

class NavigatorBarManager extends StatefulWidget {
  const NavigatorBarManager({super.key});

  @override
  State<NavigatorBarManager> createState() => _NavigatorBarManagerState();
}

class _NavigatorBarManagerState extends State<NavigatorBarManager> {
  List<Widget> pages = [
    const HomePage(),
    const WaitingStatusPage(),
    // const WorkingTimePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavIndex>(context);

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true, //Bug
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationProvider.controller,
        onPageChanged: (index) {
          navigationProvider.setIndex(index);
        },
        children: pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 5)),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: GoogleFonts.kanit(),
              unselectedLabelStyle: GoogleFonts.kanit(),
              selectedItemColor: const Color.fromRGBO(235, 195, 28, 1),
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              selectedIconTheme: const IconThemeData(
                color: Color(0xff007AFE),
              ),
              onTap: (index) {
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WaitingStatusPage()),
                  );
                } else if (index != 2) {
                  //TODO แก้เหลือแค่ else ถ้าแก้ไขเวลาทำงานแล้ว
                  navigationProvider.controller.jumpToPage(index);
                  navigationProvider.setIndex(index);
                }
              },
              currentIndex: navigationProvider.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      navigationProvider.currentIndex == 0
                          ? const Color.fromRGBO(235, 195, 28, 1)
                          : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/home.svg",
                      width: 30,
                      height: 30,
                    ),
                  ),
                  label: "หน้าแรก",
                ),
                const BottomNavigationBarItem(
                  activeIcon: null,
                  icon: Icon(null),
                  label: "รออนุมัติ",
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      navigationProvider.currentIndex == 2
                          ? const Color.fromRGBO(235, 195, 28, 1)
                          : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/calendar.svg",
                      width: 30,
                      height: 30,
                    ),
                  ),
                  label: "เวลาทำงาน",
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FittedBox(
          child: FloatingActionButton(
            heroTag: 'navbar',
            hoverElevation: 10,
            splashColor: Colors.grey,
            elevation: 4,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: const RadialGradient(
                    colors: [
                      Color(0xffD3A54C),
                      Color(0xff277B89),
                      Color(0xff275F77),
                      Color(0xff27385E)
                    ],
                    center: Alignment(-1.0, -1.0),
                    focal: Alignment(-1.0, -1.0),
                    radius: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.library_books_sharp,
                  color: Colors.white,
                  size: 30,
                )),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WaitingStatusPage()),
              );
            },
          ),
        ),
      ),
    ));
  }
}
