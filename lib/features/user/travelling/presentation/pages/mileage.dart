import 'package:flutter/material.dart';
import '../widgets/mileage/widgets.dart';
import './success_page.dart';

class MileagePage extends StatefulWidget {
  const MileagePage({super.key});

  @override
  State<MileagePage> createState() => _MileagePageState();
}

class _MileagePageState extends State<MileagePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MileageAppBar(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).devicePixelRatio * 5,
                horizontal: MediaQuery.of(context).devicePixelRatio * 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MileageFillBox(),
                Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 100),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            elevation: 5,
                            backgroundColor: const Color(0xff007AFE)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SuccessPage(),
                              ));
                        },
                        child: const Text(
                          "ยืนยัน",
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Color(0xff007AFE), width: 2.5),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )),
                          elevation: 0,
                          backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SuccessPage(),
                            ));
                      },
                      child: const Text(
                        "ข้าม",
                        style: TextStyle(
                            color: Color(0xff007AFE), fontSize: 18),
                      ),
                    ),
                  ),
                ],)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
