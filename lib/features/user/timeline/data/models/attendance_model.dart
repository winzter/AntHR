import 'dart:convert';
import 'package:anthr/features/user/timeline/domain/entities/entities.dart';

List<TimeLineModel> getAttendanceDataFromJson(String str) =>
    List<TimeLineModel>.from(
        json.decode(str).map((x) => TimeLineModel.fromJson(x)));

// String getAttendanceDataToJson(List<TimeLineModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeLineModel extends TimeLineEntity{
  const TimeLineModel({
   required super.date,
   required Holiday? super.holiday,
   required Pattern? super.pattern,
   required List<RequestTime>? super.requestTime,
   required Attendance? super.attendance,
   required List<Leave>? super.leave,
   required List<Ot>? super.ot,
   required super.absent,
    required super.isLate,
    required super.totalLate,
    required super.isEarlyOut,
    required super.totalEarlyOut,
   required Manager? super.manager,
   required PayrollSetting? super.payrollSetting,
  });

  factory TimeLineModel.fromJson(Map<String, dynamic> json) =>
      TimeLineModel(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        holiday:
        json["holiday"] == null ? null : Holiday.fromJson(json["holiday"]),
        pattern:
        json["pattern"] == null ? null : Pattern.fromJson(json["pattern"]),
        requestTime: json["requestTime"] == null
            ? []
            : List<RequestTime>.from(
            json["requestTime"]!.map((x) => RequestTime.fromJson(x))),
        attendance: json["attendance"] == null
            ? null
            : Attendance.fromJson(json["attendance"]),
        leave: json["leave"] == null
            ? []
            : List<Leave>.from(json["leave"]!.map((x) => Leave.fromJson(x))),
        ot: json["ot"] == null
            ? []
            : List<Ot>.from(json["ot"]!.map((x) => Ot.fromJson(x))),
        isLate: json["isLate"],
        totalLate: json["totalLate"],
        isEarlyOut: json["isEarlyOut"],
        totalEarlyOut: json["totalEarlyOut"],
        absent: json["absent"],
        manager:
        json["manager"] == null ? null : Manager.fromJson(json["manager"]),
        payrollSetting: json["payrollSetting"] == null
            ? null
            : PayrollSetting.fromJson(json["payrollSetting"]),
      );

  // Map<String, dynamic> toJson() => {
  //   "date":
  //   "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
  //   "holiday": holiday?.toJson(),
  //   "pattern": pattern?.toJson(),
  //   "requestTime": requestTime == null
  //       ? []
  //       : List<RequestTime>.from(requestTime!.map((x) => x.toJson())),
  //   "attendance": attendance?.toJson(),
  //   "leave": leave == null
  //       ? []
  //       : List<Leave>.from(leave!.map((x) => x.toJson())),
  //   "ot": ot == null ? [] : List<Ot>.from(ot!.map((x) => x.toJson())),
  //   "absent": absent,
  //   "manager": manager?.toJson(),
  //   "payrollSetting": payrollSetting?.toJson(),
  // };
}

class Attendance extends AttendanceClassEntity{

  const Attendance({
    required Round? round1,
    required Round? round2,
  }):super(
    round1: round1,
    round2: round2
  );

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    round1: json["round1"] == null ? null : Round.fromJson(json["round1"]),
    round2: json["round2"] == null ? null : Round.fromJson(json["round2"]),
  );

  // Map<String, dynamic> toJson() => {
  //   "round1": round1?.toJson(),
  //   "round2": round2?.toJson(),
  // };
}

class Round extends RoundEntity{
  const Round({
    required Check? checkIn,
    required Check? checkOut,
  }):super(
    checkIn: checkIn,
    checkOut: checkOut
  );

  factory Round.fromJson(Map<String, dynamic> json) => Round(
    checkIn:
    json["checkIn"] == null ? null : Check.fromJson(json["checkIn"]),
    checkOut:
    json["checkOut"] == null ? null : Check.fromJson(json["checkOut"]),
  );

  // Map<String, dynamic> toJson() => {
  //   "checkIn": checkIn?.toJson(),
  //   "checkOut": checkOut?.toJson(),
  // };
}

