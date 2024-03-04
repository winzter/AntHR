import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/waiting_status_bloc.dart';
import '../../providers/radio_button_provider.dart';


class ListItems extends StatefulWidget {
  final int index;
  final bool? isSelectAll;
  final LeaveRequestManager? dataLeave;
  final RequestTimeManager? requestTime;
  final List<WithdrawLeaveManager> withdrawData;
  final List<PayrollSetting> payrollSettingData;
  // final String type;
  final WaitingStatusBloc bloc;

  const ListItems({
    super.key,
    required this.index,
    this.dataLeave,
    this.requestTime,
    required this.withdrawData,
    // required this.type,
    required this.payrollSettingData,
    required this.bloc,
    required this.isSelectAll});

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  bool isSelected = false;


  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ManagerRadioButtonProvider>(context);
    item.selectedFlag.contains(widget.index)?isSelected = true:isSelected = false;
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
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
          backgroundBuilder: (context, direction, progress) {
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
          key: UniqueKey(),
          child: Container(
            decoration: BoxDecoration(
                color: isSelected?const Color(0xffCBE4FF):Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              children: [
                ListTile(
                  onTap: (){
                    setState(() {
                      isSelected = !isSelected;
                      item.onTap(widget.index);
                    });
                  },
                  title: Text(
                    widget.dataLeave == null ? "${widget.requestTime!.firstname} ${widget.requestTime!.lastname}"
                        : "${widget.dataLeave!.firstname} ${widget.dataLeave!.lastname}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: () {
                    if (widget.dataLeave != null) {
                      return Text(widget.dataLeave!.positionsName!,style: const TextStyle(color: Color(0xff757575),fontSize: 15),);
                    } else {
                      return Text(widget.requestTime!.positionsName!,style: const TextStyle(color: Color(0xff757575),fontSize: 15));
                    }
                  }(),
                  trailing: Text(
                    widget.dataLeave != null
                        ?"${widget.dataLeave!.name!}\n"
                        :"${widget.requestTime!.name!}\n"
                  ,style: const TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  title: const Divider(),
                  onTap: (){
                    setState(() {
                      isSelected = !isSelected;
                      item.onTap(widget.index);
                    });
                  },
                  subtitle: () {
                    if (widget.dataLeave != null) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if(widget.dataLeave!.start!.hour == widget.dataLeave!.end!.hour && widget.dataLeave!.start!.minute == widget.dataLeave!.end!.minute)...[
                            Text(DateFormat("เริ่ม d/MM/yyyy\nเต็มวัน").format(widget.dataLeave!.start!),style: const TextStyle(fontSize: 15),),
                            Text(DateFormat("สิ้นสุด d/MM/yyyy\nเต็มวัน").format(widget.dataLeave!.end!),style: const TextStyle(fontSize: 15),)
                          ]
                          else...[
                            Text(DateFormat("เริ่ม d/MM/yyyy\nHH:mm").format(widget.dataLeave!.start!),style: const TextStyle(fontSize: 15),),
                            Text(DateFormat("สิ้นสุด d/MM/yyyy\nHH:mm").format(widget.dataLeave!.end!),style: const TextStyle(fontSize: 15),)
                          ]
                        ],
                      );
                    } else {
                      return  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if(widget.requestTime!.start!.hour == widget.requestTime!.end!.hour && widget.requestTime!.start!.minute == widget.requestTime!.end!.minute)...[
                            Text(DateFormat("เริ่ม d/MM/yyyy\nเต็มวัน").format(widget.requestTime!.start!),style: const TextStyle(fontSize: 15),),
                            Text(DateFormat("สิ้นสุด d/MM/yyyy\nเต็มวัน").format(widget.requestTime!.end!),style: const TextStyle(fontSize: 15),)
                          ]
                          else...[
                            Text(DateFormat("เริ่ม d/MM/yyyy\nHH:mm").format(widget.requestTime!.start!),style: const TextStyle(fontSize: 15),),
                            Text(DateFormat("สิ้นสุด d/MM/yyyy\nHH:mm").format(widget.requestTime!.end!),style: const TextStyle(fontSize: 15),)
                          ]
                        ],
                      );
                    }
                  }(),
                ),
                ExpandChild(
                    indicatorCollapsedHint: "",
                    indicatorExpandedHint: "",
                    indicatorPadding: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.dataLeave == null
                                    && (widget.requestTime!.xOt != 0
                                        || widget.requestTime!.xWorkingDailyHoliday != 0
                                        ||widget.requestTime!.xOtHoliday != 0
                                        || widget.requestTime!.xWorkingMonthlyHoliday != 0)) ...[
                                  const Text("ชั่วโมงล่วงเวลา",
                                      style: TextStyle(fontSize: 15)),
                                  if(widget.requestTime!.xOt != 0)
                                    Text(
                                        "OT x 1 = ${(widget.requestTime!.xOt!/60).toStringAsFixed(2)} ชม.",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff757575))),
                                  if(widget.requestTime!.xWorkingDailyHoliday != 0)
                                    Text(
                                        "OT x 1.5 = ${(widget.requestTime!.xWorkingDailyHoliday!/60).toStringAsFixed(2)} ชม.",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff757575))),
                                  if(widget.requestTime!.xWorkingMonthlyHoliday != 0)
                                    Text(
                                        "OT x 1.5 = ${(widget.requestTime!.xWorkingMonthlyHoliday!/60).toStringAsFixed(2)} ชม.",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff757575))),
                                  if(widget.requestTime!.xOtHoliday != 0)
                                    Text(
                                        "OT x 3 = ${(widget.requestTime!.xOtHoliday!/60).toStringAsFixed(2)} ชม.",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff757575))),
                                  const Divider(),
                                ]
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.dataLeave == null) ...[
                                  Text("${widget.requestTime!.requestReasonName}",
                                      style: const TextStyle(fontSize: 15)),
                                  Text(
                                      "เหตุผลเพิ่มเติม : ${widget.requestTime!.otherReason == "" ? "-" : widget.requestTime!.otherReason}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff757575)))
                                ] else ...[
                                  const Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("เหตุผล",
                                            style: TextStyle(
                                                fontSize: 15)),
                                      ]),
                                  Text(
                                      "${widget.dataLeave!.description == null || widget.dataLeave!.description == "" ? "-" : widget.dataLeave!.description}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff757575))),
                                ]
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
