import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../pages/edit_page/edit_emergency_contract/edit_emergency_page.dart';

class Reuse3LinesBox extends StatelessWidget {
  final String title;
  final String detail_1;
  final String detail_2;
  final String detail_3;
  final String data_1;
  final String data_2;
  final String data_3;
  final bool fix;
  const Reuse3LinesBox(
      {super.key,
      required this.title,
      required this.detail_1,
      required this.detail_2,
      required this.detail_3,
      required this.data_1,
      required this.data_2,
      required this.data_3,
      required this.fix});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.white,
            border: Border.all(color: Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            fix
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (fix) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditEmergencyContractPage(
                                          title: title,
                                          labels: [
                                            detail_1,
                                            detail_2,
                                            detail_3
                                          ],
                                          data: [data_1, data_2, data_3],
                                        )));
                          }
                        },
                        child: const Text(
                          "แก้ไข",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(238, 172, 25, 1),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  detail_1,
                  style:
                      const TextStyle(fontSize: 15, color: Color(0xff757575)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(child: Text(data_1,overflow: TextOverflow.ellipsis ,style: const TextStyle(fontSize: 15)))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail_2,
                  style:
                      const TextStyle(fontSize: 15, color: Color(0xff757575)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: Text(data_2, style: const TextStyle(fontSize: 15)))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  detail_3,
                  style:
                      const TextStyle(fontSize: 15, color: Color(0xff757575)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(data_3, style: const TextStyle(fontSize: 15))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
