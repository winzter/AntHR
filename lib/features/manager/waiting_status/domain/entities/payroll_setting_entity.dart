import 'package:equatable/equatable.dart';

class PayrollSetting extends Equatable{
  final int? idPayrollSetting;
  final int? idVendor;
  final dynamic idCompany;
  final double? xWorkingDailyHoliday;
  final double? xWorkingMonthlyHoliday;
  final double? xOt;
  final double? xOtHoliday;
  final dynamic morningShiftFee;
  final dynamic afternoonShiftFee;
  final dynamic nightShiftFee;
  final int? delayTimes;
  final String? decimalRounding;
  final int? decimalNumber;
  final String? paymentPeriod;
  final int? firstCutOff;
  final int? secondCutOff;
  final int? firstPayDate;
  final int? secondPayDate;
  final int? earlyCheckIn;
  final int? firstPayslipDate;
  final String? firstPayslipTime;
  final int? secondPayslipDate;
  final String? secondPayslipTime;
  final int? firstAddition;
  final int? secondAddition;
  final int? firstDeduction;
  final int? secondDeduction;
  final dynamic xWorkingDailyHolidayBilling;
  final dynamic xWorkingMonthlyHolidayBilling;
  final dynamic xOtBilling;
  final dynamic xOtHolidayBilling;
  final List<Payment>? payment;

  const PayrollSetting({
    this.idPayrollSetting,
    this.idVendor,
    this.idCompany,
    this.xWorkingDailyHoliday,
    this.xWorkingMonthlyHoliday,
    this.xOt,
    this.xOtHoliday,
    this.morningShiftFee,
    this.afternoonShiftFee,
    this.nightShiftFee,
    this.delayTimes,
    this.decimalRounding,
    this.decimalNumber,
    this.paymentPeriod,
    this.firstCutOff,
    this.secondCutOff,
    this.firstPayDate,
    this.secondPayDate,
    this.earlyCheckIn,
    this.firstPayslipDate,
    this.firstPayslipTime,
    this.secondPayslipDate,
    this.secondPayslipTime,
    this.firstAddition,
    this.secondAddition,
    this.firstDeduction,
    this.secondDeduction,
    this.xWorkingDailyHolidayBilling,
    this.xWorkingMonthlyHolidayBilling,
    this.xOtBilling,
    this.xOtHolidayBilling,
    this.payment,
  });

  @override
  List<Object?> get props => [
    idPayrollSetting,
    idVendor,
    idCompany,
    xWorkingDailyHoliday,
    xWorkingMonthlyHoliday,
    xOt,
    xOtHoliday,
    morningShiftFee,
    afternoonShiftFee,
    nightShiftFee,
    delayTimes,
    decimalRounding,
    decimalNumber,
    paymentPeriod,
    firstCutOff,
    secondCutOff,
    firstPayDate,
    secondPayDate,
    earlyCheckIn,
    firstPayslipDate,
    firstPayslipTime,
    secondPayslipDate,
    secondPayslipTime,
    firstAddition,
    secondAddition,
    firstDeduction,
    secondDeduction,
    xWorkingDailyHolidayBilling,
    xWorkingMonthlyHolidayBilling,
    xOtBilling,
    xOtHolidayBilling,
    payment,
  ];


}

class Payment extends Equatable{
  final int? idPayrollPayment;
  final int? idPayrollSetting;
  final int? idPaymentType;
  final String? working;
  final String? ot;
  final int? isWorkingOmit;
  final int? isOtOmit;

  const Payment({
    this.idPayrollPayment,
    this.idPayrollSetting,
    this.idPaymentType,
    this.working,
    this.ot,
    this.isWorkingOmit,
    this.isOtOmit,
  });

  @override
  List<Object?> get props => [
    idPayrollPayment,
    idPayrollSetting,
    idPaymentType,
    working,
    ot,
    isWorkingOmit,
    isOtOmit,
  ];

}