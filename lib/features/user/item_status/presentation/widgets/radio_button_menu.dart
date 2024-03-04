import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../home/presentation/provider/leave_provider.dart';
import '../bloc/item_status_bloc.dart';
import '../provider/item_status_provider.dart';

class RadioButtonMenu extends StatefulWidget {
  final ItemStatusBloc itemStatusBloc;
  const RadioButtonMenu({super.key, required this.itemStatusBloc});

  @override
  State<RadioButtonMenu> createState() => _RadioButtonMenuState();
}

class _RadioButtonMenuState extends State<RadioButtonMenu> {
  TextEditingController dateController = TextEditingController();
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month, 1),
      end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0));

  @override
  void initState() {
    super.initState();
    final item = Provider.of<WaitingProvider>(context, listen: false);
    setState(() {
      dateController.text =
          "${DateFormat("dd/MM/yyyy").format(dateRange.start)} - ${DateFormat("dd/MM/yyyy").format(dateRange.end)}";
      widget.itemStatusBloc.add(GetItemStatusData(
          startDate: DateFormat("yyyy-MM-dd").format(dateRange.start),
          endDate: DateFormat("yyyy-MM-dd").format(dateRange.end)));
      item.getAllDataByDate(dateRange);
    });
  }

  Future pickDateRange() async {
    final item = Provider.of<WaitingProvider>(context, listen: false);
    DateTimeRange? newDateRange = await showDateRangePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2200),
        initialDateRange: dateRange);

    if (newDateRange == null) {
      return;
    } else {
      final startDateFormatted =
          DateFormat("dd/MM/yyyy").format(newDateRange.start);
      final endDateFormatted =
          DateFormat("dd/MM/yyyy").format(newDateRange.end);
      widget.itemStatusBloc.add(GetItemStatusData(
          startDate: DateFormat("yyyy-MM-dd").format(newDateRange.start),
          endDate: DateFormat("yyyy-MM-dd").format(newDateRange.end)));
      setState(() {
        dateRange = newDateRange;
        dateController.text = "$startDateFormatted - $endDateFormatted";
        item.getAllDataByDate(dateRange);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "วันที่",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 30,
                  width: 250,
                  child: TextFormField(
                    onTap: pickDateRange,
                    controller: dateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      suffixIcon: Icon(Icons.calendar_month),
                      hintText: "วัน/เดือน/ปี",
                      hintStyle: TextStyle(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const Row(
              children: [
                Text(
                  "ประเภทรายการ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RadioButton(
                  title: "ทั้งหมด",
                  value: "all",
                ),
                RadioButton(
                  title: "ขอลา",
                  value: "ขอลา",
                ),
                RadioButton(
                  title: "ขอรับรอง\nเวลา",
                  value: "ขอรับรองเวลาทำงาน",
                ),
                RadioButton(
                  title: "ขอทำงาน\nเกินเวลา",
                  value: "ขอทำงานล่วงเวลา",
                ),
                // RadioButton(title: "ขอเปลี่ยนกะ", value: "ขอเปลี่ยนกะ",),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
  }
}

class RadioButton extends StatelessWidget {
  final String title;
  final String value;

  const RadioButton({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<RadioButtonProvider>(context);
    return BlocBuilder<ItemStatusBloc, ItemStatusState>(
      builder: (context, state) {
        return Column(
          children: [
            Transform.scale(
              scale: 1.3,
              child: Radio(
                activeColor: const Color(0xff277B89),
                value: value,
                groupValue: radioProvider.type,
                onChanged: (String? value) {
                  if (value != null) {
                    radioProvider.setType(value);
                  }
                },
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
