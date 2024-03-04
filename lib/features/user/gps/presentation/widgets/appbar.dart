import 'package:flutter/material.dart';

AppBar appBar(BuildContext context,String title){
  return AppBar(
    scrolledUnderElevation: 0,
    elevation: 0,
    toolbarHeight: 90,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xff27385E),
            Color(0xff275F77),
          ],
        ),
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
  );
}