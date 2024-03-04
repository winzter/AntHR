import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';

AppBar appBar(BuildContext context,String title){
  final navigationProvider = Provider.of<NavIndex>(context);
  return AppBar(
    scrolledUnderElevation: 0,
    elevation: 0,
    toolbarHeight: 80,
    flexibleSpace: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient:  LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xff27385E),
                    Color(0xff277B89),
                    Color(0xffFFCA11),
                  ])
          ),
        ),
      ],
    ),
    leading: IconButton(
        onPressed: () {
          navigationProvider.setIndex(0);
          navigationProvider.controller.jumpToPage(0);
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        )),
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
          fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
    ),
  );
}