import 'package:flutter/material.dart';
import 'package:anthr/core/features/profile/manager/domain/entities/manager_profile_entity.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../bloc/waiting_status_bloc.dart';
import '../providers/radio_button_provider.dart';

class RadioButtonMenu extends StatefulWidget {
  final WaitingStatusBloc waitingStatusBloc;
  final ManagerProfileEntity managerData;
  const RadioButtonMenu({
    super.key,
    required this.waitingStatusBloc,
    required this.managerData,
  });

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
    setState(() {
      widget.waitingStatusBloc.add(GetWaitingStatus(
          start: null, end: null, managerData: widget.managerData));
      dateController.text = "";
    });
  }

  Future pickDateRange() async {
    final item =
        Provider.of<ManagerRadioButtonProvider>(context, listen: false);
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
      item.dataLength();
      widget.waitingStatusBloc.add(GetWaitingStatus(
          start: DateFormat("yyyy-MM-dd").format(newDateRange.start),
          end: DateFormat("yyyy-MM-dd").format(newDateRange.end),
          managerData: widget.managerData));
      setState(() {
        dateRange = newDateRange;
        dateController.text = "$startDateFormatted - $endDateFormatted";
        // item.getAllDataByDate(dateRange);
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        errorStyle: TextStyle()),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                  title: "ขอลา",
                  value: "ขอลา",
                ),
                RadioButton(
                  title: "ขอรับรองเวลา",
                  value: "ขอรับรองเวลาทำงาน",
                ),
                RadioButton(
                  title: "ขอทำงานเกินเวลา",
                  value: "ขอทำงานล่วงเวลา",
                ),
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
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<ManagerRadioButtonProvider>(context);
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
  }
}
