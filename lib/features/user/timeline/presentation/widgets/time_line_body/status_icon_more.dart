import 'package:flutter/material.dart';
import '../../../domain/entities/entities.dart';

class StatusIconMore extends StatelessWidget {

  final TimeLineEntity data;
  const StatusIconMore({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: Row(
        children: [
          if (data.isLate! == true) ...[
            Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xffFFD7DB),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: const Text("มาสาย",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
            const SizedBox(
              width: 5,
              height: 5,
            ),
          ],
          if (data.isEarlyOut!) ...[
            Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xffFFD7DB),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: const Text("กลับก่อน",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
            const SizedBox(
              width: 5,
              height: 5,
            ),
          ],
          // if (data.isCompensation!) ...[
          //   Container(
          //       padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          //       decoration: BoxDecoration(
          //           color: const Color(0xffe8e1f6),
          //           borderRadius: BorderRadius.circular(15)
          //       ),
          //       child: const Text("วันหยุดชดเชยประเภทกะ",
          //         softWrap: true,
          //         overflow: TextOverflow.ellipsis,
          //         style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),
          //       )),
          //   const SizedBox(
          //     width: 5,
          //     height: 5,
          //   ),
          // ],
          if (data.holiday != null) ...[
            Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xffe8e1f6),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: const Text("วันหยุดประจำปี",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              width: 5,
              height: 5,
            ),
          ],
          if (data.absent!) ...[
            Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xffFFD7DB),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: const Text("ขาดงาน",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)
                )),
            const SizedBox(
              width: 5,
              height: 5,
            ),
          ],

        ],
      ),
    );
  }
}
