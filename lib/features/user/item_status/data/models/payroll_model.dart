import 'dart:convert';
import '../../domain/entities/entities.dart';

List<PayrollSettingModel> payrollSettingFromJson(String str) =>
    List<PayrollSettingModel>.from(
        json.decode(str).map((x) => PayrollSettingModel.fromJson(x)));

String payrollSettingToJson(List<PayrollSettingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PayrollSettingModel extends PayrollSettingEntity {
  const PayrollSettingModel({
    required int? idPayrollSetting,
    required int? idVendor,
    required int? idCompany,
    required double? xWorkingDailyHoliday,
    required double? xWorkingMonthlyHoliday,
    required double? xOt,
    required int? xOtHoliday,
    required int? morningShiftFee,
    required int? afternoonShiftFee,
    required int? nightShiftFee,
    required int? delayTimes,
    required String? decimalRounding,
    required int? decimalNumber,
    required String? paymentPeriod,
    required int? firstCutOff,
    required int? secondCutOff,
    required int? firstPayDate,
    required int? secondPayDate,
    required int? earlyCheckIn,
    required int? firstPayslipDate,
    required String? firstPayslipTime,
    required int? secondPayslipDate,
    required String? secondPayslipTime,
    required int? firstAddition,
    required int? secondAddition,
    required int? firstDeduction,
    required int? secondDeduction,
    required List<PaymentModel>? payment,
  }) : super(
          idPayrollSetting: idPayrollSetting,
          idVendor: idVendor,
          idCompany: idCompany,
          xWorkingDailyHoliday: xWorkingDailyHoliday,
          xWorkingMonthlyHoliday: xWorkingMonthlyHoliday,
          xOt: xOt,
          xOtHoliday: xOtHoliday,
          morningShiftFee: morningShiftFee,
          afternoonShiftFee: afternoonShiftFee,
          nightShiftFee: nightShiftFee,
          delayTimes: delayTimes,
          decimalRounding: decimalRounding,
          decimalNumber: decimalNumber,
          paymentPeriod: paymentPeriod,
          firstCutOff: firstCutOff,
          secondCutOff: secondCutOff,
          firstPayDate: firstPayDate,
          secondPayDate: secondPayDate,
          earlyCheckIn: earlyCheckIn,
          firstPayslipDate: firstPayslipDate,
          firstPayslipTime: firstPayslipTime,
          secondPayslipDate: secondPayslipDate,
          secondPayslipTime: secondPayslipTime,
          firstAddition: firstAddition,
          secondAddition: secondAddition,
          firstDeduction: firstDeduction,
          secondDeduction: secondDeduction,
          payment: payment,
        );

  factory PayrollSettingModel.fromJson(Map<String, dynamic> json) =>
      PayrollSettingModel(
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
        payment: json["payment"] == null
            ? []
            : List<PaymentModel>.from(
                json["payment"]!.map((x) => PaymentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idPayrollSetting": idPayrollSetting,
        "idVendor": idVendor,
        "idCompany": idCompany,
        "xWorkingDailyHoliday": xWorkingDailyHoliday,
        "xWorkingMonthlyHoliday": xWorkingMonthlyHoliday,
        "xOT": xOt,
        "xOTHoliday": xOtHoliday,
        "morningShiftFee": morningShiftFee,
        "afternoonShiftFee": afternoonShiftFee,
        "nightShiftFee": nightShiftFee,
        "delayTimes": delayTimes,
        "decimalRounding": decimalRounding,
        "decimalNumber": decimalNumber,
        "paymentPeriod": paymentPeriod,
        "firstCutOff": firstCutOff,
        "secondCutOff": secondCutOff,
        "firstPayDate": firstPayDate,
        "secondPayDate": secondPayDate,
        "earlyCheckIn": earlyCheckIn,
        "firstPayslipDate": firstPayslipDate,
        "firstPayslipTime": firstPayslipTime,
        "secondPayslipDate": secondPayslipDate,
        "secondPayslipTime": secondPayslipTime,
        "firstAddition": firstAddition,
        "secondAddition": secondAddition,
        "firstDeduction": firstDeduction,
        "secondDeduction": secondDeduction,
        "payment": payment == null
            ? []
            : List<dynamic>.from(payment!.map((x) => x.toJson())),
      };
}

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required int? idPayrollPayment,
    required int? idPayrollSetting,
    required int? idPaymentType,
    required String? working,
    required String? ot,
    required int? isWorkingOmit,
    required int? isOtOmit,
  }) : super(
          idPaymentType: idPaymentType,
          idPayrollPayment: idPayrollPayment,
          idPayrollSetting: idPayrollSetting,
          working: working,
          ot: ot,
          isWorkingOmit: isWorkingOmit,
          isOtOmit: isOtOmit,
        );

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
