import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../../payslip/presentation/provider/payslip_provider.dart';
import '../../../summary_shfit_ot/presentation/bloc/shift_ot_bloc.dart';

class ThirdPageView extends StatefulWidget {
  const ThirdPageView({super.key});

  @override
  State<ThirdPageView> createState() => _ThirdPageViewState();
}

class _ThirdPageViewState extends State<ThirdPageView> {
  final ShiftOtBloc shiftOtBloc = sl<ShiftOtBloc>();
  final DateTime now = DateTime.now();


  @override
  void initState(){
    super.initState();
    if(DateTime.now().day >= 28){
      shiftOtBloc.add(getShiftOT(start: DateFormat('yyyy-MM-dd')
          .format(DateTime(now.year,now.month+1,28))));
    }else{
      shiftOtBloc.add(getShiftOT(start: DateFormat('yyyy-MM-dd')
          .format(DateTime(now.year,now.month,28))));
    }

  }

  @override
  Widget build(BuildContext context) {
    final GetPayslipProvider payslipProvider =
    Provider.of<GetPayslipProvider>(context, listen: false);
    return BlocProvider(
      create: (context) => shiftOtBloc,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).devicePixelRatio * 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  //"จ. 18 เมษ 66",
                  DateFormat('EE dd MMM yy').format(DateTime.now()),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400,color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<ShiftOtBloc, ShiftOtState>(
              builder: (context, state) {
                if(state is ShiftOtLoading){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ค่ากะและOT",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400,color: Colors.white)),
                          Row(
                            children: [
                              Text("กำลังโหลด...",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white)),
                            ],
                          )
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(now.day >= 28
                                ? DateFormat("ยอดประมาณการรายได้ MMM").format(DateTime(now.year,now.month+1,now.day))
                                : DateFormat("ยอดประมาณการรายได้ MMM").format(DateTime(now.year,now.month,now.day)),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400,color: Colors.white)),
                            const Row(
                              children: [
                                Text("กำลังโหลด...",
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white)),
                              ],
                            )
                          ])
                    ],
                  );
                }
                else if(state is ShiftOtLoaded){
                  return  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("ค่ากะและOT",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400,color: Colors.white)),
                          Row(
                            children: [
                              Text(NumberFormat("#,###.##").format(state.sumOfShiftAndOt),
                                  style: const TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.w500,color: Colors.white)),
                              const Text(" บาท",
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w400,color: Colors.white)),
                            ],
                          )
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(now.day >= 28
                                ? DateFormat("ยอดประมาณการรายได้ MMM").format(DateTime(now.year,now.month+1,now.day))
                                : DateFormat("ยอดประมาณการรายได้ MMM").format(DateTime(now.year,now.month,now.day)),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400,color: Colors.white),textAlign: TextAlign.center,),
                            Row(
                              children: [
                                const SizedBox(width: 5,),
                                Text(payslipProvider.previousPayslipData != null ?
                                    payslipProvider.previousPayslipData!.isEmpty
                                        ? "0"
                                        : NumberFormat("#,###.##").format(
                                        payslipProvider.previousPayslipData![0].addition![0].value!+state.sumOfShiftAndOt):"${state.sumOfShiftAndOt}",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,color: Colors.white)),
                                const Text(" บาท",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,color: Colors.white)),
                              ],
                            )
                          ])
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ค่ากะและOT",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400,color: Colors.white)),
                        Row(
                          children: [
                            Text("0",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w500,color: Colors.white)),
                            Text(" บาท",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400,color: Colors.white)),
                          ],
                        )
                      ],
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(now.day >= 28
                              ? DateFormat("ยอดประมาณการรายได้ MMM").format(DateTime(now.year,now.month+1,now.day))
                              : DateFormat("ยอดประมาณการรายได้ MMM").format(DateTime(now.year,now.month,now.day)),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400,color: Colors.white)),
                          const Row(
                            children: [
                              Text("0",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,color: Colors.white)),
                              Text(" บาท",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,color: Colors.white)),
                            ],
                          )
                        ])
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
