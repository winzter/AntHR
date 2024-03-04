import 'package:equatable/equatable.dart';

class ShiftAndOtEntity extends Equatable {
  final List<DataTable>? dataTable;
  final DateTime? start;
  final DateTime? end;
  final int? idPaymentType;
  final String? workingType;
  final Dock? dock;
  final bool? isShiftFee;

  const ShiftAndOtEntity({
    this.dataTable,
    this.start,
    this.end,
    this.workingType,
    this.dock,
    this.isShiftFee,
    this.idPaymentType,
  });

  @override
  List<Object?> get props => [
        dataTable,
        start,
        end,
        workingType,
        dock,
        isShiftFee,
        idPaymentType,
      ];
}

class DataTable extends Equatable {
  final String? date;
  final DateTime? dateText;
  final DataRender? dataRender;
  final int? salary;
  final double? otOneHours;
  final double? otOneFiveHours;
  final double? otTwoHours;
  final double? otThreeHours;
  final double? otOneAmount;
  final double? otOneFiveAmount;
  final double? otTwoAmount;
  final double? otThreeAmount;
  final double? shiftMorning;
  final double? shiftNoon;
  final double? shiftNight;
  final double? workingDay;

  const DataTable({
    this.date,
    this.dateText,
    this.dataRender,
    this.salary,
    this.otOneHours,
    this.otOneFiveHours,
    this.otTwoHours,
    this.otThreeHours,
    this.otOneAmount,
    this.otOneFiveAmount,
    this.otTwoAmount,
    this.otThreeAmount,
    this.shiftMorning,
    this.shiftNoon,
    this.shiftNight,
    this.workingDay,
  });

  @override
  List<Object?> get props => [
        date,
        dateText,
        dataRender,
        salary,
        otOneHours,
        otOneFiveHours,
        otTwoHours,
        otThreeHours,
        otOneAmount,
        otOneFiveAmount,
        otTwoAmount,
        otThreeAmount,
        shiftMorning,
        shiftNoon,
        shiftNight,
        workingDay,
      ];
}

class DataRender extends Equatable {
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
  final int? idWorkingType;
  final String? workingTypeName;

  const DataRender({
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
        idWorkingType,
        workingTypeName,
      ];
}

class Dock extends Equatable {
  final DateTime? start;
  final DateTime? end;
  final Absent? lateEarly;
  final Absent? absent;

  const Dock({
    this.start,
    this.end,
    this.lateEarly,
    this.absent,
  });

  @override
  List<Object?> get props => [
        start,
        end,
        lateEarly,
        absent,
      ];
}

class Absent extends Equatable {
  final int? value;
  final int? amount;

  const Absent({
    this.value,
    this.amount,
  });

  @override
  List<Object?> get props => [
        value,
        amount,
      ];
}
