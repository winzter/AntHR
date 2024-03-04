import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../leave/domain/entities/leave_auth_used_remaining.dart';
import '../../../leave/presentation/bloc/leave_bloc.dart';
import '../../../summary_shfit_ot/presentation/bloc/shift_ot_bloc.dart';


class ChartVacation extends StatefulWidget {
  final LeaveBloc bloc;

  const ChartVacation({super.key, required this.bloc});

  @override
  State<ChartVacation> createState() => _ChartVacationState();
}

class _ChartVacationState extends State<ChartVacation> {
  final List<Color> colors = [
    const Color(0xff27385E),
    const Color(0xff275F77),
    const Color(0xffD3A54C),
  ];

  @override
  void initState() {
    super.initState();
    // widget.bloc.add(GetAllLeaveData());
  }

  final List<double> stops = [0.2, 0.5, 0.8];

  Float64List _resolveTransform(Rect bounds, TextDirection textDirection) {
    final GradientTransform transform = GradientRotation(_degreeToRadian(-90));
    return transform.transform(bounds, textDirection: textDirection)!.storage;
  }

  // Convert degree to radian
  double _degreeToRadian(int deg) => deg * (3.141592653589793 / 180);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(
      builder: (context, state) {
        if (state is LeaveInitial) {
          return const SizedBox(
            width: 230, //230
            height: 210,
            child: Center(
              child: Text(
                "กำลังดึงข้อมูล...",
                style: TextStyle(),
              ),
            ),
          );
        } else if (state is LeaveLoading) {
          return const SizedBox(
            width: 230, //230
            height: 210,
            child: Center(
              child: Text(
                "กำลังโหลด...",
                style: TextStyle(),
              ),
            ),
          );
        }
        else if (state is LeaveLoaded && state.leaveData.isNotEmpty) {
          bool hasChart = false;
          LeaveAuthWithUsedRemaining? leaveAuthData;
          try {
            leaveAuthData = state.leaveData.firstWhere(
                  (element) => (element.name == "วันหยุดพักผ่อนประจำปี") || (element.name == 'ลาพักร้อน'),
            );
            hasChart = true;
          } catch (e) {
            leaveAuthData = null;
            hasChart = false;
          }
          double leaveValue = (leaveAuthData?.leaveAuth.leaveValue ?? 0).toDouble();
          double carryValue =( 0).toDouble();
          double usedValue =( leaveAuthData?.used?? 0).toDouble();
          return SizedBox(
            width: 230, //230
            height: 210, //210
            child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(
                    enable: true,),
                legend: const Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,),
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                      widget: const PhysicalModel(
                          shape: BoxShape.circle,
                          elevation: 10,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                          ))),
                  CircularChartAnnotation(
                      widget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${(carryValue + leaveValue - usedValue).toStringAsFixed(2)}/${leaveValue + carryValue}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Text("สิทธิการลาพักร้อน",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff757575)))
                        ],
                      ))
                ],
                onCreateShader: (ChartShaderDetails chartShaderDetails) {
                  return ui.Gradient.sweep(
                    chartShaderDetails.outerRect.center,
                    colors,
                    stops,
                    TileMode.clamp,
                    _degreeToRadian(0),
                    _degreeToRadian(360),
                    _resolveTransform(chartShaderDetails.outerRect, TextDirection.ltr),
                  );
                },
                series: <CircularSeries>[
                  RadialBarSeries<ChartData, String>(
                      maximumValue: (leaveValue +
                          carryValue),
                      trackBorderWidth: 30,
                      innerRadius: "69%",
                      dataSource: [
                        ChartData(
                            "จำนวนวันลาพักร้อน",
                            (carryValue +
                                leaveValue -  ( hasChart?usedValue:0 )))
                      ],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      cornerStyle: CornerStyle.bothCurve,
                      trackColor: Colors.white,
                      legendIconType: LegendIconType.circle,
                      radius: '142%')
                ]),
          );
        }
        else if (state is LeaveFailure) {
          return SizedBox(
            width: 230, //230
            height: 210, //210
            child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(
                    enable: true,),
                legend: const Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    textStyle: TextStyle()),
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                      widget: const PhysicalModel(
                          shape: BoxShape.circle,
                          elevation: 10,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                          ))),
                  CircularChartAnnotation(
                      widget: const Text(
                        'เกิดข้อผิดพลาด',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ))
                ],
                // onCreateShader: (ChartShaderDetails chartShaderDetails) {
                //   return ui.Gradient.sweep(
                //       chartShaderDetails.outerRect.center,
                //       colors,
                //       stops,
                //       TileMode.clamp,
                //       _degreeToRadian(0),
                //       _degreeToRadian(360),
                //       _resolveTransform(
                //           chartShaderDetails.outerRect, TextDirection.ltr));
                // },
                series: <CircularSeries>[
                  RadialBarSeries<ChartData, String>(
                      maximumValue: 0,
                      trackBorderWidth: 30,
                      innerRadius: "69%",
                      dataSource: [ChartData("เกิดข้อผิดพลาด", 0)],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      cornerStyle: CornerStyle.bothCurve,
                      trackColor: Colors.white,
                      legendIconType: LegendIconType.circle,
                      radius: '142%')
                ]),
          );
        }
        return const SizedBox(
            width: 230, //230
            height: 210,
            child: Center(
                child: Text(
                  "ไม่มีข้อมูล",
                  style: TextStyle(),
                )));
      },
    );
  }
}
/*-------------------------------------------------*/

