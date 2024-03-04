import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import '../../domain/entities/entities.dart';
import '../widgets/overview_menu/leave_history_app_bar.dart';

class MonthLeaveList extends StatelessWidget {
  final DateTime? date;
  final OverviewEntity? overviewData;

  const MonthLeaveList({super.key, this.date, this.overviewData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context,
          "รายการลา${date != null ? DateFormat("เดือนMMMM").format(date!) : ''}"),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).devicePixelRatio*6,
            horizontal: MediaQuery.of(context).devicePixelRatio*3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (overviewData != null &&
                overviewData!.workingTimeEmployeeInfo!.leave!.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: overviewData!.workingTimeEmployeeInfo!.leave!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).devicePixelRatio*3),
                      child: SwipeableTile.card(
                        horizontalPadding: 4,
                        verticalPadding: 0,
                        color: Colors.white,
                        shadow: BoxShadow(
                          color: Colors.black.withOpacity(0.35),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                        swipeThreshold: 0.7,
                        direction: SwipeDirection.none,
                        onSwiped: (_) {},
                        key: UniqueKey(),
                        backgroundBuilder: (BuildContext context, SwipeDirection direction, AnimationController progress) {
                          return AnimatedBuilder(
                            animation: progress,
                            builder: (context, child) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                color: const Color(0xFFed7474),
                              );
                            },
                          );
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("${overviewData!.workingTimeEmployeeInfo!.leave![index].firstnameTh??'ไม่ระบุ'} ${overviewData!.workingTimeEmployeeInfo!.leave![index].lastnameTh??'ไม่ระบุ'}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              trailing: Text(overviewData!.workingTimeEmployeeInfo!.leave![index].name??'ไม่ระบุ',overflow: TextOverflow.ellipsis,),
                            ),
                            ListTile(
                              title: const Divider(thickness: 1,),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat("เริ่ม dd/MM/yyyy\n${overviewData!.workingTimeEmployeeInfo!.leave![index].isFullDay == 1?'เต็มวัน':'HH:mm'}").format(overviewData!.workingTimeEmployeeInfo!.leave![index].start!),textAlign: TextAlign.center,),
                                  Text(DateFormat("สิ้นสุด dd/MM/yyyy\n${overviewData!.workingTimeEmployeeInfo!.leave![index].isFullDay == 1?'เต็มวัน':'HH:mm'}").format(overviewData!.workingTimeEmployeeInfo!.leave![index].end!),textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                            ListTile(
                              title: const Divider(thickness: 1,),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(child: Text("เหตุผล: ${overviewData!.workingTimeEmployeeInfo!.leave![index].description}",textAlign: TextAlign.start,)),],
                              ),
                            )

                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ] else ...[
              Padding(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: Text(
                      "ไม่มีรายการลา${date != null ? DateFormat("ของเดือนMMMM").format(date!) : ''}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  )),
            ]
          ],
        ),
      ),
    );
  }
}
