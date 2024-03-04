import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:anthr/features/user/payslip/presentation/widgets/payslip_detail.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/payslip_provider.dart';
import 'expense_list.dart';

class CardList extends StatefulWidget {
  final int index;
  const CardList({super.key, required this.index});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    final data = context.watch<GetPayslipProvider>();
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
                height: 150,
                decoration: const BoxDecoration(),
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
                              value: data.month,
                              underline: Container(),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              items: data.months
                                  .map<DropdownMenuItem<String>>((value) {
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
                                data.setMonth(value!);
                                data.setIndex(data.month.indexOf(value));
                                data.getPayslipData();
                              }),
                        ),
                        data.payslipData.isNotEmpty
                            ? Text(
                                DateFormat("1 MMM - dd MMM yyyy")
                                    .format(DateTime(
                                        int.parse(data.year) - 543,
                                        data.months.indexOf(data.month) + 2,
                                        0)),
                                style: const TextStyle(
                                    color: Color(0xff94AFB6)),
                              )
                            : const Text(
                                "ไม่มีข้อมูล",
                                style: TextStyle(
                                    color: Color(0xff94AFB6)),
                              )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    PayslipDetail(
                      data: data.payslipData,
                      key: ValueKey(widget.index),
                    )
                  ],
                ),
              ),
              ExpansionTile(
                onExpansionChanged: (value) {},
                title: const Text(
                  'แสดงทั้งหมด',
                  style: TextStyle(color: Color(0xffC4C4C4)),
                  textAlign: TextAlign.center,
                ),
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide.none),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat("1 MMM - dd MMM yyyy")
                                  .format(DateTime(
                                      int.parse(data.year) - 543,
                                      data.months.indexOf(data.month) + 2,
                                      0)),
                              style: const TextStyle(
                                  color: Color(0xff94AFB6), fontSize: 15),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: const Color(0xff41BE06),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                data.payslipData.isNotEmpty
                                    ? "+฿${NumberFormat("#,###.##").format(data.payslipData[0].totalEarnings! - data.payslipData[0].totalDeductions!)}"
                                    : "฿ 0",
                                style: const TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        data.payslipData.isNotEmpty
                            ? ExpenseList(data: data.payslipData[0])
                            : const Text(
                                "ไม่มีข้อมูล",
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
