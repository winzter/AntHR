import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/features/profile/user/domain/entity/profile_entity.dart';
import '../../domain/entities/entities.dart';
import '../../domain/use_cases/usecases.dart';

part 'timeline_event.dart';
part 'timeline_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  final GetAttendanceByDate getAttendanceByDate;
  final GetEvents getEvents;
  final SendTimeRequest sendTimeRequest;
  final GetTimeLineReasons getTimeLineReasons;
  final GetPayrollSettingTimeLine getPayrollSettingTimeLine;
  TimelineBloc({
    required this.getAttendanceByDate,
    required this.getTimeLineReasons,
    required this.getEvents,
    required this.sendTimeRequest,
    required this.getPayrollSettingTimeLine,
  }) : super( TimelineInitial()) {

    on<GetTimeLineData>((event, emit) async{
      List<TimeLineEntity> data = [];
      List<PayrollSettingTimeLine> payrollData = [];
      List<ReasonsTimeLineRequest> reasonsData = [];
      bool isErrorOccur = false;

      emit(state.copyWith(status: FetchStatus.fetching));
      String startDate = DateFormat("yyyy-MM-dd").format(event.startDate);
      String endDate = DateFormat("yyyy-MM-dd").format(event.endDate);

      var response = await getAttendanceByDate(startDate,endDate);
      var resPayroll = await getPayrollSettingTimeLine();
      var resReasons = await getTimeLineReasons(event.idCompany,event.idVendor);
      resReasons.fold((l) {
        emit(state.copyWith(status: FetchStatus.failed,error: l));
        isErrorOccur = true;
      },
              (r) => reasonsData = r);
      response.fold(
              (l){
                emit(state.copyWith(status: FetchStatus.failed,error: l));
                isErrorOccur = true;
              },
              (r) {data = [...r];});
      resPayroll.fold((l){
        emit(state.copyWith(status: FetchStatus.failed,error: l));
        isErrorOccur = true;
      },
              (r) => payrollData = [...r]);
      if(!isErrorOccur){
        emit(state.copyWith(
          status: FetchStatus.success,
          attendanceData: data,
          showingData: data.sublist(1,data.length-1),
          events: getEvents(data.sublist(1,data.length-1)),
          reasonData: reasonsData,
          payrollData: payrollData,
          currentTime: DateTime.now(),
        ));
      }
      else{
        emit(state.copyWith(
          status: FetchStatus.failed,
          error: state.error
        ));
      }

    });

    on<SendTimeRequestData>((event, emit) async{
      emit(state.copyWith(attendanceData: state.attendanceData, payrollData: state.payrollData,status: FetchStatus.fetching));
      var response = await sendTimeRequest(
        event.result,
        event.idEmployee,
        event.idRequestType,
        event.requestReason,
        event.otherReason,
        event.start,
        event.end,
        event.workEndDate,
        event.note,
        event.profileData
      );
      response.fold(
              (l) => emit(state.copyWith(
                status: FetchStatus.failed,
                error: l,
              )),
              (r) => emit(state.copyWith(
                status: FetchStatus.success,
              )));
    });
  }
}
