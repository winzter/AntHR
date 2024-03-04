import 'package:equatable/equatable.dart';

class DayCannotLeave extends Equatable{
  final DateTime? date;
  final Pattern? pattern;

  const DayCannotLeave({
    this.date,
    this.pattern,
  });

  @override
  List<Object?> get props => [date,pattern];

}

class Pattern extends Equatable{
  final int? idShiftPattern;
  final int? indexScheduleId;
  final int? idShift;
  final String? nameShift;
  final int? idShiftType;
  final String? nameShiftType;
  final String? timeIn;
  final String? timeOut;
  final int? breakTime;
  final int? isWorkingDay;
  final int? lateIn;
  final int? period;
  final dynamic fixOt;
  final int? workingHours;
  final int? idCompany;
  final int? idShiftGroup;
  final String? nameShiftGroup;
  final int? shiftStartInMonday;
  final DateTime? shiftStartDate;
  final int? shiftNumber;
  final int? workDay;
  final int? offDay;
  final dynamic breakTimeMin;
  final String? startBreak;
  final int? idWorkingType;
  final String? workingTypeName;

  const Pattern({
    this.idShiftPattern,
    this.indexScheduleId,
    this.idShift,
    this.nameShift,
    this.idShiftType,
    this.nameShiftType,
    this.timeIn,
    this.timeOut,
    this.breakTime,
    this.isWorkingDay,
    this.lateIn,
    this.period,
    this.fixOt,
    this.workingHours,
    this.idCompany,
    this.idShiftGroup,
    this.nameShiftGroup,
    this.shiftStartInMonday,
    this.shiftStartDate,
    this.shiftNumber,
    this.workDay,
    this.offDay,
    this.breakTimeMin,
    this.startBreak,
    this.idWorkingType,
    this.workingTypeName,
  });

  @override
  List<Object?> get props => [
    idShiftPattern,
    indexScheduleId,
    idShift,
    nameShift,
    idShiftType,
    nameShiftType,
    timeIn,
    timeOut,
    breakTime,
    isWorkingDay,
    lateIn,
    period,
    fixOt,
    workingHours,
    idCompany,
    idShiftGroup,
    nameShiftGroup,
    shiftStartInMonday,
    shiftStartDate,
    shiftNumber,
    workDay,
    offDay,
    breakTimeMin,
    startBreak,
    idWorkingType,
    workingTypeName,
  ];
}
