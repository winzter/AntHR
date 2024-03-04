part of 'timeline_bloc.dart';

enum FetchStatus { fetching, success, failed, init }
class TimelineState extends Equatable {
  final List<TimeLineEntity> attendanceData;
  final List<PayrollSettingTimeLine>? payrollData;
  final List<TimeLineEntity> showingData;
  final Map<String, List<String>> events;
  final List<ReasonsTimeLineRequest> reasonData;
  final List<String> selectedEvents = [
    "ทำงานล่วงเวลา",
    "ขอรับรองเวลาทำงาน",
    "ขอลางาน",
    "ขาดงาน",
    "วันหยุดประจำปี"
  ];
  final ErrorMessage? error;
  final FetchStatus status;
  final DateTime? currentTime;

  TimelineState({
    this.attendanceData = const[],
    this.payrollData = const[],
    this.showingData = const[],
    this.events = const{},
    this.reasonData = const[],
    this.error,
    this.status = FetchStatus.init,
    this.currentTime,
  });
  TimelineState copyWith({
    List<ReasonsTimeLineRequest>? reasonData,
    List<PayrollSettingTimeLine>? payrollData,
    List<TimeLineEntity>? attendanceData,
    List<TimeLineEntity>? showingData,
    Map<String, List<String>>? events,
    ErrorMessage? error,
    FetchStatus? status,
    DateTime? currentTime,
  }) {
    return TimelineState(
      reasonData: reasonData??this.reasonData,
      payrollData: payrollData ?? this.payrollData,
      attendanceData: attendanceData ?? this.attendanceData,
      showingData: showingData ?? this.showingData,
      events: events ?? this.events,
      error: error ?? this.error,
      status: status ?? this.status,
      currentTime: currentTime ?? this.currentTime,
    );
  }
  @override
  List<Object?> get props => [
    attendanceData,
    reasonData,
    payrollData,
    showingData,
    events,
    error,
    status,
    currentTime,
  ];
}

class TimelineInitial extends TimelineState {
  TimelineInitial();

  @override
  List<Object> get props => [];
}
