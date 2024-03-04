import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MileageFillBox extends StatefulWidget {
  const MileageFillBox({super.key});

  @override
  State<MileageFillBox> createState() => _MileageFillBoxState();
}

class _MileageFillBoxState extends State<MileageFillBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).devicePixelRatio * 10),
      decoration: const BoxDecoration(
        color: Color(0xff30B98F),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                ),
                child: const Text(
                  "เริ่มออกเดินทาง",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: Colors.white,
              indent: 30,
              endIndent: 30,
              thickness: 1,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    bottom:
                    MediaQuery.of(context).size.height * 0.02),
                child: const Text(
                  "ใส่เลขไมล์ก่อนเดินทาง",
                  style: TextStyle(
                      color: Colors.white, fontSize: 17),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pinput(
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                defaultPinTheme: PinTheme(
                    width: MediaQuery.of(context).size.width * 0.115,
                    height: MediaQuery.of(context).size.height * 0.07,
                    textStyle: const TextStyle(fontSize: 20),
                    decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    )),
                length: 6,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
