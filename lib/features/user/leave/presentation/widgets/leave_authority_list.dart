import 'package:flutter/material.dart';
import '../../domain/entities/entities.dart';
import 'leave_auth_chart.dart';

class LeaveAuthorityList extends StatelessWidget {
  final List<LeaveAuthorityEntity> leaveAuthority;
  final Map<String,List<double>> leaveData;
  final List<double> used;
  final List<double> remaining;

  const LeaveAuthorityList({super.key,
    required this.leaveAuthority,
    required this.used,
    required this.remaining, required this.leaveData});

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(
  //         top: 5.0, left: 5, right: 5, bottom: 0),
  //     child: ListView.builder(
  //         physics: const BouncingScrollPhysics(),
  //         itemCount: leaveAuthority.length,
  //         itemBuilder: (context, index) {
  //           return Padding(
  //             padding: const EdgeInsets.all(8),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   border: Border.all(color: Colors.transparent),
  //                   borderRadius: BorderRadius.circular(20),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.grey.withOpacity(0.5),
  //                       spreadRadius: 5,
  //                       blurRadius: 7,
  //                       offset: const Offset(0, 3),
  //                     ),
  //                   ]),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 10.0, right: 15),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     Expanded(
  //                       child: Column(
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Container(width: 20,),
  //                               Flexible(
  //                                 child: Text(
  //                                   leaveAuthority[index].name ?? "-",
  //                                   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           const SizedBox(height: 20,),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                             children: [
  //                               Container(width: 20,),
  //                               Flexible(
  //                                 child: Text(
  //                                   "สิทธิการลา : \n${leaveAuthority[index].leaveValue ?? 'ไม่ระบุ'}",
  //                                   style: const TextStyle(color: Color(0xff757575)),
  //                                   textAlign: TextAlign.center,
  //                                 ),
  //                               ),
  //                                 Text(
  //                                   " คงเหลือ : \n${remaining[index] > 100 ? "ไม่ระบุ" : remaining[index].toStringAsFixed(2)}",
  //                                   style: const TextStyle(color: Color(0xff757575)),
  //                                   textAlign: TextAlign.center,
  //                                 )
  //
  //                             ],
  //                           ),
  //                           if(leaveAuthority[index].idLeaveType == 1 && leaveAuthority[index].carryValue != null)...[
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                               children: [
  //                                 Container(width: 20,),
  //                                 Flexible(
  //                                   child: Text(
  //                                     "สิทธิสะสม : \n${leaveAuthority[index].carryValue ?? 'ไม่จำกัด'}",
  //                                     style: const TextStyle(color: Color(0xff757575)),
  //                                   ),
  //                                 ),
  //                                 const SizedBox(width: 5,),
  //                                 Text(
  //                                   "คงเหลือ : ${remaining[index] == 999 ? "\nไม่จำกัด" :(leaveAuthority[index].carryValue! - used[index])<0?"0.00"
  //                                   // "คงเหลือ : \n${leaveData[leaveAuthority[index].name]![1] > 100 ? "ไม่จำกัด" :(leaveAuthority[index].carryValue! - leaveData[leaveAuthority[index].name]![0])<0?"0.00"
  //                                   :(leaveAuthority[index].carryValue! - used[index]).toStringAsFixed(2)}",
  //                                   //     :(leaveAuthority[index].carryValue! - leaveData[leaveAuthority[index].name]![0]).toStringAsFixed(2)}",
  //                                   style: const TextStyle(color: Color(0xff757575)),
  //                                 )
  //                               ],
  //                             ),
  //                           ]
  //                         ],
  //                       ),
  //                     ),
  //                     LeaveChart(
  //                         leaveData: [leaveAuthority[index]],
  //                         used: used[index])
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return leaveAuthority.isNotEmpty? Padding(
      padding: const EdgeInsets.only(
          top: 5.0, left: 5, right: 5, bottom: 0),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: leaveAuthority.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(width: 20,),
                                Flexible(
                                  child: Text(
                                    leaveAuthority[index].name ?? "-",
                                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(width: 20,),
                                Flexible(
                                  child: Text(
                                    "สิทธิการลา : \n${leaveAuthority[index].leaveValue ?? 'ไม่จำกัด'}",
                                    style: const TextStyle(color: Color(0xff757575)),
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                if(leaveAuthority[index].idLeaveType == 1
                                    && leaveAuthority[index].carryValue != null
                                )...[
                                  Text(
                                    // "คงเหลือ : ${remaining[index] == 999 ? "\nไม่จำกัด"
                                    "คงเหลือ : \n${leaveData[leaveAuthority[index].name]![1] > 100 ? "ไม่จำกัด"
                                    // : used[index]>=leaveAuthority[index].carryValue!
                                        : leaveData[leaveAuthority[index].name]![0] >=leaveAuthority[index].carryValue!
                                    // ?(leaveAuthority[index].leaveValue! - used[index]).toStringAsFixed(2)
                                        ?(leaveAuthority[index].leaveValue! - leaveData[leaveAuthority[index].name]![0]).toStringAsFixed(2)
                                        :leaveAuthority[index].leaveValue!.toStringAsFixed(2)
                                    }",
                                    style: const TextStyle(color: Color(0xff757575)),
                                  )
                                ]
                                else...[
                                  Text(
                                    // "คงเหลือ : ${remaining[index] == 999 ? "\nไม่จำกัด" : remaining[index].toStringAsFixed(2)}",
                                    "คงเหลือ : \n${leaveData[leaveAuthority[index].name]![1] > 100 ? "ไม่จำกัด" : leaveData[leaveAuthority[index].name]![1].toStringAsFixed(2)}",
                                    style: const TextStyle(color: Color(0xff757575)),
                                  )
                                ]

                              ],
                            ),
                            if(leaveAuthority[index].idLeaveType == 1 && leaveAuthority[index].carryValue != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(width: 20,),
                                  Flexible(
                                    child: Text(
                                      "สิทธิสะสม : \n${leaveAuthority[index].carryValue ?? 'ไม่จำกัด'}",
                                      style: const TextStyle(color: Color(0xff757575)),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  Text(
                                    // "คงเหลือ : ${remaining[index] == 999 ? "\nไม่จำกัด" :(leaveAuthority[index].carryValue! - used[index])<0?"0.00"
                                    "คงเหลือ : \n${leaveData[leaveAuthority[index].name]![1] > 100 ? "ไม่จำกัด" :(leaveAuthority[index].carryValue! - leaveData[leaveAuthority[index].name]![0])<0?"0.00"
                                    // :(leaveAuthority[index].carryValue! - used[index]).toStringAsFixed(2)}",
                                        :(leaveAuthority[index].carryValue! - leaveData[leaveAuthority[index].name]![0]).toStringAsFixed(2)}",
                                    style: const TextStyle(color: Color(0xff757575)),
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                      LeaveChart(
                          leaveData: [leaveAuthority[index]],
                          used: leaveData[leaveAuthority[index].name]![0])
                    ],
                  ),
                ),
              ),
            );
          }),
    ):const Center(child: Text("ไม่มีข้อมูลสิทธิ์การลา",style: TextStyle(fontSize: 17),),);
  }
}
