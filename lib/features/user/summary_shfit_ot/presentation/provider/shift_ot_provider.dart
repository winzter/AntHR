import 'package:flutter/material.dart';
import 'package:anthr/features/user/summary_shfit_ot/domain/entities/shift_ot_entity.dart';
import 'package:anthr/features/user/summary_shfit_ot/domain/use_cases/getSummaryShiftAndOt.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class GetShiftAndOTProvider extends ChangeNotifier {
  final GetSummaryShiftAndOt getSummaryShiftAndOt;
  final List<String> _years = List.generate(10, (index) => DateFormat("yyyy").format(DateTime(DateTime.now().year  + 543 - index)));
  static final List<String> _months = [
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม',
  ];
  ShiftAndOtEntity shiftOTData = const ShiftAndOtEntity();

  int _currentPageIndex = _months.indexOf(DateFormat('MMMM').format(DateTime.now()));
  String _month = DateFormat('MMMM').format(DateTime.now());
  String _year = DateFormat('yyyy').format(DateTime(DateTime.now().year + 543));
  late String monthValue = months[currentPageIndex];
  String value = "2566";
  late int yearNum;

  GetShiftAndOTProvider({required this.getSummaryShiftAndOt});
  List<String> get months => _months;
  String get month => _month;
  List<String> get years => _years;
  String get year => _year;
  int get currentPageIndex => _currentPageIndex;

  void setMonth(int index) {
    monthValue = months[index];
    notifyListeners();
  }

  void setIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  void setYear(String year) {
    _year = year;
    value = year;
    notifyListeners();
  }

  double sumOTOfMonth(){
    double sumMonthOT = 0;
    if(shiftOTData.dataTable != null){

      for(var data in shiftOTData.dataTable!){
        if(data.otThreeAmount == null || data.otTwoAmount == null || data.otOneAmount == null){
          return 0;
        }
        sumMonthOT+= data.otThreeAmount! + data.otTwoAmount! + data.otOneFiveAmount! + data.otOneAmount!;
      }
    }

    return sumMonthOT;
  }

  double sumShiftMorning(){
    double sumShiftMorning = 0;
    if(shiftOTData.dataTable != null){
      for(var data in shiftOTData.dataTable!){
        if(data.shiftMorning == null){
          return 0;
        }
        sumShiftMorning+= data.shiftMorning!;
      }
    }

    return sumShiftMorning;
  }

  double sumShiftNoon(){
    double sumShiftNoon = 0;
    if(shiftOTData.dataTable != null){
      for(var data in shiftOTData.dataTable!){
        if(data.shiftNoon == null){
          return 0;
        }
        sumShiftNoon+= data.shiftNoon!;
      }
    }

    return sumShiftNoon;
  }

  double sumShiftNight(){
    double sumShiftNight = 0;
    if(shiftOTData.dataTable != null){
      for(var data in shiftOTData.dataTable!){
        if(data.shiftNight == null){
          return 0;
        }
        sumShiftNight+= data.shiftNight!;
      }
    }

    return sumShiftNight;
  }

  double sumLoss(){
    double sumLoss = 0;
    sumLoss = ((shiftOTData.dock?.lateEarly!.amount??0) + (shiftOTData.dock?.absent!.amount??0)).toDouble();
    return sumLoss;
  }

  Future<void> getSummaryTime() async {
    try {
      var data = await getSummaryShiftAndOt(
          DateFormat('yyyy-MM-dd').format(DateTime(int.parse(value)-543, months.indexOf(months[currentPageIndex])+1, DateTime.now().day)));
      shiftOTData = data.foldRight(shiftOTData, (r, previous) => r);
      notifyListeners();
    } catch (error) {
      Logger().e(error.toString());
      notifyListeners();
    }
  }



  static GetShiftAndOTProvider of(BuildContext context, {listen = true}) =>
      Provider.of<GetShiftAndOTProvider>(context, listen: listen);
}
