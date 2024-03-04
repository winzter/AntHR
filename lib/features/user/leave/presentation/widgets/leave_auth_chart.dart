import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../domain/entities/entities.dart';

class LeaveChart extends StatelessWidget {
  final List<LeaveAuthorityEntity> leaveData;
  final double used;
  const LeaveChart({super.key,
    required this.leaveData,
    required this.used});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 120,
      child: SfCircularChart(
        margin: const EdgeInsets.all(0),
        tooltipBehavior:
        TooltipBehavior(enable: true),
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
              widget: const PhysicalModel(
                  shape: BoxShape.circle,
                  elevation: 0,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                  ))),
          CircularChartAnnotation(
              widget: Text(
                '${double.parse(used.toStringAsFixed(2))}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ))
        ],
        series: <CircularSeries>[
          RadialBarSeries<LeaveAuthorityEntity, String>(
            enableTooltip: true,
            trackColor: const Color(0xffEAEDF2),
            maximumValue: leaveData[0].leaveValue == null
                ? double.parse(used.toStringAsFixed(2))
                : leaveData[0].leaveValue!.toDouble(),
            dataSource: leaveData,
            xValueMapper: (LeaveAuthorityEntity data, _) => data.name,
            yValueMapper: (LeaveAuthorityEntity data, _) => double.parse(used.toStringAsFixed(2)),
            // pointColorMapper: (Color data, _) => data.color,
            cornerStyle: CornerStyle.bothCurve,
            innerRadius: "70%",
            radius: "100%",
          ),
        ],
      ),
    );
  }
}