class Check extends CheckEntity{
  const Check({
    required super.idAttendance,
    required super.attendanceDateTime,
    required super.isCheckIn,
    required super.workDay,
    required super.idAttendanceType,
    required super.idGpsLocations,
    required super.idEmp,
    required super.idCompany,
    required super.idShift,
    required super.idVendor,
    required super.gpsAddress,
    required super.idGroupGpsLocations,
    required super.gpsLocationsName,
    required super.attendanceTextDateTime,
    required super.attendanceTextTime,
  });

  factory Check.fromJson(Map<String, dynamic> json) => Check(
    idAttendance: json["idAttendance"],
    attendanceDateTime: json["attendanceDateTime"] == null
        ? null
        : DateTime.parse(json["attendanceDateTime"]),
    isCheckIn: json["isCheckIn"],
    workDay: json["workDay"],
    idAttendanceType: json["idAttendanceType"],
    idGpsLocations: json["idGpsLocations"],
    idEmp: json["idEmp"],
    idCompany: json["idCompany"],
    idShift: json["idShift"],
    idVendor: json["idVendor"],
    gpsAddress: json["gpsAddress"],
    idGroupGpsLocations: json["idGroupGpsLocations"],
    gpsLocationsName: json["gpsLocationsName"],
    attendanceTextDateTime: json["attendanceTextDateTime"],
    attendanceTextTime: json["attendanceTextTime"],
  );

  Map<String, dynamic> toJson() => {
    "idAttendance": idAttendance,
    "attendanceDateTime": attendanceDateTime?.toIso8601String(),
    "isCheckIn": isCheckIn,
    "workDay": workDay,
    "idAttendanceType": idAttendanceType,
    "idGpsLocations": idGpsLocations,
    "idEmp": idEmp,
    "idCompany": idCompany,
    "idShift": idShift,
    "idVendor": idVendor,
    "gpsAddress": gpsAddress,
    "idGroupGpsLocations": idGroupGpsLocations,
    "gpsLocationsName": gpsLocationsName,
    "attendanceTextDateTime": attendanceTextDateTime,
    "attendanceTextTime": attendanceTextTime,
  };
}

class Leave extends LeaveEntity{
  const Leave({
    required super.idLeave,
    required super.idLeaveType,
    required super.description,
    required super.start,
    required super.end,
    required super.idEmp,
    required super.used,
    required super.quota,
    required super.balance,
    required super.remaining,
    required super.idManagerEmployee,
    required super.approveDate,
    required super.isApprove,
    required super.isFullDay,
    required super.workingStart,
    required super.workingEnd,
    required super.isActive,
    required super.createDate,
    required super.isWithdraw,
    required super.filename,
    required super.commentManager,
    required super.name,
    required super.approveDateText,
    required super.createDateText,
    required super.startText,
    required super.endText,
  });

  factory Leave.fromJson(Map<String, dynamic> json) => Leave(
    idLeave: json["idLeave"],
    idLeaveType: json["idLeaveType"],
    description: json["description"],
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    idEmp: json["idEmp"],
    used: json["used"].toDouble(),
    quota: json["quota"],
    balance: json["balance"].toDouble(),
    remaining: json["remaining"].toDouble(),
    idManagerEmployee: json["idManagerEmployee"],
    approveDate: json["approveDate"],
    isApprove: json["isApprove"],
    isFullDay: json["isFullDay"],
    workingStart: json["workingStart"],
    workingEnd: json["workingEnd"],
    isActive: json["isActive"],
    createDate: json["createDate"] == null
        ? null
        : DateTime.parse(json["createDate"]),
    isWithdraw: json["isWithdraw"],
    filename: json["filename"],
    commentManager: json["commentManager"],
    name: json["name"],
    approveDateText: json["approveDateText"],
    createDateText: json["createDateText"],
    startText: json["startText"],
    endText: json["endText"],
  );

