import 'package:equatable/equatable.dart';

class RequestTimeManager extends Equatable{
  final int? idRequestTime;
  final DateTime? start;
  final DateTime? end;
  final DateTime? workDate;
  final int? idRequestReason;
  final int? idRequestType;
  final String? otherReason;
  final int? idEmp;
  final dynamic isManagerLv1Approve;
  final dynamic isManagerLv2Approve;
  final double? amountHours;
  final double? xOt;
  final double? xOtHoliday;
  final double? xWorkingDailyHoliday;
  final double? xWorkingMonthlyHoliday;
  final int? isActive;
  final int? managerLv1ApproveBy;
  final dynamic managerLv1ApproveDate;
  final int? managerLv2ApproveBy;
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
  final String? requestReasonName;
  final int? managerLv1Id;
  final String? managerLv1Name;
  final String? emailManagerLv1;
  final int? managerLv2Id;
  final String? managerLv2Name;
  final String? emailManagerLv2;
  final String? employeeId;
  final String? firstname;
  final String? lastname;
  final int? idCompany;
  final int? idVendor;
  final int? idPositions;
  final String? positionsName;
  final dynamic idDepartment;
  final dynamic departmentName;
  final String? paymentTypeName;
  final String? paymentRound;
  final String? startText;
  final String? endText;
  final String? createDateText;
  final String? workDateText;

  const RequestTimeManager({
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
    this.requestReasonName,
    this.managerLv1Id,
    this.managerLv1Name,
    this.emailManagerLv1,
    this.managerLv2Id,
    this.managerLv2Name,
    this.emailManagerLv2,
    this.employeeId,
    this.firstname,
    this.lastname,
    this.idCompany,
    this.idVendor,
    this.idPositions,
    this.positionsName,
    this.idDepartment,
    this.departmentName,
    this.paymentTypeName,
    this.paymentRound,
    this.startText,
    this.endText,
    this.createDateText,
    this.workDateText,
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
    requestReasonName,
    managerLv1Id,
    managerLv1Name,
    emailManagerLv1,
    managerLv2Id,
    managerLv2Name,
    emailManagerLv2,
    employeeId,
    firstname,
    lastname,
    idCompany,
    idVendor,
    idPositions,
    positionsName,
    idDepartment,
    departmentName,
    paymentTypeName,
    paymentRound,
    startText,
    endText,
    createDateText,
    workDateText,
  ];
}
