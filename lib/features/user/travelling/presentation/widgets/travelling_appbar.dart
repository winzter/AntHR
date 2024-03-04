import 'package:flutter/material.dart';

AppBar travellingAppBar(BuildContext context, String title) {
  return AppBar(
    scrolledUnderElevation: 0,
    elevation: 0,
    toolbarHeight: 100,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        color: Color(0xff27385E)
      ),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
          fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
    ),
    leading: IconButton(
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        )),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.my_location),
        iconSize: 30,
      )
    ],
  );
}
