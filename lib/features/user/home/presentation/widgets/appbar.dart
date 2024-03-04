import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anthr/core/features/profile/user/presentation/provider/profile_provider.dart';
import 'package:anthr/features/user/home/presentation/widgets/third_page_view.dart';
import 'package:provider/provider.dart';
import 'first_page_view.dart';
import 'second_page_view.dart';

class Appbar extends StatefulWidget {
  const Appbar({super.key});

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Consumer(
            builder: (context, ProfileProvider data, child) {
              return AppBar(
                toolbarHeight: MediaQuery.of(context).size.height * 0.2,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff27385E),
                        Color(0xff277B89),
                        Color(0xff277B89),
                        Color(0xff275F77),
                        Color(0xff277B89),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height*0.17,
                          child: PageView(
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (int index){
                              setState(() {
                                currentPageIndex = index;
                              });
                            },
                            // controller: controller,
                            children: const [
                              FirstPageView(),
                              SecondPageView(),
                              ThirdPageView()
                            ],
                          )
                      ),
                      DotsIndicator(
                        dotsCount: 3,
                        position: currentPageIndex,
                        decorator: DotsDecorator(
                          color: const Color(0xffC4C4C4),
                          spacing: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).devicePixelRatio),// Inactive color
                          activeColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                primary: false,
              );
            },
          );
        });
  }
}