  Map<String, dynamic> toJson() => {
    "idLeave": idLeave,
    "idLeaveType": idLeaveType,
    "description": description,
    "start": start?.toIso8601String(),
    "end": end?.toIso8601String(),
    "idEmp": idEmp,
    "used": used,
    "quota": quota,
    "balance": balance,
    "remaining": remaining,
    "idManagerEmployee": idManagerEmployee,
    "approveDate": approveDate,
    "isApprove": isApprove,
    "isFullDay": isFullDay,
    "workingStart": workingStart,
    "workingEnd": workingEnd,
    "isActive": isActive,
    "createDate": createDate?.toIso8601String(),
    "isWithdraw": isWithdraw,
    "filename": filename,
    "commentManager": commentManager,
    "name": name,
    "approveDateText": approveDateText,
    "createDateText": createDateText,
    "startText": startText,
    "endText": endText,
  };
}

class Holiday extends HolidayEntity{
  const Holiday({
    required super.idHoliday,
    required super.name,
    required super.dateHoliday,
    required super.compensateName,
    required super.compensateDate,
    required super.idCompany,
    required super.holidayYear,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
    idHoliday: json["idHoliday"],
    name: json["name"],
    dateHoliday: json["dateHoliday"] == null
        ? null
        : DateTime.parse(json["dateHoliday"]),
    compensateName: json["compensateName"],
    compensateDate: json["compensateDate"],
    idCompany: json["idCompany"],
    holidayYear: json["holidayYear"],
  );

  Map<String, dynamic> toJson() => {
    "idHoliday": idHoliday,
    "name": name,
    "dateHoliday": dateHoliday?.toIso8601String(),
    "compensateName": compensateName,
    "compensateDate": compensateDate,
    "idCompany": idCompany,
    "holidayYear": holidayYear,
  };
}

class Manager extends ManagerEntity{
  const Manager({
    required super.idEmployeePosition,
    required super.idEmp,
    required super.idPositions,
    required super.start,
    required super.end,
    required super.remark,
    required super.idManagerLv1,
    required super.idManagerLv2,
    required super.idCompanyCharge,
    required super.updateBy,
    required super.updateDate,
  });

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
    idEmployeePosition: json["idEmployeePosition"],
    idEmp: json["idEmp"],
    idPositions: json["idPositions"],
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"],
    remark: json["remark"],
    idManagerLv1: json["idManagerLV1"],
    idManagerLv2: json["idManagerLV2"],
    idCompanyCharge: json["idCompanyCharge"],
    updateBy: json["updateBy"],
    updateDate: json["updateDate"],
  );

  Map<String, dynamic> toJson() => {
    "idEmployeePosition": idEmployeePosition,
    "idEmp": idEmp,
    "idPositions": idPositions,
    "start": start?.toIso8601String(),
    "end": end,
    "remark": remark,
    "idManagerLV1": idManagerLv1,
    "idManagerLV2": idManagerLv2,
    "idCompanyCharge": idCompanyCharge,
    "updateBy": updateBy,
    "updateDate": updateDate,
  };
}

