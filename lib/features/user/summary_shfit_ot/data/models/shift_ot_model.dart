import 'dart:convert';
import 'package:anthr/features/user/summary_shfit_ot/domain/entities/shift_ot_entity.dart';

ShiftAndOtModel shiftAndOtModelFromJson(String str) => ShiftAndOtModel.fromJson(json.decode(str));

// String shiftAndOtModelToJson(ShiftAndOtModel data) => json.encode(data.toJson());

class ShiftAndOtModel extends ShiftAndOtEntity{

  const ShiftAndOtModel({
    required super.start,
    required super.end,
    required super.isShiftFee,
    required super.idPaymentType,
    required super.dock,
    required super.dataTable,
  });

  factory ShiftAndOtModel.fromJson(Map<String, dynamic> json) => ShiftAndOtModel(
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    isShiftFee: json["isShiftFee"],
    idPaymentType: json["idPaymentType"],
    dock: json["dock"] == null ? null : DockModel.fromJson(json["dock"]),
    dataTable: json["dataTable"] == null ? [] : List<DataTableModel>.from(json["dataTable"]!.map((x) => DataTableModel.fromJson(x))),
  );

  // Map<String, dynamic> toJson() => {
  //   "start": "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
  //   "end": "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
  //   "isShiftFee": isShiftFee,
  //   "idPaymentType": idPaymentType,
  //   "dock": dock?.toJson(),
  //   "dataTable": dataTable == null ? [] : List<dynamic>.from(dataTable!.map((x) => x.toJson())),
  // };
}

class DataTableModel extends DataTable{

  const DataTableModel({
    required super.date,
    required super.dateText,
    required super.dataRender,
    required super.salary,
    required super.otOneHours,
    required super.otOneAmount,
    required super.otOneFiveHours,
    required super.otOneFiveAmount,
    required super.otTwoHours,
    required super.otTwoAmount,
    required super.otThreeHours,
    required super.otThreeAmount,
    required super.shiftMorning,
    required super.shiftNoon,
    required super.shiftNight,
    required super.workingDay,
  });

  factory DataTableModel.fromJson(Map<String, dynamic> json) => DataTableModel(
    date: json["date"],
    dateText: json["dateText"] == null ? null : DateTime.parse(json["dateText"]),
    dataRender: json["dataRender"] == null ? null : DataRenderModel.fromJson(json["dataRender"]),
    salary: json["salary"],
    otOneHours: json["otOneHours"]?.toDouble(),
    otOneAmount: json["otOneAmount"]?.toDouble(),
    otOneFiveHours: json["otOneFiveHours"]?.toDouble(),
    otOneFiveAmount: json["otOneFiveAmount"]?.toDouble(),
    otTwoHours: json["otTwoHours"]?.toDouble(),
    otTwoAmount: json["otTwoAmount"]?.toDouble(),
    otThreeHours: json["otThreeHours"]?.toDouble(),
    otThreeAmount: json["otThreeAmount"]?.toDouble(),
    shiftMorning: json["shiftMorning"]?.toDouble(),
    shiftNoon: json["shiftNoon"]?.toDouble(),
    shiftNight: json["shiftNight"]?.toDouble(),
    workingDay: json["workingDay"]?.toDouble(),
  );

  // Map<String, dynamic> toJson() => {
  //   "date": date,
  //   "dateText": "${dateText!.year.toString().padLeft(4, '0')}-${dateText!.month.toString().padLeft(2, '0')}-${dateText!.day.toString().padLeft(2, '0')}",
  //   "dataRender": dataRender?.toJson(),
  //   "salary": salary,
  //   "otOneHours": otOneHours,
  //   "otOneAmount": otOneAmount,
  //   "otOneFiveHours": otOneFiveHours,
  //   "otOneFiveAmount": otOneFiveAmount,
  //   "otTwoHours": otTwoHours,
  //   "otTwoAmount": otTwoAmount,
  //   "otThreeHours": otThreeHours,
  //   "otThreeAmount": otThreeAmount,
  //   "shiftMorning": shiftMorning,
  //   "shiftNoon": shiftNoon,
  //   "shiftNight": shiftNight,
  //   "workingDay": workingDay,
  // };
}

