import 'package:equatable/equatable.dart';

class LeaveRequestManager extends Equatable{
  final int? idLeave;
  final int? idLeaveType;
  final String? description;
  final DateTime? start;
  final DateTime? end;
  final int? idEmp;
  final double? used;
  final int? quota;
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
  final String? firstname;
  final String? lastname;
  final String? positionsName;
  final dynamic departmentName;
  final String? startText;
  final String? endText;
  final dynamic approveDateText;
  final String? createLeaveText;

  const LeaveRequestManager({
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
    this.firstname,
    this.lastname,
    this.positionsName,
    this.departmentName,
    this.startText,
    this.endText,
    this.approveDateText,
    this.createLeaveText,
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
    firstname,
    lastname,
    positionsName,
    departmentName,
    startText,
    endText,
    approveDateText,
    createLeaveText,
  ];
}
