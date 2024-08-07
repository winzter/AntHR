part of 'timeline_bloc.dart';

abstract class TimelineEvent extends Equatable {
  const TimelineEvent();
}

class GetTimeLineData extends TimelineEvent{
  final DateTime startDate;
  final int idCompany;
  final int idVendor;
  final DateTime endDate;

  const GetTimeLineData({
    required this.startDate,
    required this.endDate,
    required this.idCompany,
    required this.idVendor,
  });
  @override
  List<Object?> get props => [startDate,endDate,idVendor,idCompany,];
}

class CalculateOverTime extends TimelineEvent{
  final String requestType;
  final String note;
  final String reasonType;
  final DateTime start;
  final DateTime end;
  final int index;
  final List<TimeLineEntity> attendanceData;
  final int idPaymentType;

  const CalculateOverTime({
    required this.note,
    required this.requestType,
    required this.reasonType,
    required this.start,
    required this.end,
    required this.index,
    required this.attendanceData,
    required this.idPaymentType,
  });
  @override
  List<Object?> get props =>
      [
        note,
        requestType,
        reasonType,
        start,
        end,
        index,
        attendanceData,
        idPaymentType
      ];
}

class SendTimeRequestData extends TimelineEvent{
  final CalculateTimeEntity result;
  final int idEmployee;
  final int idRequestType;
  final int requestReason;
  final String otherReason;
  final DateTime start;
  final DateTime end;
  final DateTime workEndDate;
  final String note;
  final ProfileEntity profileData;

  const SendTimeRequestData({
    required this.result,
    required this.idEmployee,
    required this.idRequestType,
    required this.requestReason,
    required this.otherReason,
    required this.start,
    required this.end,
    required this.workEndDate,
    required this.note,
    required this.profileData,
  });
  @override
  List<Object?> get props => [
    result,
    idEmployee,
    idRequestType,
    requestReason,
    otherReason,
    start,
    end,
    workEndDate,
    note,
    profileData
  ];
}
