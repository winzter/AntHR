import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/shift_ot_provider.dart';
import '../widgets/widgets.dart';

class SummaryShiftAndOTPage extends StatefulWidget {
  const SummaryShiftAndOTPage({super.key});
  @override
  State<SummaryShiftAndOTPage> createState() => _SummaryShiftAndOTPageState();
}

class _SummaryShiftAndOTPageState extends State<SummaryShiftAndOTPage> with SingleTickerProviderStateMixin{
  late GetShiftAndOTProvider shiftAndOtProvider;
  late TabController tabController1;

  @override
  void initState() {
    super.initState();
    shiftAndOtProvider = GetShiftAndOTProvider.of(context, listen: false);
    tabController1 = TabController(length: 12, vsync: this);
    shiftAndOtProvider.monthValue = shiftAndOtProvider.months[shiftAndOtProvider.months.indexOf(DateFormat('MMMM').format(DateTime.now()))];
    shiftAndOtProvider.yearNum = int.parse(shiftAndOtProvider.value);
    shiftAndOtProvider.getSummaryTime();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff27385E),
                Color(0xff277B89),
                Color(0xffFFCA11),
              ],
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "สรุปค่ากะและOT",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xffC4C4C4),
            )),
      ),
      body:  const SingleChildScrollView(
        physics:  BouncingScrollPhysics(),
        child: Column(
          children: [
            DropdownYear(),
            ShiftAndOTSumCard(),
            GifPics(),
            ShiftAndOTDetailCard()
          ],
        ),
      ),
    );
  }
}
