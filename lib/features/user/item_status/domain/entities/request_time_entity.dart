import 'package:equatable/equatable.dart';

class RequestTimeEntity extends Equatable {
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
  final int? amountHours;
  final int? xOt;
  final int? xOtHoliday;
  final int? xWorkingDailyHoliday;
  final int? xWorkingMonthlyHoliday;
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
  final String? reasonName;
  final int? idVendor;
  final int? managerLv1Id;
  final String? managerLv1Name;
  final String? emailManagerLv1;
  final int? managerLv2Id;
  final String? managerLv2Name;
  final String? emailManagerLv2;
  final String? startText;
  final String? endText;
  final String? createDateText;
  final String? workDateText;
  final dynamic managerLv1ApproveDateText;
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
    this.startText,
    this.endText,
    this.createDateText,
    this.workDateText,
    this.managerLv1ApproveDateText,
    this.managerLv2ApproveDateText,
  });

  @override
  List<Object?> get props => [];
}
