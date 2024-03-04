part of 'leave_bloc.dart';

abstract class LeaveState extends Equatable {
  final List<String> leaveAuthList;
  final List<LeaveHistoryEntity> leaveHistoryData;
  final List<LeaveAuthorityEntity> leaveAuthorityData;
  final List<LeaveAuthWithUsedRemaining> leaveData;
  final List<double>? used;
  final List<double>? remaining;
  final List<DayCannotLeave> dayCannotLeave;
  final Map<String, List<double>> leaveKeyData;

  const LeaveState({
    required this.leaveHistoryData,
    required this.leaveAuthorityData,
    required this.used,
    required this.remaining,
    required this.leaveAuthList,
    required this.leaveKeyData,
    required this.leaveData,
    required this.dayCannotLeave,
  });
}

class LeaveInitial extends LeaveState {
  const LeaveInitial(
      {required super.leaveHistoryData,
      required super.leaveAuthorityData,
      required super.used,
      required super.remaining,
      required super.leaveAuthList,
      required super.leaveKeyData,
      required super.leaveData,
      required super.dayCannotLeave});

  @override
  List<Object> get props => [];
}

class LeaveLoading extends LeaveState {
  const LeaveLoading(
      {required super.leaveHistoryData,
      required super.leaveAuthorityData,
      required super.used,
      required super.remaining,
      required super.leaveAuthList,
      required super.leaveKeyData,
      required super.leaveData,
      required super.dayCannotLeave});

  @override
  List<Object?> get props => [];
}

class LeaveLoaded extends LeaveState {
  const LeaveLoaded(
      {required super.leaveHistoryData,
      required super.leaveAuthorityData,
      required super.used,
      required super.remaining,
      required super.leaveAuthList,
      required super.leaveKeyData,
      required super.leaveData,
      required super.dayCannotLeave});

  @override
  List<Object?> get props => [used, remaining];
}

class LeaveFailure extends LeaveState {
  final ErrorMessage error;

  const LeaveFailure(
      {required super.leaveHistoryData,
      required this.error,
      required super.leaveAuthorityData,
      required super.used,
      required super.remaining,
      required super.leaveAuthList,
      required super.leaveKeyData,
      required super.leaveData,
      required super.dayCannotLeave});

  @override
  List<Object?> get props => [error];
}

class LeaveResult extends LeaveState {
  final String leaveType;
  final DateTime startDay;
  final DateTime endDay;
  final String note;
  final double uses;
  final double remainNow;

  const LeaveResult({
    required this.leaveType,
    required this.startDay,
    required this.endDay,
    required this.note,
    required this.uses,
    required this.remainNow,
    required super.leaveHistoryData,
    required super.leaveAuthorityData,
    required super.used,
    required super.remaining,
    required super.leaveAuthList,
    required super.leaveKeyData,
    required super.leaveData,
    required super.dayCannotLeave,
  });

  @override
  List<Object?> get props => [leaveType, startDay, endDay, note, uses];
}
