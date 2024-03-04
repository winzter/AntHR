import 'package:flutter/material.dart';
import '../../pages/edit_page/edit_contract/edit_contract_page.dart';

class Reuse2LinesBox extends StatelessWidget {
  final String title;
  final String detail_1;
  final String detail_2;
  final String data_1;
  final String data_2;
  const Reuse2LinesBox(
      {super.key,
      required this.title,
      required this.detail_1,
      required this.detail_2,
      required this.data_1,
      required this.data_2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
            Row(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditContractPage(
                                  title: title,
                                  labels: [detail_1, detail_2],
                                  data: [data_1, data_2],
                                )));
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
                Text(data_1, style: const TextStyle(fontSize: 15))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  detail_2,
                  style:
                      const TextStyle(fontSize: 15, color: Color(0xff757575)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(data_2, style: const TextStyle(fontSize: 15))
              ],
            ),
            const SizedBox(
              height: 10,
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
