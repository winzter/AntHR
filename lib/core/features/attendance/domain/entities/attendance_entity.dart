import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable{
  final DateTime? date;
  final HolidayEntity? holiday;
  final PatternEntity? pattern;
  final List<RequestTimeEntity>? requestTime;
  final AttendanceClassEntity? attendance;
  final List<LeaveEntity>? leave;
  final List<OtEntity>? ot;
  final bool? absent;
  final ManagerEntity? manager;
  final PayrollSettingAttendanceEntity? payrollSetting;

  const AttendanceEntity({
    this.date,
    this.holiday,
    this.pattern,
    this.requestTime,
    this.attendance,
    this.leave,
    this.ot,
    this.absent,
    this.manager,
    this.payrollSetting,
  });

  @override
  List<Object?> get props => [
    date,
    holiday,
    pattern,
    attendance,
    leave,
    ot,
    absent,
  ];
}

class AttendanceClassEntity extends Equatable{
  final RoundEntity? round1;
  final RoundEntity? round2;

  const AttendanceClassEntity({
    this.round1,
    this.round2,
  });

  @override
  List<Object?> get props => [
    round1,
    round2
  ];
}

class RoundEntity extends Equatable{
  final CheckEntity? checkIn;
  final CheckEntity? checkOut;

 const RoundEntity({
    this.checkIn,
    this.checkOut,
  });

  @override
  List<Object?> get props => [
    checkIn,
    checkOut
  ];
}

class CheckEntity extends Equatable{
  final int? idAttendance;
  final DateTime? attendanceDateTime;
  final dynamic isCheckIn;
  final dynamic workDay;
  final int? idAttendanceType;
  final int? idGpsLocations;
  final int? idEmp;
  final int? idCompany;
  final dynamic idShift;
  final int? idVendor;
  final dynamic gpsAddress;
  final int? idGroupGpsLocations;
  final String? gpsLocationsName;
  final String? attendanceTextDateTime;
  final String? attendanceTextTime;

  const CheckEntity({
    this.idAttendance,
    this.attendanceDateTime,
    this.isCheckIn,
    this.workDay,
    this.idAttendanceType,
    this.idGpsLocations,
    this.idEmp,
    this.idCompany,
    this.idShift,
    this.idVendor,
    this.gpsAddress,
    this.idGroupGpsLocations,
    this.gpsLocationsName,
    this.attendanceTextDateTime,
    this.attendanceTextTime,
  });

  @override
  List<Object?> get props => [
    idAttendance,
    attendanceDateTime,
    isCheckIn,
    workDay,
    idAttendanceType,
    idGpsLocations,
    idEmp,
    idCompany,
    idShift,
    idVendor,
    gpsAddress,
    idGroupGpsLocations,
    gpsLocationsName,
    attendanceTextDateTime,
    attendanceTextTime,
  ];
}

class LeaveEntity extends Equatable {
  final int? idLeave;
  final int? idLeaveType;
  final String? description;
  final DateTime? start;
  final DateTime? end;
  final int? idEmp;
  final double? used;
  final double? quota;
  final double? balance;
  final double? remaining;
  final int? idManagerEmployee;
  final dynamic approveDate;
  final dynamic isApprove;
  final int? isFullDay;
  final dynamic workingStart;
  final dynamic workingEnd;
  final int? isActive;
  final DateTime? createDate;
  final dynamic isWithdraw;
  final dynamic filename;
  final dynamic commentManager;
  final String? name;
  final String? approveDateText;
  final String? createDateText;
  final String? startText;
  final String? endText;

  const LeaveEntity({
    this.idLeave,
    this.idLeaveType,
    this.description,
    this.start,
    this.end,
    this.idEmp,
    this.used,
    this.quota,
    this.balance,
    this.remaining,
    this.idManagerEmployee,
    this.approveDate,
    this.isApprove,
    this.isFullDay,
    this.workingStart,
    this.workingEnd,
    this.isActive,
    this.createDate,
    this.isWithdraw,
    this.filename,
    this.commentManager,
    this.name,
    this.approveDateText,
    this.createDateText,
    this.startText,
    this.endText,
  });

  @override
  List<Object?> get props => [
    idLeave,
    idLeaveType,
    description,
    start,
    end,
    idEmp,
    used,
    quota,
    balance,
    remaining,
    idManagerEmployee,
    approveDate,
    isApprove,
    isFullDay,
    workingStart,
    workingEnd,
    isActive,
    createDate,
    isWithdraw,
    filename,
    commentManager,
    name,
    approveDateText,
    createDateText,
    startText,
    endText,
  ];
}

class HolidayEntity extends Equatable{
  final int? idHoliday;
  final String? name;
  final DateTime? dateHoliday;
  final dynamic compensateName;
  final dynamic compensateDate;
  final int? idCompany;
  final int? holidayYear;

  const HolidayEntity({
    this.idHoliday,
    this.name,
    this.dateHoliday,
    this.compensateName,
    this.compensateDate,
    this.idCompany,
    this.holidayYear,
  });

