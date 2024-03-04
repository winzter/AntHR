import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:anthr/features/user/summary_shfit_ot/domain/entities/shift_ot_entity.dart';
import 'package:anthr/features/user/summary_shfit_ot/presentation/provider/shift_ot_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'card_day_detail.dart';

class CardData extends StatefulWidget {
  final int index;
  final ShiftAndOtEntity data;
  const CardData({super.key, required this.index, required this.data});

  @override
  State<CardData> createState() => _CardDataState();
}

class _CardDataState extends State<CardData> {
  @override
  Widget build(BuildContext context) {
    final shiftOtProvider = Provider.of<GetShiftAndOTProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: const Color(0xff15264F),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                height: 200,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: DropdownButton2(
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              value: shiftOtProvider.monthValue,
                              underline: Container(),
                              items:
                              shiftOtProvider.months.map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Color(0xff277B89),
                                          fontWeight: FontWeight.w500),
                                    ));
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  shiftOtProvider.monthValue = value!;
                                  shiftOtProvider.setIndex(shiftOtProvider.months.indexOf(value));
                                });
                                shiftOtProvider.getSummaryTime();
                              }),
                        ),
                        Text(
                          "รอบจ่ายเงินเดือน:\n${ DateFormat("1 MMM - dd MMM yyyy").format(DateTime(int.parse(shiftOtProvider.value)-543, shiftOtProvider.months.indexOf(shiftOtProvider.monthValue) + 2, 0))}",
                          textAlign: TextAlign.end,
                          style: const TextStyle(color: Color(0xff94AFB6)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                   // widget.data.isEmpty?
                   //  const Text("ไม่พบข้อมุล",style: TextStyle(color: Colors.white),):
                    CardDayDetail(
                      sumOT: shiftOtProvider.sumOTOfMonth(),
                      sumShiftMorning: shiftOtProvider.sumShiftMorning(),
                      sumShiftNoon: shiftOtProvider.sumShiftNoon(),
                      sumShiftNight: shiftOtProvider.sumShiftNight(),
                      sumLoss: shiftOtProvider.sumLoss(),
                      key: ValueKey(widget.index),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  }
