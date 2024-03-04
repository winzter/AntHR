import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabBarMenu extends StatefulWidget {
  final List<Widget> childrenWidget;
  final List<String> svgPaths;
  final List<String> title;
  final double? width;
  const TabBarMenu(
      {super.key,
      required this.childrenWidget,
      required this.svgPaths,
      required this.title,
      this.width});

  @override
  State<TabBarMenu> createState() => _TabBarMenuState();
}

class _TabBarMenuState extends State<TabBarMenu>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget tabs(int index, double? width) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
            gradient:  _tabController.index == index ?LinearGradient(colors: [
              const Color(0xffFFCA11),
              const Color(0xff277B89),
              const Color(0xff277B89).withOpacity(0.5),
              const Color(0xff27385E),
            ]):const LinearGradient(colors: [Colors.transparent,Colors.transparent]),
            border: Border.all(color: Colors.white),
            borderRadius:
            const BorderRadius.all(Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                _tabController.index == index
                    ? Colors.white
                    : const Color(0xffc4c4c4),
                BlendMode.srcIn,
              ),
              child: index == 1
                  ? SvgPicture.asset(
                      widget.svgPaths[index],
                      width: widget.width,
                    )
                  : SvgPicture.asset(
                      widget.svgPaths[index],
                      width: widget.width,
                    ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.title[index],
              style: GoogleFonts.kanit(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 100,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  const Color(0xff27385E),
                  widget.width != null
                      ? const Color(0xff275F77)
                      : const Color(0xff27385E),
                ])),
          ),
          primary: false,
          title: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: TabBar(
                overlayColor:MaterialStateProperty.all<Color>(Colors.transparent),
                controller: _tabController,
                onTap: (index) {
                  setState(() {
                    _tabController.index = index;
                  });
                },
                splashBorderRadius:
                    const BorderRadius.all(Radius.circular(15)),
                indicator: const BoxDecoration(),
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xffc4c4c4),
                tabs: [
              tabs(0, widget.width),
              tabs(1, widget.width),
            ]),
          ),
        ),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: widget.childrenWidget),
      ),
    );
  }
}
