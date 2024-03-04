import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

PreferredSizeWidget MileageAppBar(BuildContext context){
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
    title: const Text(
      "บันทึก Mileage",
      style: TextStyle(
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
  );
}
