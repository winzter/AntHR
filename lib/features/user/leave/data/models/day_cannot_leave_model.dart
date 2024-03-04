import 'dart:convert';

import 'package:anthr/features/user/leave/domain/entities/day_cannot_leave_entity.dart';

List<DayCannotLeaveModel> dayCannotLeaveModelFromJson(String str) => List<DayCannotLeaveModel>.from(json.decode(str).map((x) => DayCannotLeaveModel.fromJson(x)));

// String dayCannotLeaveModelToJson(List<DayCannotLeaveModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DayCannotLeaveModel extends DayCannotLeave{

  const DayCannotLeaveModel({
    required super.date,
    required super.pattern,
  });

  factory DayCannotLeaveModel.fromJson(Map<String, dynamic> json) => DayCannotLeaveModel(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    pattern: json["pattern"] == null ? null : PatternModel.fromJson(json["pattern"]),
  );

  // Map<String, dynamic> toJson() => {
  //   "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
  //   "pattern": pattern?.toJson(),
  // };
}

class PatternModel extends Pattern{

  const PatternModel({
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
    required super.breakTimeMin,
    required super.startBreak,
    required super.idWorkingType,
    required super.workingTypeName,
  });

  factory PatternModel.fromJson(Map<String, dynamic> json) => PatternModel(
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
    breakTimeMin: json["breakTimeMin"],
    startBreak: json["startBreak"],
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
    "breakTimeMin": breakTimeMin,
    "startBreak": startBreak,
    "idWorkingType": idWorkingType,
    "workingTypeName": workingTypeName,
  };
}
