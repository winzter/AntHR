import 'package:equatable/equatable.dart';

class ShiftEntity extends Equatable{
  final int? idShiftGroup;
  final String? nameShiftGroup;
  final int? shiftStartInMonday;
  final dynamic shiftStartDate;
  final int? workDay;
  final int? offDay;
  final int? shiftNumber;
  final int? idWorkingType;
  final List<ShiftPattern>? shiftPattern;
  final List<Shift>? shift;

  const ShiftEntity({
    this.idShiftGroup,
    this.nameShiftGroup,
    this.shiftStartInMonday,
    this.shiftStartDate,
    this.workDay,
    this.offDay,
    this.shiftNumber,
    this.idWorkingType,
    this.shiftPattern,
    this.shift,
  });

  @override
  List<Object?> get props => [
    idShiftGroup,
    nameShiftGroup,
    shiftStartInMonday,
    shiftStartDate,
    workDay,
    offDay,
    shiftNumber,
    idWorkingType,
    shiftPattern,
    shift,
  ];
}

class Shift extends Equatable{
  final int? idShift;
  final String? nameShift;
  final int? idShiftGroup;
  final int? isActive;
  final int? idCompany;

  const Shift({
    this.idShift,
    this.nameShift,
    this.idShiftGroup,
    this.isActive,
    this.idCompany,
  });

  @override
  List<Object?> get props => [
    idShift,
    nameShift,
    idShiftGroup,
    isActive,
    idCompany,
  ];
}

class ShiftPattern extends Equatable{
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
  final int? idShiftGroup;
  final String? nameShiftGroup;
  final int? shiftStartInMonday;

  const ShiftPattern({
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
    this.idShiftGroup,
    this.nameShiftGroup,
    this.shiftStartInMonday,
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
    idShiftGroup,
    nameShiftGroup,
    shiftStartInMonday,
  ];
}
