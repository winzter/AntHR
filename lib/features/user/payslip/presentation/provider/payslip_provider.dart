import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/payslip.dart';
import '../../domain/usecases/get_payslip.dart';

class GetPayslipProvider extends ChangeNotifier {
  final GetPayslip getPayslip;
  final List<String> _years = List.generate(10, (index) => DateFormat("yyyy").format(DateTime(DateTime.now().year  + 543 - index)));

  // static final List<String> _months = List.generate(12, (index) {
  //   return DateFormat('MMMM').format(DateTime(DateTime.now().year, index, 1));
  // });

  final List<String> _months = [
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
  List<PayslipEntity> payslipData = [];
  List<PayslipEntity>? previousPayslipData;
  TionEntity _deductionSSO = const TionEntity();
  TionEntity _deductionPF = const TionEntity();
  int _currentPageIndex = int.parse(DateFormat('MM').format(DateTime.now()));
  String _month = DateFormat('MMMM').format(DateTime.now());
  String _year = DateFormat('yyyy').format(DateTime(DateTime.now().year + 543));

  GetPayslipProvider({required this.getPayslip});
  List<String> get months => _months;
  TionEntity get deductionSSO => _deductionSSO;
  TionEntity get deductionPF => _deductionPF;
  String get month => _month;
  List<String> get years => _years;
  String get year => _year;
  int get currentPageIndex => _currentPageIndex;

  void setMonth(String month) {
    _month = month;
    notifyListeners();
  }

  void setIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  void setYear(String year) {
    _year = year;
    notifyListeners();
  }

  Future<bool> getPayslipData() async {
    try {
      var data = await getPayslip(month: _month, year: _year);
      payslipData = data.foldRight(payslipData, (r, previous) => r);
      setDeductionValue();
      notifyListeners();
      return false;
    } catch (error) {
      log(error.toString());
      notifyListeners();
      return true;
    }
  }

  Future<bool> getPreviousPayslipData() async {
    try {
      previousPayslipData = null;
      var data = await getPayslip(month: _months[_months.indexOf(_month)-1], year: _year);
      previousPayslipData = data.foldRight(previousPayslipData, (r, previous) => r);
      notifyListeners();
      return false;
    } catch (error) {
      log(error.toString());
      notifyListeners();
      return true;
    }
  }

  void setDeductionValue() {
    if (payslipData.isNotEmpty) {
      for (var i = 0; i < payslipData[0].deduction!.length; i++) {
        if (payslipData[0].deduction![i].idPayrollType == 11) {
          _deductionSSO = payslipData[0].deduction![i];
        }
        if (payslipData[0].deduction![i].idPayrollType == 10) {
          _deductionPF = payslipData[0].deduction![i];
        }
      }
    }
  }

  static GetPayslipProvider of(BuildContext context, {listen = true}) =>
      Provider.of<GetPayslipProvider>(context, listen: listen);
}
