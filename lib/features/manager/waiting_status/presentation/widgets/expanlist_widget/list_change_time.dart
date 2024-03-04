// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:swipeable_tile/swipeable_tile.dart';
// import '../../../domain/entities/entities.dart';
// import '../../bloc/waiting_status_bloc.dart';
// import '../../providers/radio_button_provider.dart';
//
//
// class ListItemsChangeTime extends StatefulWidget {
//   final int index;
//   final bool? isSelectAll;
//   final ChangeTimeManager changeTimeData;
//   final List<PayrollSetting> payrollSettingData;
//   // final String type;
//   final WaitingStatusBloc bloc;
//
//   const ListItemsChangeTime({
//     super.key,
//     required this.index,
//     required this.changeTimeData,
//     // required this.type,
//     required this.payrollSettingData,
//     required this.bloc,
//     required this.isSelectAll,});
//
//   @override
//   State<ListItemsChangeTime> createState() => _ListItemsChangeTimeState();
// }
//
// class _ListItemsChangeTimeState extends State<ListItemsChangeTime> {
//   bool isSelected = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final item = Provider.of<ManagerRadioButtonProvider>(context);
//     item.selectedFlag.contains(widget.index)?isSelected = true:isSelected = false;
//     return Padding(
//         padding: const EdgeInsets.only(bottom: 8.0),
//         child: SwipeableTile.card(
//           horizontalPadding: 4,
//           verticalPadding: 0,
//           color: Colors.white,
//           shadow: BoxShadow(
//             color: Colors.black.withOpacity(0.35),
//             blurRadius: 4,
//             offset: const Offset(2, 2),
//           ),
//           swipeThreshold: 0.7,
//           direction: SwipeDirection.none,
//           onSwiped: (_) {},
//           backgroundBuilder: (context, direction, progress) {
//             return AnimatedBuilder(
//               animation: progress,
//               builder: (context, child) {
//                 return AnimatedContainer(
//                   duration: const Duration(milliseconds: 400),
//                   color: const Color(0xFFed7474),
//                 );
//               },
//             );
//           },
//           key: UniqueKey(),
//           child: Container(
//             decoration: BoxDecoration(
//                 color: isSelected?Color(0xffE8FFF8):Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     bottomLeft: Radius.circular(10))),
//             child: Column(
//               children: [
//                 ListTile(
//                   onTap: (){
//                     setState(() {
//                       isSelected = !isSelected;
//                       item.onTap(widget.index);
//                     });
//                   },
//                   title: Text(
//                     "${widget.changeTimeData.firstnameTh} ${widget.changeTimeData.lastnameTh}"
//                         ,
//                     style: GoogleFonts.kanit(
//                         fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   subtitle: Text("${widget.changeTimeData.positionName!}",style: GoogleFonts.kanit(color: Color(0xff757575),fontSize: 15),),
//                   trailing: Text(
//                     "${widget.changeTimeData.shiftGroupName}\n"
//                     ,style: GoogleFonts.kanit(fontSize: 15),
//                   ),
//                 ),
//                 ListTile(
//                   title: Divider(),
//                   onTap: (){
//                     setState(() {
//                       isSelected = !isSelected;
//                       item.onTap(widget.index);
//                     });
//                   },
//                   subtitle: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("เริ่ม ${widget.changeTimeData.workingDateText}",style: GoogleFonts.kanit(fontSize: 15),),
//                                       ],
//                 ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
