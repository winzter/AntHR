import 'package:flutter/material.dart';
import 'package:anthr/core/features/profile/user/presentation/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'first_page_view.dart';

class Appbar extends StatefulWidget {
  const Appbar({super.key});

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ProfileProvider data, child) {
        return AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.2,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient:  LinearGradient(
                begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                      Color(0xff27385E),
                      Color(0xff27385E),
                      Color(0xff27385E),
                      Color(0xff27385E),
                      Color(0xff27385E),
                      Color(0xff277B89),
                      Color(0xffFFCA11),
                    ])
            ),
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height*0.17,
                    child: const FirstPageView()
                ),
              ],
            ),
          ),
          primary: false,
        );
      },
    );
  }
}