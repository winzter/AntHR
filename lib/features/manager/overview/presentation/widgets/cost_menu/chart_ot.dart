import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../domain/entities/cost_entity.dart';

class ChartOt extends StatelessWidget {
  final CostEntity? costData;
  final DateTime? date;

  const ChartOt({super.key, required this.costData, this.date});

  @override
  Widget build(BuildContext context) {
    List<OtData> chartData = [];
    if(costData != null){
      for(var i in costData!.otTotalAllYear!){
        chartData.add(OtData(DateTime(i.year!,i.month!), i.payTotal!)) ;
      }
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Center(
          child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0.40),
                    Color.fromRGBO(255, 255, 255, 0.40),
                  ],
                  stops: [0.0, 1.0],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.13),
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: SfCartesianChart(
                  enableAxisAnimation: true,
                  tooltipBehavior: TooltipBehavior(enable: true,header: "รายจ่ายค่าล่วงเวลา"),
                  title: ChartTitle(text:"รายจ่ายค่าล่วงเวลา (รายปี ${date?.year??'-'})",textStyle: TextStyle(color: Colors.white) ),
                  primaryXAxis: DateTimeAxis(labelStyle: TextStyle(color: Colors.white,),dateFormat: DateFormat("MMM")),
                  primaryYAxis: NumericAxis(labelStyle: TextStyle(color: Colors.white,),),
                  series: <CartesianSeries>[
                    LineSeries<OtData, DateTime>(
                        color: Color(0xffEEAC19),
                        markerSettings: MarkerSettings(shape: DataMarkerType.circle,isVisible: true),
                        enableTooltip: true,
                        dataSource: chartData,
                        xValueMapper: (OtData sales, _) => sales.date,
                        yValueMapper: (OtData sales, _) => sales.sales
                    )
                  ]
              )
          )
      ),
    );
  }
}

class OtData {
  OtData(this.date, this.sales);
  final DateTime date;
  final double sales;
}