/* Deduction Chart */
class ChartDeduction extends StatefulWidget {
  final ShiftOtBloc bloc;

  const ChartDeduction({super.key, required this.bloc});

  @override
  State<ChartDeduction> createState() => _ChartDeductionState();
}

class _ChartDeductionState extends State<ChartDeduction> {
  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftOtBloc, ShiftOtState>(
      builder: (context, state) {
        if (state is ShiftOtInitial) {
          return const SizedBox(
            width: 220, //230
            height: 200,
            child: Center(
              child: Text(
                "กำลังดึงข้อมูล...",
                style: TextStyle(),
              ),
            ),
          );
        } else if (state is ShiftOtLoading) {
          return const SizedBox(
            width: 220, //230
            height: 200,
            child: Center(
              child: Text(
                "กำลังโหลด...",
              ),
            ),
          );
        } else if (state is ShiftOtLoaded) {
          return SizedBox(
            width: 220,
            height: 200,
            child: SfCircularChart(
                legend: const Legend(
                    alignment: ChartAlignment.center,
                    isVisible: true,
                    isResponsive: true,
                    padding: 5,
                    itemPadding: 6,
                    position: LegendPosition.bottom,
                    textStyle: TextStyle()),
                tooltipBehavior: TooltipBehavior(
                    enable: true,),
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                      widget: const PhysicalModel(
                          shape: BoxShape.circle,
                          elevation: 10,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                          ))),
                  CircularChartAnnotation(
                      widget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${state.data.dock!.absent!.amount! + state.data.dock!.lateEarly!.amount!} บ.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            'รายการหักเงิน.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff757575)),
                          ),
                        ],
                      ))
                ],
                series: <CircularSeries>[
                  DoughnutSeries<ChartDataDeduction, String>(
                      innerRadius: "75%",
                      dataSource: [
                        ChartDataDeduction(
                            'มาสาย',
                            state.data.dock!.lateEarly!.amount!.toDouble(),
                            const Color(0xffE46A76)),
                        ChartDataDeduction(
                            'กลับก่อน',
                            state.data.dock!.lateEarly!.amount!.toDouble(),
                            const Color(0xff6A76E4)),
                        ChartDataDeduction(
                            'ขาด',
                            state.data.dock!.absent!.amount!.toDouble(),
                            const Color(0xffE49D6A))
                      ],
                      xValueMapper: (ChartDataDeduction data, _) => data.x,
                      yValueMapper: (ChartDataDeduction data, _) => data.y,
                      cornerStyle: CornerStyle.bothCurve,
                      pointColorMapper: (ChartDataDeduction data, _) =>
                      data.color,
                      legendIconType: LegendIconType.circle,
                      radius: '105%')
                ]),
          );
        }
        return const SizedBox(
            width: 220,
            height: 200,
            child: Center(
                child: Text(
                  "ไม่มีข้อมูล",
                )));
      },
    );
  }
}
/*-------------------------------------------------*/

/*-------------------------------------------------*/
class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

class ChartDataDeduction {
  ChartDataDeduction(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
