import 'package:flutter/material.dart';

PreferredSizeWidget appBarOverview(BuildContext context,String title){
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back_ios_sharp, size: 30),
    ),
    scrolledUnderElevation: 0,
    elevation: 0,
    toolbarHeight: MediaQuery.of(context).size.height*0.1,
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0),
                Colors.white.withOpacity(0.3)
              ])),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
    ),
  );
}