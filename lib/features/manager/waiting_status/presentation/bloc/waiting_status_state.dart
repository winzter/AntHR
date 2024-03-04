part of 'waiting_status_bloc.dart';

abstract class WaitingStatusState extends Equatable {
  final List<RequestTimeManager> requestTimeData;
  final List<LeaveRequestManager> leaveRequestData;
  final List<LeaveRequestManager> leaveNotApproveData;
  final List<WithdrawLeaveManager> withdrawLeaveData;
  final List<PayrollSetting> payrollSetting;
  final List<RequestTimeManager> dataOt;
  final List<RequestTimeManager> dataNotApproveOt;
  final List<RequestTimeManager> dataRequestTime;
  final List<RequestTimeManager> dataNotApproveRequestTime;

  const WaitingStatusState(
      {required this.requestTimeData,
      required this.leaveRequestData,
      required this.payrollSetting,
      required this.dataOt,
      required this.dataNotApproveOt,
      required this.leaveNotApproveData,
      required this.dataRequestTime,
      required this.dataNotApproveRequestTime,
      required this.withdrawLeaveData});
}

class WaitingStatusInitial extends WaitingStatusState {
  const WaitingStatusInitial(
      {required super.requestTimeData,
      required super.leaveRequestData,
      required super.payrollSetting,
      required super.dataOt,
      required super.dataNotApproveOt,
      required super.leaveNotApproveData,
      required super.dataRequestTime,
      required super.dataNotApproveRequestTime,
      required super.withdrawLeaveData});

  @override
  List<Object> get props => [];
}

class WaitingStatusLoaded extends WaitingStatusState {
  const WaitingStatusLoaded(
      {required super.requestTimeData,
      required super.leaveRequestData,
      required super.payrollSetting,
      required super.dataOt,
      required super.dataNotApproveOt,
      required super.leaveNotApproveData,
      required super.dataRequestTime,
      required super.dataNotApproveRequestTime,
      required super.withdrawLeaveData});

  @override
  List<Object?> get props =>
      [requestTimeData, leaveRequestData, withdrawLeaveData, payrollSetting];
}

class WaitingStatusLoading extends WaitingStatusState {
  const WaitingStatusLoading(
      {required super.requestTimeData,
      required super.leaveRequestData,
      required super.payrollSetting,
      required super.dataOt,
      required super.dataNotApproveOt,
      required super.leaveNotApproveData,
      required super.dataRequestTime,
      required super.dataNotApproveRequestTime,
      required super.withdrawLeaveData});

  @override
  List<Object?> get props => [];
}

class WaitingStatusFailure extends WaitingStatusState {
  final ErrorMessage error;

  const WaitingStatusFailure(
      {required this.error,
      required super.requestTimeData,
      required super.leaveRequestData,
      required super.payrollSetting,
      required super.dataOt,
      required super.dataNotApproveOt,
      required super.leaveNotApproveData,
      required super.dataRequestTime,
      required super.dataNotApproveRequestTime,
      required super.withdrawLeaveData});

  @override
  List<Object?> get props => [error];
}

class WaitingStatusSendRequestSuccess extends WaitingStatusState {
  const WaitingStatusSendRequestSuccess(
      {
      required super.requestTimeData,
      required super.leaveRequestData,
      required super.leaveNotApproveData,
      required super.withdrawLeaveData,
      required super.payrollSetting,
      required super.dataOt,
      required super.dataNotApproveOt,
      required super.dataRequestTime,
      required super.dataNotApproveRequestTime});

  @override
  List<Object?> get props => [];
}

class WaitingStatusSendRequestFailed extends WaitingStatusState {
  const WaitingStatusSendRequestFailed(
      {
      required super.requestTimeData,
      required super.leaveRequestData,
      required super.leaveNotApproveData,
      required super.withdrawLeaveData,
      required super.payrollSetting,
      required super.dataOt,
      required super.dataNotApproveOt,
      required super.dataRequestTime,
      required super.dataNotApproveRequestTime});

  @override
  List<Object?> get props => [];
}
