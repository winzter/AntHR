// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import '../features/user/edit_profile/presentation/pages/edit_profile_page.dart';
import '../features/user/gps/presentation/pages/gps_location_page.dart';
import '../features/user/home/presentation/pages/home_page.dart';
import '../features/user/leave/presentation/pages/leave_page.dart';
import '../features/user/timeline/presentation/pages/timeline_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  List<Widget> pages = [
    const HomePage(),
    const TimeLinePage(),
    const GpsLocationPage(),
    const LeavePage(),
    const EditProfilePage()
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
        child: SizedBox(
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
                  color: Color.fromRGBO(235, 195, 28, 1),
                ),
                onTap: (index) {
                  navigationProvider.controller.jumpToPage(index);
                  navigationProvider.setIndex(index);
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
                  BottomNavigationBarItem(
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        navigationProvider.currentIndex == 1
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
                    label: "ตารางเวลา",
                  ),
                  const BottomNavigationBarItem(
                    activeIcon: null,
                    icon: Icon(null),
                    label: "ลงเวลา",
                  ),
                  BottomNavigationBarItem(
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        navigationProvider.currentIndex == 3
                            ? const Color.fromRGBO(235, 195, 28, 1)
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/leave.svg",
                        width: 30,
                        height: 30,
                      ),
                    ),
                    label: "ลางาน",
                  ),
                  BottomNavigationBarItem(
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        navigationProvider.currentIndex == 4
                            ? const Color.fromRGBO(235, 195, 28, 1)
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/profile.svg",
                        width: 30,
                        height: 30,
                      ),
                    ),
                    label: "โปรไฟล์",
                  ),
                ],
              ),
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
                Icons.location_on_outlined,
                size: 35,
              ),
            ),
            onPressed: () => setState(() {
              navigationProvider.controller.jumpToPage(2);
              navigationProvider.setIndex(2);
            }),
          ),
        ),
      ),
    ));
  }
}
