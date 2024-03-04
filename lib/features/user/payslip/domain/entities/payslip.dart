import 'package:equatable/equatable.dart';

class PayslipEntity extends Equatable {
  final String? employeeId;
  final String? title;
  final String? firstname;
  final String? lastname;
  final String? bookBankId;
  final int? idPositions;
  final String? positionsName;
  final dynamic idDepartment;
  final dynamic departmentName;
  final int? idPayrunDetail;
  final int? idPayrun;
  final int? idEmp;
  final int? workingDay;
  final double? totalOt;
  final double? totalAdditions;
  final double? totalEarnings;
  final double? totalDeductions;
  final double? net;
  final dynamic otRate;
  final String? paymentType;
  final DateTime? monthPeriod;
  final DateTime? payDate;
  final dynamic chargeSalary;
  final dynamic chargeOt;
  final dynamic chargeCost;
  final dynamic chargeCompensated;
  final int? isCheck;
  final int? idCompany;
  final int? idVendor;
  final double? ytdIrregular;
  final double? accumulateEarnings;
  final double? accumulateTax;
  final double? accumulateSso;
  final double? accumulatePf;
  final dynamic start;
  final dynamic end;
  final String? vendorName;
  final String? sectionName;
  final int? round;
  final String? companyName;
  final List<dynamic>? addition;
  final List<dynamic>? deduction;

  const PayslipEntity({
    this.employeeId,
    this.title,
    this.firstname,
    this.lastname,
    this.bookBankId,
    this.idPositions,
    this.positionsName,
    this.idDepartment,
    this.departmentName,
    this.idPayrunDetail,
    this.idPayrun,
    this.idEmp,
    this.workingDay,
    this.totalOt,
    this.totalAdditions,
    this.totalEarnings,
    this.totalDeductions,
    this.net,
    this.otRate,
    this.paymentType,
    this.monthPeriod,
    this.payDate,
    this.chargeSalary,
    this.chargeOt,
    this.chargeCost,
    this.chargeCompensated,
    this.isCheck,
    this.idCompany,
    this.idVendor,
    this.ytdIrregular,
    this.accumulateEarnings,
    this.accumulateTax,
    this.accumulateSso,
    this.accumulatePf,
    this.start,
    this.end,
    this.vendorName,
    this.sectionName,
    this.round,
    this.companyName,
    this.addition,
    this.deduction,
  });

  @override
  List<Object?> get props => [
        employeeId,
        title,
        firstname,
        lastname,
        bookBankId,
        idPositions,
        positionsName,
        idDepartment,
        departmentName,
        idPayrunDetail,
        idPayrun,
        idEmp,
        workingDay,
        totalOt,
        totalAdditions,
        totalEarnings,
        totalDeductions,
        net,
        otRate,
        paymentType,
        monthPeriod,
        payDate,
        chargeSalary,
        chargeOt,
        chargeCost,
        chargeCompensated,
        isCheck,
        idCompany,
        idVendor,
        ytdIrregular,
        accumulateEarnings,
        accumulateTax,
        accumulateSso,
        accumulatePf,
        start,
        end,
        vendorName,
        sectionName,
        round,
        companyName,
        addition,
        deduction,
      ];
}

class TionEntity extends Equatable {
  final int? idPayrunDetailMain;
  final int? idEmp;
  final int? idPayrun;
  final int? idPayrunDetail;
  final int? idPayrollType;
  final double? value;
  final double? valueHour;
  final int? valueActual;
  final DateTime? payround;
  final dynamic payrunDetailMaincol;
  final String? name;
  final int? isAddition;
  final int? showOnPayslip;
  final String? payroundText;
  final int? idPayrunDetailAddition;
  final int? idAddition;
  final int? idPayrunDetailDeduction;
  final int? idDeduction;

  const TionEntity({
    this.idPayrunDetailMain,
    this.idEmp,
    this.idPayrun,
    this.idPayrunDetail,
    this.idPayrollType,
    this.value,
    this.valueHour,
    this.valueActual,
    this.payround,
    this.payrunDetailMaincol,
    this.name,
    this.isAddition,
    this.showOnPayslip,
    this.payroundText,
    this.idPayrunDetailAddition,
    this.idAddition,
    this.idPayrunDetailDeduction,
    this.idDeduction,
  });

  @override
  List<Object?> get props => [
        idPayrunDetailMain,
        idEmp,
        idPayrun,
        idPayrunDetail,
        idPayrollType,
        value,
        valueHour,
        valueActual,
        payround,
        payrunDetailMaincol,
        name,
        isAddition,
        showOnPayslip,
        payroundText,
        idPayrunDetailAddition,
        idAddition,
        idPayrunDetailDeduction,
        idDeduction,
      ];
}