class Pattern extends PatternEntity{
  const Pattern({
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

  factory Pattern.fromJson(Map<String, dynamic> json) => Pattern(
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
    shiftStartDate: json["shiftStartDate"] == null
        ? null
        : DateTime.parse(json["shiftStartDate"]),
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

class PayrollSetting extends PayrollSettingEntity{
 const PayrollSetting({
    required super.positionsName,
    required super.xWorkingDailyHoliday,
    required super.xWorkingMonthlyHoliday,
    required super.xOt,
    required super.xOtHoliday,
  });

  factory PayrollSetting.fromJson(Map<String, dynamic> json) => PayrollSetting(
    positionsName: json["positionsName"],
    xWorkingDailyHoliday: json["xWorkingDailyHoliday"],
    xWorkingMonthlyHoliday: json["xWorkingMonthlyHoliday"],
    xOt: json["xOT"]?.toDouble(),
    xOtHoliday: json["xOTHoliday"],
  );

  Map<String, dynamic> toJson() => {
    "positionsName": positionsName,
    "xWorkingDailyHoliday": xWorkingDailyHoliday,
    "xWorkingMonthlyHoliday": xWorkingMonthlyHoliday,
    "xOT": xOt,
    "xOTHoliday": xOtHoliday,
  };
}

class Ot extends OtEntity{
  const Ot({
    required super.idRequestTime,
    required super.start,
    required super.end,
    required super.workDate,
    required super.idRequestReason,
    required super.idRequestType,
    required super.otherReason,
    required super.idEmp,
    required super.isManagerLv1Approve,
    required super.isManagerLv2Approve,
    required super.amountHours,
    required super.xOt,
    required super.xOtHoliday,
    required super.xWorkingDailyHoliday,
    required super.xWorkingMonthlyHoliday,
    required super.isActive,
    required super.managerLv1ApproveBy,
    required super.managerLv1ApproveDate,
    required super.managerLv2ApproveBy,
    required super.managerLv2ApproveDate,
    required super.createBy,
    required super.createDate,
    required super.updateBy,
    required super.updateDate,
    required super.isDoubleApproval,
    required super.approvalLevel,
    required super.fillInCreate,
    required super.fillInApproveLv1,
    required super.fillInApproveLv2,
    required super.isWithdraw,
    required super.commentManagerLv1,
    required super.commentManagerLv2,
    required super.name,
    required super.reasonName,
    required super.idVendor,
    required super.managerLv1Id,
    required super.managerLv1Name,
    required super.emailManagerLv1,
    required super.managerLv2Id,
    required super.managerLv2Name,
    required super.emailManagerLv2,
    required super.createDateText,
    required super.startText,
    required super.endText,
    required super.managerLv1ApproveDateText,
    required super.managerLv2ApproveDateText,
  });

  factory Ot.fromJson(Map<String, dynamic> json) => Ot(
    idRequestTime: json["idRequestTime"],
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    workDate:
    json["workDate"] == null ? null : DateTime.parse(json["workDate"]),
    idRequestReason: json["idRequestReason"],
    idRequestType: json["idRequestType"],
    otherReason: json["otherReason"],
    idEmp: json["idEmp"],
    isManagerLv1Approve: json["isManagerLV1Approve"],
    isManagerLv2Approve: json["isManagerLV2Approve"],
    amountHours: json["amountHours"],
    xOt: json["xOT"].toDouble(),
    xOtHoliday: json["xOTHoliday"],
    xWorkingDailyHoliday: json["xWorkingDailyHoliday"],
    xWorkingMonthlyHoliday: json["xWorkingMonthlyHoliday"],
    isActive: json["isActive"],
    managerLv1ApproveBy: json["managerLV1ApproveBy"],
    managerLv1ApproveDate: json["managerLV1ApproveDate"] == null
        ? null
        : DateTime.parse(json["managerLV1ApproveDate"]),
    managerLv2ApproveBy: json["managerLV2ApproveBy"],
    managerLv2ApproveDate: json["managerLV2ApproveDate"],
    createBy: json["createBy"],
    createDate: json["createDate"] == null
        ? null
        : DateTime.parse(json["createDate"]),
    updateBy: json["updateBy"],
    updateDate: json["updateDate"] == null
        ? null
        : DateTime.parse(json["updateDate"]),
    isDoubleApproval: json["isDoubleApproval"],
    approvalLevel: json["approvalLevel"],
    fillInCreate: json["fillInCreate"],
    fillInApproveLv1: json["fillInApproveLV1"],
    fillInApproveLv2: json["fillInApproveLV2"],
    isWithdraw: json["isWithdraw"],
    commentManagerLv1: json["commentManagerLV1"],
    commentManagerLv2: json["commentManagerLV2"],
    name: json["name"],
    reasonName: json["reasonName"],
    idVendor: json["idVendor"],
    managerLv1Id: json["managerLV1Id"],
    managerLv1Name: json["managerLV1Name"],
    emailManagerLv1: json["emailManagerLV1"],
    managerLv2Id: json["managerLV2Id"],
    managerLv2Name: json["managerLV2Name"],
    emailManagerLv2: json["emailManagerLV2"],
    createDateText: json["createDateText"],
    startText: json["startText"],
    endText: json["endText"],
    managerLv1ApproveDateText: json["managerLV1ApproveDateText"],
    managerLv2ApproveDateText: json["managerLV2ApproveDateText"],
  );

  Map<String, dynamic> toJson() => {
    "idRequestTime": idRequestTime,
    "start": start?.toIso8601String(),
    "end": end?.toIso8601String(),
    "workDate": workDate?.toIso8601String(),
    "idRequestReason": idRequestReason,
    "idRequestType": idRequestType,
    "otherReason": otherReason,
    "idEmp": idEmp,
    "isManagerLV1Approve": isManagerLv1Approve,
    "isManagerLV2Approve": isManagerLv2Approve,
    "amountHours": amountHours,
    "xOT": xOt,
    "xOTHoliday": xOtHoliday,
    "xWorkingDailyHoliday": xWorkingDailyHoliday,
    "xWorkingMonthlyHoliday": xWorkingMonthlyHoliday,
    "isActive": isActive,
    "managerLV1ApproveBy": managerLv1ApproveBy,
    "managerLV1ApproveDate": managerLv1ApproveDate?.toIso8601String(),
    "managerLV2ApproveBy": managerLv2ApproveBy,
    "managerLV2ApproveDate": managerLv2ApproveDate,
    "createBy": createBy,
    "createDate": createDate?.toIso8601String(),
    "updateBy": updateBy,
    "updateDate": updateDate?.toIso8601String(),
    "isDoubleApproval": isDoubleApproval,
    "approvalLevel": approvalLevel,
    "fillInCreate": fillInCreate,
    "fillInApproveLV1": fillInApproveLv1,
    "fillInApproveLV2": fillInApproveLv2,
    "isWithdraw": isWithdraw,
    "commentManagerLV1": commentManagerLv1,
    "commentManagerLV2": commentManagerLv2,
    "name": name,
    "reasonName": reasonName,
    "idVendor": idVendor,
    "managerLV1Id": managerLv1Id,
    "managerLV1Name": managerLv1Name,
    "emailManagerLV1": emailManagerLv1,
    "managerLV2Id": managerLv2Id,
    "managerLV2Name": managerLv2Name,
    "emailManagerLV2": emailManagerLv2,
    "createDateText": createDateText,
    "startText": startText,
    "endText": endText,
    "managerLV1ApproveDateText": managerLv1ApproveDateText,
    "managerLV2ApproveDateText": managerLv2ApproveDateText,
  };
}

class RequestTime extends RequestTimeEntity{

  const RequestTime({
    required super.idRequestTime,
    required super.start,
    required super.end,
    required super.workDate,
    required super.idRequestReason,
    required super.idRequestType,
    required super.otherReason,
    required super.idEmp,
    required super.isManagerLv1Approve,
    required super.isManagerLv2Approve,
    required super.amountHours,
    required super.xOt,
    required super.xOtHoliday,
    required super.xWorkingDailyHoliday,
    required super.xWorkingMonthlyHoliday,
    required super.isActive,
    required super.managerLv1ApproveBy,
    required super.managerLv1ApproveDate,
    required super.managerLv2ApproveBy,
    required super.managerLv2ApproveDate,
    required super.createBy,
    required super.createDate,
    required super.updateBy,
    required super.updateDate,
    required super.isDoubleApproval,
    required super.approvalLevel,
    required super.fillInCreate,
    required super.fillInApproveLv1,
    required super.fillInApproveLv2,
    required super.isWithdraw,
    required super.commentManagerLv1,
    required super.commentManagerLv2,
    required super.name,
    required super.reasonName,
    required super.idVendor,
    required super.managerLv1Id,
    required super.managerLv1Name,
    required super.emailManagerLv1,
    required super.managerLv2Id,
    required super.managerLv2Name,
    required super.emailManagerLv2,
    required super.createDateText,
    required super.startText,
    required super.endText,
    required super.managerLv1ApproveDateText,
    required super.managerLv2ApproveDateText,
  });

  factory RequestTime.fromJson(Map<String, dynamic> json) => RequestTime(
    idRequestTime: json["idRequestTime"],
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    workDate:
    json["workDate"] == null ? null : DateTime.parse(json["workDate"]),
    idRequestReason: json["idRequestReason"],
    idRequestType: json["idRequestType"],
    otherReason: json["otherReason"],
    idEmp: json["idEmp"],
    isManagerLv1Approve: json["isManagerLV1Approve"],
    isManagerLv2Approve: json["isManagerLV2Approve"],
    amountHours: json["amountHours"],
    xOt: json["xOT"],
    xOtHoliday: json["xOTHoliday"],
    xWorkingDailyHoliday: json["xWorkingDailyHoliday"],
    xWorkingMonthlyHoliday: json["xWorkingMonthlyHoliday"],
    isActive: json["isActive"],
    managerLv1ApproveBy: json["managerLV1ApproveBy"],
    managerLv1ApproveDate: json["managerLV1ApproveDate"] == null
        ? null
        : DateTime.parse(json["managerLV1ApproveDate"]),
    managerLv2ApproveBy: json["managerLV2ApproveBy"],
    managerLv2ApproveDate: json["managerLV2ApproveDate"],
    createBy: json["createBy"],
    createDate: json["createDate"] == null
        ? null
        : DateTime.parse(json["createDate"]),
    updateBy: json["updateBy"],
    updateDate: json["updateDate"] == null
        ? null
        : DateTime.parse(json["updateDate"]),
    isDoubleApproval: json["isDoubleApproval"],
    approvalLevel: json["approvalLevel"],
    fillInCreate: json["fillInCreate"],
    fillInApproveLv1: json["fillInApproveLV1"],
    fillInApproveLv2: json["fillInApproveLV2"],
    isWithdraw: json["isWithdraw"],
    commentManagerLv1: json["commentManagerLV1"],
    commentManagerLv2: json["commentManagerLV2"],
    name: json["name"],
    reasonName: json["reasonName"],
    idVendor: json["idVendor"],
    managerLv1Id: json["managerLV1Id"],
    managerLv1Name: json["managerLV1Name"],
    emailManagerLv1: json["emailManagerLV1"],
    managerLv2Id: json["managerLV2Id"],
    managerLv2Name: json["managerLV2Name"],
    emailManagerLv2: json["emailManagerLV2"],
    createDateText: json["createDateText"],
    startText: json["startText"],
    endText: json["endText"],
    managerLv1ApproveDateText: json["managerLV1ApproveDateText"],
    managerLv2ApproveDateText: json["managerLV2ApproveDateText"],
  );

  Map<String, dynamic> toJson() => {
    "idRequestTime": idRequestTime,
    "start": start?.toIso8601String(),
    "end": end?.toIso8601String(),
    "workDate": workDate?.toIso8601String(),
    "idRequestReason": idRequestReason,
    "idRequestType": idRequestType,
    "otherReason": otherReason,
    "idEmp": idEmp,
    "isManagerLV1Approve": isManagerLv1Approve,
    "isManagerLV2Approve": isManagerLv2Approve,
    "amountHours": amountHours,
    "xOT": xOt,
    "xOTHoliday": xOtHoliday,
    "xWorkingDailyHoliday": xWorkingDailyHoliday,
    "xWorkingMonthlyHoliday": xWorkingMonthlyHoliday,
    "isActive": isActive,
    "managerLV1ApproveBy": managerLv1ApproveBy,
    "managerLV1ApproveDate": managerLv1ApproveDate?.toIso8601String(),
    "managerLV2ApproveBy": managerLv2ApproveBy,
    "managerLV2ApproveDate": managerLv2ApproveDate,
    "createBy": createBy,
    "createDate": createDate?.toIso8601String(),
    "updateBy": updateBy,
    "updateDate": updateDate?.toIso8601String(),
    "isDoubleApproval": isDoubleApproval,
    "approvalLevel": approvalLevel,
    "fillInCreate": fillInCreate,
    "fillInApproveLV1": fillInApproveLv1,
    "fillInApproveLV2": fillInApproveLv2,
    "isWithdraw": isWithdraw,
    "commentManagerLV1": commentManagerLv1,
    "commentManagerLV2": commentManagerLv2,
    "name": name,
    "reasonName": reasonName,
    "idVendor": idVendor,
    "managerLV1Id": managerLv1Id,
    "managerLV1Name": managerLv1Name,
    "emailManagerLV1": emailManagerLv1,
    "managerLV2Id": managerLv2Id,
    "managerLV2Name": managerLv2Name,
    "emailManagerLV2": emailManagerLv2,
    "createDateText": createDateText,
    "startText": startText,
    "endText": endText,
    "managerLV1ApproveDateText": managerLv1ApproveDateText,
    "managerLV2ApproveDateText": managerLv2ApproveDateText,
  };
}