  @override
  List<Object?> get props => [
    idHoliday,
    name,
    dateHoliday,
    compensateName,
    compensateDate,
    idCompany,
    holidayYear,
  ];
}

class ManagerEntity extends Equatable{
  final int? idEmployeePosition;
  final int? idEmp;
  final int? idPositions;
  final DateTime? start;
  final dynamic end;
  final dynamic remark;
  final int? idManagerLv1;
  final int? idManagerLv2;
  final int? idCompanyCharge;
  final int? updateBy;
  final dynamic updateDate;

  const ManagerEntity({
    this.idEmployeePosition,
    this.idEmp,
    this.idPositions,
    this.start,
    this.end,
    this.remark,
    this.idManagerLv1,
    this.idManagerLv2,
    this.idCompanyCharge,
    this.updateBy,
    this.updateDate,
  });

  @override
  List<Object?> get props => [
    idEmployeePosition,
    idEmp,
    idPositions,
    start,
    end,
    remark,
    idManagerLv1,
    idManagerLv2,
    idCompanyCharge,
    updateBy,
    updateDate,
  ];
}

class PatternEntity extends Equatable{
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

  const PatternEntity({
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

class PayrollSettingAttendanceEntity extends Equatable {
  final String? positionsName;
  final double? xWorkingDailyHoliday;
  final double? xWorkingMonthlyHoliday;
  final double? xOt;
  final double? xOtHoliday;

  const PayrollSettingAttendanceEntity({
    this.positionsName,
    this.xWorkingDailyHoliday,
    this.xWorkingMonthlyHoliday,
    this.xOt,
    this.xOtHoliday,
  });

  @override
  List<Object?> get props => [
    positionsName,
    xWorkingDailyHoliday,
    xWorkingMonthlyHoliday,
    xOt,
    xOtHoliday,
  ];
}

class OtEntity extends Equatable{
  final int? idRequestTime;
  final DateTime? start;
  final DateTime? end;
  final DateTime? workDate;
  final int? idRequestReason;
  final int? idRequestType;
  final String? otherReason;
  final int? idEmp;
  final int? isManagerLv1Approve;
  final dynamic isManagerLv2Approve;
  final int? amountHours;
  final double? xOt;
  final double? xOtHoliday;
  final double? xWorkingDailyHoliday;
  final double? xWorkingMonthlyHoliday;
  final int? isActive;
  final int? managerLv1ApproveBy;
  final DateTime? managerLv1ApproveDate;
  final dynamic managerLv2ApproveBy;
  final dynamic managerLv2ApproveDate;
  final int? createBy;
  final DateTime? createDate;
  final int? updateBy;
  final DateTime? updateDate;
  final int? isDoubleApproval;
  final int? approvalLevel;
  final dynamic fillInCreate;
  final dynamic fillInApproveLv1;
  final dynamic fillInApproveLv2;
  final dynamic isWithdraw;
  final dynamic commentManagerLv1;
  final dynamic commentManagerLv2;
  final String? name;
  final String? reasonName;
  final int? idVendor;
  final int? managerLv1Id;
  final String? managerLv1Name;
  final String? emailManagerLv1;
  final dynamic managerLv2Id;
  final dynamic managerLv2Name;
  final dynamic emailManagerLv2;
  final String? createDateText;
  final String? startText;
  final String? endText;
  final String? managerLv1ApproveDateText;
  final dynamic managerLv2ApproveDateText;

  const OtEntity({
    this.idRequestTime,
    this.start,
    this.end,
    this.workDate,
    this.idRequestReason,
    this.idRequestType,
    this.otherReason,
    this.idEmp,
    this.isManagerLv1Approve,
    this.isManagerLv2Approve,
    this.amountHours,
    this.xOt,
    this.xOtHoliday,
    this.xWorkingDailyHoliday,
    this.xWorkingMonthlyHoliday,
    this.isActive,
    this.managerLv1ApproveBy,
    this.managerLv1ApproveDate,
    this.managerLv2ApproveBy,
    this.managerLv2ApproveDate,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.updateDate,
    this.isDoubleApproval,
    this.approvalLevel,
    this.fillInCreate,
    this.fillInApproveLv1,
    this.fillInApproveLv2,
    this.isWithdraw,
    this.commentManagerLv1,
    this.commentManagerLv2,
    this.name,
    this.reasonName,
    this.idVendor,
    this.managerLv1Id,
    this.managerLv1Name,
    this.emailManagerLv1,
    this.managerLv2Id,
    this.managerLv2Name,
    this.emailManagerLv2,
    this.createDateText,
    this.startText,
    this.endText,
    this.managerLv1ApproveDateText,
    this.managerLv2ApproveDateText,
  });

  @override
  List<Object?> get props => [
    idRequestTime,
    start,
    end,
    workDate,
    idRequestReason,
    idRequestType,
    otherReason,
    idEmp,
    isManagerLv1Approve,
    isManagerLv2Approve,
    amountHours,
    xOt,
    xOtHoliday,
    xWorkingDailyHoliday,
    xWorkingMonthlyHoliday,
    isActive,
    managerLv1ApproveBy,
    managerLv1ApproveDate,
    managerLv2ApproveBy,
    managerLv2ApproveDate,
    createBy,
    createDate,
    updateBy,
    updateDate,
    isDoubleApproval,
    approvalLevel,
    fillInCreate,
    fillInApproveLv1,
    fillInApproveLv2,
    isWithdraw,
    commentManagerLv1,
    commentManagerLv2,
    name,
    reasonName,
    idVendor,
    managerLv1Id,
    managerLv1Name,
    emailManagerLv1,
    managerLv2Id,
    managerLv2Name,
    emailManagerLv2,
    createDateText,
    startText,
    endText,
    managerLv1ApproveDateText,
    managerLv2ApproveDateText,
  ];
}

class RequestTimeEntity extends Equatable {
  final int? idRequestTime;
  final DateTime? start;
  final DateTime? end;
  final DateTime? workDate;
  final int? idRequestReason;
  final int? idRequestType;
  final String? otherReason;
  final int? idEmp;
  final int? isManagerLv1Approve;
  final dynamic isManagerLv2Approve;
  final int? amountHours;
  final double? xOt;
  final double? xOtHoliday;
  final double? xWorkingDailyHoliday;
  final double? xWorkingMonthlyHoliday;
  final int? isActive;
  final int? managerLv1ApproveBy;
  final DateTime? managerLv1ApproveDate;
  final dynamic managerLv2ApproveBy;
  final dynamic managerLv2ApproveDate;
  final int? createBy;
  final DateTime? createDate;
  final int? updateBy;
  final DateTime? updateDate;
  final int? isDoubleApproval;
  final int? approvalLevel;
  final dynamic fillInCreate;
  final dynamic fillInApproveLv1;
  final dynamic fillInApproveLv2;
  final dynamic isWithdraw;
  final dynamic commentManagerLv1;
  final dynamic commentManagerLv2;
  final String? name;
  final String? reasonName;
  final int? idVendor;
  final int? managerLv1Id;
  final String? managerLv1Name;
  final String? emailManagerLv1;
  final dynamic managerLv2Id;
  final dynamic managerLv2Name;
  final dynamic emailManagerLv2;
  final String? createDateText;
  final String? startText;
  final String? endText;
  final String? managerLv1ApproveDateText;
  final dynamic managerLv2ApproveDateText;

  const RequestTimeEntity({
    this.idRequestTime,
    this.start,
    this.end,
    this.workDate,
    this.idRequestReason,
    this.idRequestType,
    this.otherReason,
    this.idEmp,
    this.isManagerLv1Approve,
    this.isManagerLv2Approve,
    this.amountHours,
    this.xOt,
    this.xOtHoliday,
    this.xWorkingDailyHoliday,
    this.xWorkingMonthlyHoliday,
    this.isActive,
    this.managerLv1ApproveBy,
    this.managerLv1ApproveDate,
    this.managerLv2ApproveBy,
    this.managerLv2ApproveDate,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.updateDate,
    this.isDoubleApproval,
    this.approvalLevel,
    this.fillInCreate,
    this.fillInApproveLv1,
    this.fillInApproveLv2,
    this.isWithdraw,
    this.commentManagerLv1,
    this.commentManagerLv2,
    this.name,
    this.reasonName,
    this.idVendor,
    this.managerLv1Id,
    this.managerLv1Name,
    this.emailManagerLv1,
    this.managerLv2Id,
    this.managerLv2Name,
    this.emailManagerLv2,
    this.createDateText,
    this.startText,
    this.endText,
    this.managerLv1ApproveDateText,
    this.managerLv2ApproveDateText,
  });

  @override
  List<Object?> get props => [
    idRequestTime,
    start,
    end,
    workDate,
    idRequestReason,
    idRequestType,
    otherReason,
    idEmp,
    isManagerLv1Approve,
    isManagerLv2Approve,
    amountHours,
    xOt,
    xOtHoliday,
    xWorkingDailyHoliday,
    xWorkingMonthlyHoliday,
    isActive,
    managerLv1ApproveBy,
    managerLv1ApproveDate,
    managerLv2ApproveBy,
    managerLv2ApproveDate,
    createBy,
    createDate,
    updateBy,
    updateDate,
    isDoubleApproval,
    approvalLevel,
    fillInCreate,
    fillInApproveLv1,
    fillInApproveLv2,
    isWithdraw,
    commentManagerLv1,
    commentManagerLv2,
    name,
    reasonName,
    idVendor,
    managerLv1Id,
    managerLv1Name,
    emailManagerLv1,
    managerLv2Id,
    managerLv2Name,
    emailManagerLv2,
    createDateText,
    startText,
    endText,
    managerLv1ApproveDateText,
    managerLv2ApproveDateText,
  ];
}