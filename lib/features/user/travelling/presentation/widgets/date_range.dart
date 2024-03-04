import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeButton extends StatefulWidget {
  const DateRangeButton({super.key});

  @override
  State<DateRangeButton> createState() => _DateRangeButtonState();
}

class _DateRangeButtonState extends State<DateRangeButton> {
  TextEditingController dateController = TextEditingController();

  Future pickDate() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 1),
        lastDate: DateTime(2030, 12));

    if (newDate == null) {
      return;
    } else {
      final startDateFormatted = DateFormat("dd/MM/yyyy").format(newDate);
      setState(() {
        dateController.text = "$startDateFormatted";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "วันที่ค้นหา",
            style:
            TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 40,
            width: 250,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: dateController,
              readOnly: true,
              onTap: pickDate,
              style: TextStyle(),
              decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  suffixIcon: const Icon(Icons.calendar_month),
                  hintText: "วัน/เดือน/ปี",
                  hintStyle: TextStyle(),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  errorStyle: TextStyle()),
            ),
          ),
        ],
      ),
    );
  }
}
