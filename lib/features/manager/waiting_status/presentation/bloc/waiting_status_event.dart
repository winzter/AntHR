part of 'waiting_status_bloc.dart';

abstract class WaitingStatusEvent extends Equatable {
  const WaitingStatusEvent();
}

class GetWaitingStatus extends WaitingStatusEvent{
  final String? start;
  final String? end;
  final ManagerProfileEntity managerData;
  const GetWaitingStatus({required this.start , required this.end,required this.managerData});

  @override
  List<Object?> get props => [
    start,
    end,
    managerData
  ];
}

class IsApproveLeaveWaitingStatus extends WaitingStatusEvent{
  final List<int> indexes;
  final List<LeaveRequestManager> leaveRequestLists;
  final List<WithdrawLeaveManager> withdrawLeaveRequestLists;
  final List<int> idLeaveEmployeesWithdraw;
  final int isApprove;
  final String? comment;

  const IsApproveLeaveWaitingStatus({
    required this.indexes,
    required this.idLeaveEmployeesWithdraw,
    required this.leaveRequestLists,
    required this.withdrawLeaveRequestLists,
    required this.isApprove,
    required this.comment
});
  @override
  List<Object?> get props => [
    idLeaveEmployeesWithdraw,
    isApprove,
    comment,
    leaveRequestLists,
    withdrawLeaveRequestLists
  ];
}

class IsApproveRequestTimeWaitingStatus extends WaitingStatusEvent{
  final int idManager;
  final List<int> indexes;
  final String type;
  final String commentManagerLV1;
  final String commentManagerLV2;
  final int? isManagerLV1Approve;


  const IsApproveRequestTimeWaitingStatus({
    required this.indexes,
    required this.idManager,
    required this.type,
    required this.commentManagerLV1,
    required this.commentManagerLV2,
    required this.isManagerLV1Approve,
  });
  @override
  List<Object?> get props => [
    type,
    commentManagerLV1,
    commentManagerLV2,
    isManagerLV1Approve,
  ];
}

