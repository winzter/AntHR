import 'package:flutter/material.dart';

class EditAppbar extends StatelessWidget {
  final String title;
  const EditAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child:SizedBox(
          height: 150,
          child: AppBar(
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
                  icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,)),
              elevation: 0,
              toolbarHeight: 80,
              centerTitle: true,
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
              primary: false,
              title: Text("แก้ไข$title",style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w500),)
          ),
        ));
  }
}
