import 'package:equatable/equatable.dart';

class PayrollSettingEntity extends Equatable {
  final int? idPayrollSetting;
  final int? idVendor;
  final int? idCompany;
  final double? xWorkingDailyHoliday;
  final double? xWorkingMonthlyHoliday;
  final double? xOt;
  final int? xOtHoliday;
  final int? morningShiftFee;
  final int? afternoonShiftFee;
  final int? nightShiftFee;
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
  final List<dynamic>? payment;

  const PayrollSettingEntity({
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
    this.payment,
  });

  @override
  List<Object?> get props => [];
}

class PaymentEntity extends Equatable {
  final int? idPayrollPayment;
  final int? idPayrollSetting;
  final int? idPaymentType;
  final String? working;
  final String? ot;
  final int? isWorkingOmit;
  final int? isOtOmit;

  const PaymentEntity({
    this.idPayrollPayment,
    this.idPayrollSetting,
    this.idPaymentType,
    this.working,
    this.ot,
    this.isWorkingOmit,
    this.isOtOmit,
  });

  @override
  List<Object?> get props => [];
}
