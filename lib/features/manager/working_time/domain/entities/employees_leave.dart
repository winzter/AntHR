import 'package:equatable/equatable.dart';

class EmployeesLeaveEntity extends Equatable{
  final int? idEmp;
  final String? firstname;
  final String? lastname;
  final String? name;
  final int? idLeave;
  final int? idLeaveType;
  final String? description;
  final DateTime? start;
  final DateTime? end;
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
  final String? positionsName;

  const EmployeesLeaveEntity({
    this.idEmp,
    this.firstname,
    this.lastname,
    this.name,
    this.idLeave,
    this.idLeaveType,
    this.description,
    this.start,
    this.end,
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
    this.positionsName,
  });

  @override
  List<Object?> get props => [
    idEmp,
    firstname,
    lastname,
    name,
    idLeave,
    idLeaveType,
    description,
    start,
    end,
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
    positionsName,
  ];

}
