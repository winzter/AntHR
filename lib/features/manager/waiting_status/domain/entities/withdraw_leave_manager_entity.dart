import 'package:equatable/equatable.dart';

class WithdrawLeaveManager extends Equatable{
  final int? idLeaveEmployeesWithdraw;
  final int? idLeave;
  final int? managerApprove;
  final int? isApprove;
  final DateTime? approveDate;
  final dynamic fillInCreate;
  final dynamic fillInApprove;
  final DateTime? createDate;
  final int? isActive;
  final dynamic commentManager;
  final int? idLeaveType;
  final String? name;
  final DateTime? start;
  final DateTime? end;
  final int? isFullDay;
  final String? managerName;
  final String? managerEmail;
  final String? firstname;
  final String? lastname;
  final String? positionsName;
  final String? startText;
  final String? endText;
  final String? createDateText;

 const WithdrawLeaveManager({
   this.idLeaveEmployeesWithdraw,
   this.idLeave,
   this.managerApprove,
   this.isApprove,
   this.approveDate,
   this.fillInCreate,
   this.fillInApprove,
   this.createDate,
   this.isActive,
   this.commentManager,
   this.idLeaveType,
   this.name,
   this.start,
   this.end,
   this.isFullDay,
   this.managerName,
   this.managerEmail,
   this.firstname,
   this.lastname,
   this.positionsName,
   this.startText,
   this.endText,
   this.createDateText,
  });

  @override
  List<Object?> get props => [
    idLeaveEmployeesWithdraw,
    idLeave,
    managerApprove,
    isApprove,
    approveDate,
    fillInCreate,
    fillInApprove,
    createDate,
    isActive,
    commentManager,
    idLeaveType,
    name,
    start,
    end,
    isFullDay,
    managerName,
    managerEmail,
    firstname,
    lastname,
    positionsName,
    startText,
    endText,
    createDateText,
  ];
}