class DataRenderModel extends DataRender{

  const DataRenderModel({
    required super.idShiftPattern,
    required super.indexScheduleId,
    required super.idShift,
    required super.nameShift,
    required super.idShiftType,
    required super.nameShiftType,
    required super.timeIn,
    required super.timeOut,
    required super.breakTime,
    required super.isWorkingDay,
    required super.lateIn,
    required super.period,
    required super.fixOt,
    required super.workingHours,
    required super.idCompany,
    required super.idShiftGroup,
    required super.nameShiftGroup,
    required super.shiftStartInMonday,
    required super.shiftStartDate,
    required super.shiftNumber,
    required super.workDay,
    required super.offDay,
    required super.idWorkingType,
    required super.workingTypeName,
  });

  factory DataRenderModel.fromJson(Map<String, dynamic> json) => DataRenderModel(
    idShiftPattern: json["idShiftPattern"],
    indexScheduleId: json["indexScheduleId"],
    idShift: json["idShift"],
    nameShift: json["nameShift"],
    idShiftType: json["idShiftType"],
    nameShiftType: json["nameShiftType"],
    timeIn: json["timeIn"],
    timeOut: json["timeOut"],
    breakTime: json["breakTime"],
    isWorkingDay: json["isWorkingDay"],
    lateIn: json["lateIn"],
    period: json["period"],
    fixOt: json["fixOT"],
    workingHours: json["workingHours"],
    idCompany: json["idCompany"],
    idShiftGroup: json["idShiftGroup"],
    nameShiftGroup: json["nameShiftGroup"],
    shiftStartInMonday: json["shiftStartInMonday"],
    shiftStartDate: json["shiftStartDate"] == null ? null : DateTime.parse(json["shiftStartDate"]),
    shiftNumber: json["shiftNumber"],
    workDay: json["workDay"],
    offDay: json["offDay"],
    idWorkingType: json["idWorkingType"],
    workingTypeName: json["workingTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "idShiftPattern": idShiftPattern,
    "indexScheduleId": indexScheduleId,
    "idShift": idShift,
    "nameShift": nameShift,
    "idShiftType": idShiftType,
    "nameShiftType": nameShiftType,
    "timeIn": timeIn,
    "timeOut": timeOut,
    "breakTime": breakTime,
    "isWorkingDay": isWorkingDay,
    "lateIn": lateIn,
    "period": period,
    "fixOT": fixOt,
    "workingHours": workingHours,
    "idCompany": idCompany,
    "idShiftGroup": idShiftGroup,
    "nameShiftGroup": nameShiftGroup,
    "shiftStartInMonday": shiftStartInMonday,
    "shiftStartDate": shiftStartDate?.toIso8601String(),
    "shiftNumber": shiftNumber,
    "workDay": workDay,
    "offDay": offDay,
    "idWorkingType": idWorkingType,
    "workingTypeName": workingTypeName,
  };
}

class DockModel extends Dock{
  const DockModel({
    required super.start,
    required super.end,
    required super.lateEarly,
    required super.absent,
  });

  factory DockModel.fromJson(Map<String, dynamic> json) => DockModel(
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    lateEarly: json["lateEarly"] == null ? null : AbsentModel.fromJson(json["lateEarly"]),
    absent: json["absent"] == null ? null : AbsentModel.fromJson(json["absent"]),
  );

  // Map<String, dynamic> toJson() => {
  //   "start": "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
  //   "end": "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
  //   "lateEarly": lateEarly?.toJson(),
  //   "absent": absent?.toJson(),
  // };
}

class AbsentModel extends Absent {

  const AbsentModel({
    required super.value,
    required super.amount,
  });

  factory AbsentModel.fromJson(Map<String, dynamic> json) => AbsentModel(
    value: json["value"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "amount": amount,
  };
}
