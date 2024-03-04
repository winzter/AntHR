part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();
}

class GetLeaveHistoryData extends LeaveEvent{
  @override
  List<Object?> get props => [];
}

class GetAllLeaveData extends LeaveEvent{
  @override
  List<Object?> get props => [];

}

class DeleteLeaveHistoryData extends LeaveEvent{
  final LeaveHistoryEntity leaveHistory;
  final int index;
  const DeleteLeaveHistoryData({required this.leaveHistory,required this.index, });
  @override
  List<Object?> get props => [leaveHistory,index];

}

class SendLeaveRequestData extends LeaveEvent{
  final int idManager;
  final int? idHoliday;
  final int idEmployees;

  final String? managerEmail;
  final bool isFullDay;
  final String leaveType;
  final DateTime startDay;
  final DateTime endDay;
  final List<LeaveAuthorityEntity>? leaveAuth;
  final String note;
  final FilePickerResult? file;
  final double used;
  final double remaining;

  const SendLeaveRequestData(
      {
        required this.idManager,
        required this.idHoliday,
        required this.leaveAuth,
        required this.idEmployees,
        required this.isFullDay,
        required this.leaveType,
        required this.startDay,
        required this.endDay,
        required this.note,
        required this.file,
        required this.used,
        required this.remaining,
        required this.managerEmail,
      });

  @override
  List<Object?> get props => [
    idManager,
    idEmployees,
    idHoliday,
    isFullDay,
    leaveType,
    startDay,
    endDay,
    note,
    leaveAuth,
    used,
    managerEmail,
  ];
}

class GetDayCannotLeaveData extends LeaveEvent {
  final DateTime start;
  final DateTime end;

  const GetDayCannotLeaveData({
    required this.start,
    required this.end,
  });

  @override
  List<Object?> get props => [start, end];
}
