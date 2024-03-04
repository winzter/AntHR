import 'package:equatable/equatable.dart';

class LeaveHistoryEntity extends Equatable{
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
  final DateTime? approveDate;
  final int? isApprove;
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
  final String? managerName;
  final String? managerEmail;
  final String? startText;
  final String? endText;
  final String? createLeaveText;

  const LeaveHistoryEntity({
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
    this.managerName,
    this.managerEmail,
    this.startText,
    this.endText,
    this.createLeaveText,
  });

  @override
  List<Object?> get props => [];
}