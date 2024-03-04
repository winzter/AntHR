import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:anthr/features/user/summary_shfit_ot/presentation/provider/shift_ot_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../components/widgets/loading.dart';
import 'card_day_data.dart';

class ShiftAndOTDetailCard extends StatefulWidget {
  const ShiftAndOTDetailCard({super.key});

  @override
  State<ShiftAndOTDetailCard> createState() => _ShiftAndOTDetailCardState();
}

class _ShiftAndOTDetailCardState extends State<ShiftAndOTDetailCard> {

  @override
  Widget build(BuildContext context) {
    final shiftOtProvider = Provider.of<GetShiftAndOTProvider>(context);
    return Column(
      children: [
        // if(shiftOtProvider.shiftOTData.isNotEmpty)...[
        //   ExpandablePageView.builder(
        //       physics: const BouncingScrollPhysics(),
        //       scrollDirection: Axis.horizontal,
        //       itemCount:  shiftOtProvider.shiftOTData.dataTable != null ?shiftOtProvider.shiftOTData[0].dataTable!.length:1,
        //       itemBuilder: (context, index) {
        //         return shiftOtProvider.shiftOTData.dataTable != null
        //             ?CardDayData(data:shiftOtProvider.shiftOTData,index: index,key: ValueKey(index),)
        //             :const Loading()
        //         ;
        //       })
        // ]
      ExpandablePageView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount:  shiftOtProvider.shiftOTData.dataTable != null ?shiftOtProvider.shiftOTData.dataTable!.length:1,
            itemBuilder: (context, index) {
              return shiftOtProvider.shiftOTData.dataTable != null
                  ?CardDayData(data:shiftOtProvider.shiftOTData,index: index,key: ValueKey(index),)
                  :const Loading(color: Colors.blueAccent,);
            })
      ],
    );
  }
}
