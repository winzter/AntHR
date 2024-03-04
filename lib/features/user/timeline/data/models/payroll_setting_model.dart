import 'dart:convert';

import 'package:anthr/features/user/timeline/domain/entities/entities.dart';

List<PayrollSettingTimeLineModel> payrollSettingTimeLineModelFromJson(String str) => List<PayrollSettingTimeLineModel>.from(json.decode(str).map((x) => PayrollSettingTimeLineModel.fromJson(x)));

// String payrollSettingTimeLineModelToJson(List<PayrollSettingTimeLineModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PayrollSettingTimeLineModel extends PayrollSettingTimeLine{
  const PayrollSettingTimeLineModel({
    required super.idPayrollSetting,
    required super.idVendor,
    required super.idCompany,
    required super.xWorkingDailyHoliday,
    required super.xWorkingMonthlyHoliday,
    required super.xOt,
    required super.xOtHoliday,
    required super.morningShiftFee,
    required super.afternoonShiftFee,
    required super.nightShiftFee,
    required super.delayTimes,
    required super.decimalRounding,
    required super.decimalNumber,
    required super.paymentPeriod,
    required super.paymentPeriodFirst,
    required super.paymentPeriodSecond,
    required super.firstCutOff,
    required super.secondCutOff,
    required super.firstPayDate,
    required super.secondPayDate,
    required super.earlyCheckIn,
    required super.firstPayslipDate,
    required super.firstPayslipTime,
    required super.secondPayslipDate,
    required super.secondPayslipTime,
    required super.firstAddition,
    required super.secondAddition,
    required super.firstDeduction,
    required super.secondDeduction,
    required super.xWorkingDailyHolidayBilling,
    required super.xWorkingMonthlyHolidayBilling,
    required super.xOtBilling,
    required super.xOtHolidayBilling,
    required super.payment,
  });

  factory PayrollSettingTimeLineModel.fromJson(Map<String, dynamic> json) => PayrollSettingTimeLineModel(
    idPayrollSetting: json["idPayrollSetting"],
    idVendor: json["idVendor"],
    idCompany: json["idCompany"],
    xWorkingDailyHoliday: json["xWorkingDailyHoliday"]?.toDouble(),
    xWorkingMonthlyHoliday: json["xWorkingMonthlyHoliday"]?.toDouble(),
    xOt: json["xOT"]?.toDouble(),
    xOtHoliday: json["xOTHoliday"],
    morningShiftFee: json["morningShiftFee"],
    afternoonShiftFee: json["afternoonShiftFee"],
    nightShiftFee: json["nightShiftFee"],
    delayTimes: json["delayTimes"],
    decimalRounding: json["decimalRounding"],
    decimalNumber: json["decimalNumber"],
    paymentPeriod: json["paymentPeriod"],
    paymentPeriodFirst: json["paymentPeriodFirst"],
    paymentPeriodSecond: json["paymentPeriodSecond"],
    firstCutOff: json["firstCutOff"],
    secondCutOff: json["secondCutOff"],
    firstPayDate: json["firstPayDate"],
    secondPayDate: json["secondPayDate"],
    earlyCheckIn: json["earlyCheckIn"],
    firstPayslipDate: json["firstPayslipDate"],
    firstPayslipTime: json["firstPayslipTime"],
    secondPayslipDate: json["secondPayslipDate"],
    secondPayslipTime: json["secondPayslipTime"],
    firstAddition: json["firstAddition"],
    secondAddition: json["secondAddition"],
    firstDeduction: json["firstDeduction"],
    secondDeduction: json["secondDeduction"],
    xWorkingDailyHolidayBilling: json["xWorkingDailyHolidayBilling"],
    xWorkingMonthlyHolidayBilling: json["xWorkingMonthlyHolidayBilling"],
    xOtBilling: json["xOTBilling"],
    xOtHolidayBilling: json["xOTHolidayBilling"],
    payment: json["payment"] == null ? [] : List<PaymentModel>.from(json["payment"]!.map((x) => PaymentModel.fromJson(x))),
  );

  // Map<String, dynamic> toJson() => {
  //   "idPayrollSetting": idPayrollSetting,
  //   "idVendor": idVendor,
  //   "idCompany": idCompany,
  //   "xWorkingDailyHoliday": xWorkingDailyHoliday,
  //   "xWorkingMonthlyHoliday": xWorkingMonthlyHoliday,
  //   "xOT": xOt,
  //   "xOTHoliday": xOtHoliday,
  //   "morningShiftFee": morningShiftFee,
  //   "afternoonShiftFee": afternoonShiftFee,
  //   "nightShiftFee": nightShiftFee,
  //   "delayTimes": delayTimes,
  //   "decimalRounding": decimalRounding,
  //   "decimalNumber": decimalNumber,
  //   "paymentPeriod": paymentPeriod,
  //   "paymentPeriodFirst": paymentPeriodFirst,
  //   "paymentPeriodSecond": paymentPeriodSecond,
  //   "firstCutOff": firstCutOff,
  //   "secondCutOff": secondCutOff,
  //   "firstPayDate": firstPayDate,
  //   "secondPayDate": secondPayDate,
  //   "earlyCheckIn": earlyCheckIn,
  //   "firstPayslipDate": firstPayslipDate,
  //   "firstPayslipTime": firstPayslipTime,
  //   "secondPayslipDate": secondPayslipDate,
  //   "secondPayslipTime": secondPayslipTime,
  //   "firstAddition": firstAddition,
  //   "secondAddition": secondAddition,
  //   "firstDeduction": firstDeduction,
  //   "secondDeduction": secondDeduction,
  //   "xWorkingDailyHolidayBilling": xWorkingDailyHolidayBilling,
  //   "xWorkingMonthlyHolidayBilling": xWorkingMonthlyHolidayBilling,
  //   "xOTBilling": xOtBilling,
  //   "xOTHolidayBilling": xOtHolidayBilling,
  //   "payment": payment == null ? [] : List<dynamic>.from(payment!.map((x) => x.toJson())),
  // };
}

class PaymentModel extends Payment{

  const PaymentModel({
    required super.idPayrollPayment,
    required super.idPayrollSetting,
    required super.idPaymentType,
    required super.working,
    required super.ot,
    required super.isWorkingOmit,
    required super.isOtOmit,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    idPayrollPayment: json["idPayrollPayment"],
    idPayrollSetting: json["idPayrollSetting"],
    idPaymentType: json["idPaymentType"],
    working: json["working"],
    ot: json["ot"],
    isWorkingOmit: json["isWorkingOmit"],
    isOtOmit: json["isOtOmit"],
  );

  Map<String, dynamic> toJson() => {
    "idPayrollPayment": idPayrollPayment,
    "idPayrollSetting": idPayrollSetting,
    "idPaymentType": idPaymentType,
    "working": working,
    "ot": ot,
    "isWorkingOmit": isWorkingOmit,
    "isOtOmit": isOtOmit,
  };
}
