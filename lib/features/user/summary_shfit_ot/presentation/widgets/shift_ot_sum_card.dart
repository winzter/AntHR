import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:anthr/features/user/summary_shfit_ot/presentation/provider/shift_ot_provider.dart';
import 'package:anthr/features/user/summary_shfit_ot/presentation/widgets/card_data.dart';
import 'package:provider/provider.dart';

class ShiftAndOTSumCard extends StatefulWidget {
  const ShiftAndOTSumCard({super.key});

  @override
  State<ShiftAndOTSumCard> createState() => _ShiftAndOTSumCardState();
}

class _ShiftAndOTSumCardState extends State<ShiftAndOTSumCard> {
  late TabController tabController1;
  PageController pageController = PageController(initialPage: 0);
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final shiftOtProvider = Provider.of<GetShiftAndOTProvider>(context);
    return Column(
      children: [
        ExpandablePageView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: shiftOtProvider.months.length,
            onPageChanged: (int index){
              shiftOtProvider.setIndex(index);
              shiftOtProvider.setMonth(index);
              shiftOtProvider.getSummaryTime();
            },
            itemBuilder: (context, index) {
              return CardData(index: index, data: shiftOtProvider.shiftOTData);
            })
      ],
    );
  }
}
