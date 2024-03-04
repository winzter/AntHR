import 'package:badges/badges.dart' as badges;
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import '../../../../../../core/features/profile/user/presentation/provider/profile_provider.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/item_status_bloc.dart';
import '../../provider/item_status_provider.dart';

class ListItems extends StatefulWidget {
  final int index;
  final LeaveEntity? dataLeave;
  final RequestTimeEntity? requestTime;
  final List<WithdrawEntity> withdrawData;
  final List<PayrollSettingEntity> payrollSettingData;
  final String type;
  final ItemStatusBloc bloc;

  const ListItems({super.key,
    required this.index,
    this.dataLeave,
    this.requestTime,
    required this.withdrawData,
    required this.type,
    required this.payrollSettingData,
    required this.bloc});

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {

  SwipeDirection direction(){
    if (widget.dataLeave == null) {
      if (widget.requestTime!.isWithdraw == 1 ||
          widget.requestTime!.isManagerLv1Approve == 0 ||
          widget.requestTime!.isManagerLv2Approve == 0) {
        return SwipeDirection.none;
      } else {
        return SwipeDirection.endToStart;
      }
    } else {
      if (widget.dataLeave!.isWithdraw == 1 || widget.dataLeave!.isApprove == 0) {
        return SwipeDirection.none;
      } else {
        return SwipeDirection.endToStart;
      }
    }
  }

  Future<bool?> confirmDeleteDialog() async{
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.dangerous_outlined,
                    color: Color(0xFFF15E5E),
                    size: 60,
                  ),
                  Text('คุณแน่ใจใช่ไหม?',
                    style: TextStyle(color: Color(0xff75838F)),
                  ),
                ],
              )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "ประเภท",
                style: TextStyle(fontSize: 14, color: Color(0xffAFB9C2)),
              ),
              if (widget.dataLeave == null) ...[
                Flexible(
                    child: Text(
                      widget.requestTime!.name!,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    )),
                const SizedBox(
                  height: 5,
                )
              ]
              else ...[
                Text(
                  widget.dataLeave!.name!,
                ),
              ],
              if (widget.dataLeave == null) ...[
                const Text(
                  "วันที่เริ่ม",
                  style: TextStyle(
                      fontSize: 14, color: Color(0xffAFB9C2)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(
                      widget.requestTime!.start!),
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "วันที่สิ้นสุด",
                  style: TextStyle(
                      fontSize: 14, color: Color(0xffAFB9C2)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('dd/MM/yyyy')
                      .format(widget.requestTime!.end!),
                  style: const TextStyle(fontSize: 17),
                ),
              ]
              else ...[
                const Text(
                  "วันที่เริ่ม",
                  style: TextStyle(
                      fontSize: 14, color: Color(0xffAFB9C2)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('dd/MM/yyyy')
                      .format(widget.dataLeave!.start!),
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "วันที่สิ้นสุด",
                  style: TextStyle(
                      fontSize: 14, color: Color(0xffAFB9C2)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('dd/MM/yyyy')
                      .format(widget.dataLeave!.end!),
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              child: const Text('ยกเลิก',
                  style: TextStyle(
                      color: Color(0xffA5AFBA))),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color(0xFFF15E5E)),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust the radius here
                    ),
                  )),
              child: const Text('ยืนยัน',
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                return Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final item = Provider.of<RadioButtonProvider>(context);
    WithdrawEntity? data;
    if (widget.withdrawData.isNotEmpty && widget.dataLeave != null && widget.type == "all" ||
        widget.type == "ขอลา") {
      for (var dataWithdraw in widget.withdrawData) {
        if (dataWithdraw.idLeave == widget.dataLeave!.idLeave!) {
          data = dataWithdraw;
        }
      }
    }
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
          direction: direction(),
          onSwiped: (_) {
            if (ModalRoute.of(context)?.isCurrent == true) {
              if(widget.dataLeave != null){
                widget.bloc.add(DeleteItemData(index: widget.index, type: widget.type,leaveData: widget.dataLeave));
              }else{
                widget.bloc.add(DeleteItemData(index: widget.index, type: widget.type,requestTime: widget.requestTime));
              }
            }
          },
          confirmSwipe: (_)=>confirmDeleteDialog(),
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
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              children: [
                ListTile(
                  leading: () {
                    if (widget.dataLeave != null) {
                      return badges.Badge(
                          position: badges.BadgePosition.topEnd(),
                          stackFit: StackFit.loose,
                          showBadge: () {
                            if (widget.dataLeave!.isApprove == 1 &&
                                widget.dataLeave!.isWithdraw == 1) {
                              return true;
                            }
                            return false;
                          }(),
                          ignorePointer: false,
                          onTap: () {},
                          badgeContent: const Text(""),
                          badgeStyle: badges.BadgeStyle(
                            shape: badges.BadgeShape.circle,
                            badgeColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SvgPicture.asset(
                            widget.dataLeave!.isApprove == 1 &&
                                widget.dataLeave!.isWithdraw == null
                                ? "assets/icons/approve.svg"
                                : (widget.dataLeave!.isApprove == 0 &&
                                widget.dataLeave!.isWithdraw == null
                                ? "assets/icons/cancel.svg"
                                : (widget.dataLeave!.isApprove == null &&
                                widget.dataLeave!.isWithdraw == null
                                ? "assets/icons/question.svg"
                                : (widget.dataLeave!.isApprove == 1 &&
                                data != null &&
                                data.isApprove == 1)
                                ? "assets/icons/grey_cancle.svg"
                                : ((widget.dataLeave!.isApprove == 1 &&
                                data != null &&
                                data.isApprove == null
                                ? "assets/icons/approve.svg"
                                : "assets/icons/grey_cancle.svg")))),
                            width: 30,
                          ));
                    }
                    else if (widget.requestTime != null) {
                      if (widget.requestTime!.isDoubleApproval == 0) {
                        return SvgPicture.asset(
                          widget.requestTime!.isManagerLv1Approve == 1 &&
                              widget.requestTime!.isWithdraw == null
                              ? "assets/icons/approve.svg"
                              : (widget.requestTime!.isManagerLv1Approve == 0 &&
                              widget.requestTime!.isWithdraw == null
                              ? "assets/icons/cancel.svg"
                              : (widget.requestTime!.isManagerLv1Approve == null &&
                              widget.requestTime!.isWithdraw == null
                              ? "assets/icons/question.svg"
                              : "assets/icons/grey_cancle.svg")),
                          width: 30,
                        );
                      } else {
                        return SvgPicture.asset(
                          widget.requestTime!.isManagerLv1Approve == 1 &&
                              widget.requestTime!.isManagerLv2Approve == 1 &&
                              widget.requestTime!.isWithdraw == null
                              ? "assets/icons/approve.svg"
                              : (widget.requestTime!.isManagerLv1Approve == 0 ||
                              widget.requestTime!.isManagerLv2Approve == 0 &&
                                  widget.requestTime!.isWithdraw == null
                              ? "assets/icons/cancel.svg"
                              : (widget.requestTime!.isManagerLv1Approve == null &&
                              widget.requestTime!.isWithdraw == null
                              ? "assets/icons/one.svg"
                              : (widget.requestTime!.isManagerLv1Approve == 1 &&
                              widget.requestTime!.isManagerLv2Approve ==
                                  null &&
                              widget.requestTime!.isWithdraw == null
                              ? "assets/icons/two.svg"
                              : "assets/icons/grey_cancle.svg"))),
                          width: 30,
                        );
                      }
                    }
                  }(),
                  title: Text(
                    widget.dataLeave == null ? widget.requestTime!.name! : widget.dataLeave!.name!,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: () {
                    if (widget.dataLeave != null) {
                      return const Text("");
                    } else {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(widget.payrollSettingData.isNotEmpty)...[
                              if (widget.requestTime!.xOt != 0) ...[
                                Text(
                                    "OT x ${widget.payrollSettingData[0].xOt} = ${(widget.requestTime!.xOt! / 60).toStringAsFixed(2)} ชม.",
                                    style: const TextStyle(fontSize: 14)),
                              ],
                              if (profileProvider.profileData.idPaymentType == 2 || profileProvider.profileData.idPaymentType == 4) ...[
                                if (widget.requestTime!.xWorkingMonthlyHoliday != 0) ...[
                                  Text(
                                      "OT x ${widget.payrollSettingData[0].xWorkingMonthlyHoliday} = ${(widget.requestTime!.xWorkingMonthlyHoliday! / 60).toStringAsFixed(2)} ชม.",
                                      style: const TextStyle(fontSize: 14)),
                                ],
                              ]
                              else ...[
                                if (widget.requestTime!.xWorkingDailyHoliday != 0) ...[
                                  Text(
                                      "OT x ${widget.payrollSettingData[0].xWorkingDailyHoliday} = ${(widget.requestTime!.xOt! / 60).toStringAsFixed(2)} ชม.",
                                      style: const TextStyle(fontSize: 14)),
                                ],
                              ],
                              if (widget.requestTime!.xOtHoliday != 0) ...[
                                Text(
                                    "OT x ${widget.payrollSettingData[0].xOtHoliday} = ${(widget.requestTime!.xOtHoliday! / 60).toStringAsFixed(2)} ชม.",
                                    style: const TextStyle(fontSize: 14)),
                              ]
                            ]
                          ]);
                    }
                  }(),
                  trailing: Text(
                    "${DateFormat('dd/MM/yyyy').format(widget.dataLeave == null ? widget.requestTime!.start! : widget.dataLeave!.start!)}"
                        "\n${item.isFullDay(widget.dataLeave == null ? widget.requestTime!.start! : widget.dataLeave!.start!, widget.dataLeave == null ? widget.requestTime!.end! : widget.dataLeave!.end!)}"
                    ,
                    style: const TextStyle(fontSize: 14),
                  ),
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
                                if (widget.dataLeave == null) ...[
                                  Text("${widget.requestTime!.reasonName}",
                                      style: const TextStyle(fontSize: 14)),
                                  Text(
                                      "เหตุผลเพิ่มเติม : ${widget.requestTime!.otherReason == "" ? "-" : widget.requestTime!.otherReason}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff757575)))
                                ] else ...[
                                  const Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("เหตุผล",
                                            style: TextStyle(
                                                fontSize: 14)),
                                      ]),
                                  Text(
                                      "${widget.dataLeave!.description == null || widget.dataLeave!.description == "" ? "-" : widget.dataLeave!.description}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff757575))),
                                  const SizedBox(height: 10),
                                  const Text("วันที่เริ่ม - วันที่สิ้นสุด",
                                      style: TextStyle(fontSize: 14)),
                                  Text(
                                      "${DateFormat('dd/MM/yyyy').format(widget.dataLeave!.start!)} "
                                          "- ${DateFormat('dd/MM/yyyy').format(widget.dataLeave!.end!)}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff757575))),
                                ]
                              ],
                            ),
                            const Divider(),
                            Column(
                              children: [
                                if (widget.dataLeave != null) ...[
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("อนุมัติโดย",
                                          style:
                                          TextStyle(fontSize: 14)),
                                      Text(
                                        widget.dataLeave!.approveDate == null
                                            ? "-"
                                            : "${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.dataLeave!.approveDate!))}"
                                            "\n${DateFormat('HH:mm').format(DateTime.parse(widget.dataLeave!.approveDate!))}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff757575)),
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          widget.dataLeave!.managerName == null
                                              ? "ไม่ระบุ"
                                              : "${widget.dataLeave!.managerName}",
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          )),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          widget.dataLeave!.managerEmail == null
                                              ? "ไม่ระบุ"
                                              : widget.dataLeave!.managerEmail!,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff757575)))
                                    ],
                                  ),
                                  if (widget.dataLeave!.isApprove == 0) ...[
                                    const Row(
                                      children: [
                                        Text("เหตุผลที่ไม่อนุมัติ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.red)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            widget.dataLeave!.commentManager == null ||
                                                widget.dataLeave!.commentManager ==
                                                    ""
                                                ? "-"
                                                : widget.dataLeave!.commentManager,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                  ]
                                ] else ...[
                                  if (widget.requestTime!.isDoubleApproval! == 0) ...[
                                    const Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("อนุมัติโดย",
                                            style: TextStyle(
                                                fontSize: 14)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            widget.requestTime!.managerLv1Name== null
                                                ? "ไม่ระบุ"
                                                : widget.requestTime!.managerLv1Name!,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            widget.requestTime!.emailManagerLv1 == null
                                                ? "ไม่ระบุ"
                                                : widget.requestTime!.emailManagerLv1!,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff757575)))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (widget.requestTime!.isManagerLv1Approve ==
                                        0) ...[
                                      const Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("เหตุผลที่ไม่อนุมัติ",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              widget.requestTime!.commentManagerLv1 ==
                                                  null ||
                                                  widget.requestTime!
                                                      .commentManagerLv1 ==
                                                      ""
                                                  ? "-"
                                                  : widget.requestTime!
                                                  .commentManagerLv1,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                  Color(0xff757575)))
                                        ],
                                      ),
                                    ] else ...[
                                      const Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("วันที่อนุมัติ",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              widget.requestTime!.managerLv1ApproveDate ==
                                                  null
                                                  ? "-"
                                                  : "${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.requestTime!.managerLv1ApproveDate))}"
                                                  "\n${DateFormat('HH:mm').format(DateTime.parse(widget.requestTime!.managerLv1ApproveDate))}",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                  Color(0xff757575)))
                                        ],
                                      ),
                                    ]
                                  ] else ...[
                                    if (widget.requestTime!.isManagerLv1Approve == 0 ||
                                        widget.requestTime!.isManagerLv2Approve ==
                                            0) ...[
                                      const Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("เหตุผลที่ไม่อนุมัติ",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("ManagerLV 1 :",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              widget.requestTime!.commentManagerLv1 ==
                                                  null ||
                                                  widget.requestTime!
                                                      .commentManagerLv1 ==
                                                      ""
                                                  ? "-"
                                                  : widget.requestTime!
                                                  .commentManagerLv1,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                  Color(0xff757575)))
                                        ],
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("ManagerLV 2 :",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              widget.requestTime!.commentManagerLv2 ==
                                                  null ||
                                                  widget.requestTime!
                                                      .commentManagerLv2 ==
                                                      ""
                                                  ? "-"
                                                  : widget.requestTime!
                                                  .commentManagerLv2,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                  Color(0xff757575)))
                                        ],
                                      ),
                                    ] else ...[
                                      const Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("อนุมัติโดย",
                                              style: TextStyle(
                                                  fontSize: 14)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Manager Lv 1",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                              )),
                                          Text(
                                            widget.requestTime!.managerLv1ApproveDate ==
                                                null
                                                ? "-"
                                                : "${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.requestTime!.managerLv1ApproveDate!))}"
                                                "\n${DateFormat('HH:mm').format(DateTime.parse(widget.requestTime!.managerLv1ApproveDate!))}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff757575)),
                                            textAlign: TextAlign.end,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              widget.requestTime!.managerLv1Name == null
                                                  ? "ไม่ระบุ"
                                                  : widget.requestTime!.managerLv1Name!,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              widget.requestTime!.emailManagerLv1 ==
                                                  null
                                                  ? "ไม่ระบุ"
                                                  : widget.requestTime!
                                                  .emailManagerLv1!,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                  Color(0xff757575)))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Manager Lv 2",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                              )),
                                          Text(
                                            widget.requestTime!.managerLv2ApproveDate ==
                                                null
                                                ? "-"
                                                : "${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.requestTime!.managerLv2ApproveDate!))}"
                                                "\n${DateFormat('HH:mm').format(DateTime.parse(widget.requestTime!.managerLv2ApproveDate!))}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff757575)),
                                            textAlign: TextAlign.end,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              widget.requestTime!.emailManagerLv2 == null
                                                  ? "ไม่ระบุ"
                                                  : widget.requestTime!.emailManagerLv2!,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              widget.requestTime!.emailManagerLv2 ==
                                                  null
                                                  ? "ไม่ระบุ"
                                                  : widget.requestTime!
                                                  .emailManagerLv2!,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                  Color(0xff757575)))
                                        ],
                                      ),
                                    ]
                                  ]
                                ]
                              ],
                            )
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
