import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../../core/error/failures.dart';
import '../../data/data_sources/leave_request.dart';
import '../../domain/entities/entities.dart';
import '../../domain/use_cases/use_cases.dart';

part 'leave_event.dart';

part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final GetLeaveHistory getLeaveHistory;
  final GetLeaveAuthority getLeaveAuthority;
  final DeleteLeaveHistory deleteLeaveHistory;
  final GetDayCannotLeave getDayCannotLeave;
  final SendLeaveRequest sendLeaveRequest;

  // final SendLeaveRequest sendLeaveRequest;
  LeaveBloc({
    required this.getLeaveHistory,
    required this.sendLeaveRequest,
    required this.getDayCannotLeave,
    required this.deleteLeaveHistory,
    required this.getLeaveAuthority,
  }) : super(const LeaveInitial(
            leaveHistoryData: [],
            leaveAuthorityData: [],
            leaveAuthList: [],
            used: [],
            remaining: [],
            leaveKeyData: {},
            leaveData: [],
            dayCannotLeave: [])) {
    on<GetLeaveHistoryData>((event, emit) async {
      emit(LeaveLoading(
        leaveHistoryData: state.leaveHistoryData,
        leaveAuthorityData: state.leaveAuthorityData,
        used: state.used,
        remaining: state.remaining,
        leaveAuthList: state.leaveAuthList,
        leaveKeyData: state.leaveKeyData,
        leaveData: state.leaveData,
        dayCannotLeave: state.dayCannotLeave,
      ));
      var resLeave = await getLeaveHistory();
      resLeave.fold(
          (l) => emit(LeaveFailure(
              leaveHistoryData: const [],
              error: l,
              leaveAuthorityData: const [],
              used: state.used,
              leaveKeyData: state.leaveKeyData,
              remaining: state.remaining,
              leaveAuthList: const [],
              leaveData: state.leaveData,
              dayCannotLeave: state.dayCannotLeave)),
          (r) => emit(LeaveLoaded(
                leaveHistoryData: r,
                leaveAuthorityData: state.leaveAuthorityData,
                used: state.used,
                remaining: state.remaining,
                leaveAuthList: const [],
                leaveKeyData: state.leaveKeyData,
                leaveData: state.leaveData,
                dayCannotLeave: state.dayCannotLeave,
              )));
    });

    on<DeleteLeaveHistoryData>((event, emit) async {
      List<LeaveHistoryEntity> leaveHistory = state.leaveHistoryData;
      emit(LeaveLoading(
        leaveHistoryData: state.leaveHistoryData,
        leaveAuthorityData: const [],
        used: state.used,
        remaining: state.remaining,
        leaveAuthList: state.leaveAuthList,
        leaveKeyData: state.leaveKeyData,
        leaveData: state.leaveData,
        dayCannotLeave: state.dayCannotLeave,
      ));
      var response = await deleteLeaveHistory(event.leaveHistory.idLeave!);
      response.fold(
          (l) => emit(LeaveFailure(
              leaveHistoryData: state.leaveHistoryData,
              error: l,
              leaveAuthorityData: state.leaveAuthorityData,
              used: state.used,
              remaining: state.remaining,
              leaveAuthList: state.leaveAuthList,
              leaveKeyData: state.leaveKeyData,
              leaveData: state.leaveData,
              dayCannotLeave: state.dayCannotLeave)), (r) {
        leaveHistory.removeAt(event.index);
        emit(LeaveLoaded(
            leaveHistoryData: leaveHistory,
            leaveAuthorityData: state.leaveAuthorityData,
            used: state.used,
            remaining: state.remaining,
            leaveAuthList: state.leaveAuthList,
            leaveKeyData: state.leaveKeyData,
            leaveData: state.leaveData,
            dayCannotLeave: state.dayCannotLeave));
      });
    });

    on<GetAllLeaveData>((event, emit) async {
      List<LeaveHistoryEntity> leaveHistory = state.leaveHistoryData;
      List<LeaveAuthorityEntity> leaveAuthority = state.leaveAuthorityData;
      List<double> used = [];
      List<double> remaining = [];
      List<LeaveAuthWithUsedRemaining> leaveData = [];
      Map<String, List<double>> leaveKeyData = {};
      double usedSum = 0;
      double remainingSum = 0;
      emit(LeaveLoading(
          leaveHistoryData: state.leaveHistoryData,
          leaveAuthorityData: state.leaveAuthorityData,
          used: state.used,
          remaining: state.remaining,
          leaveAuthList: state.leaveAuthList,
          leaveKeyData: state.leaveKeyData,
          leaveData: state.leaveData,
          dayCannotLeave: state.dayCannotLeave));
      var resLeaveHistory = await getLeaveHistory();
      var resLeaveAuthority = await getLeaveAuthority();
      resLeaveHistory.fold(
          (l) => emit(LeaveFailure(
              leaveHistoryData: state.leaveHistoryData,
              error: l,
              leaveAuthorityData: state.leaveAuthorityData,
              used: state.used,
              remaining: state.remaining,
              leaveAuthList: state.leaveAuthList,
              leaveKeyData: state.leaveKeyData,
              leaveData: state.leaveData,
              dayCannotLeave: state.dayCannotLeave)),
          (r) => leaveHistory = r);
      resLeaveAuthority.fold(
          (l) => emit(LeaveFailure(
              leaveHistoryData: state.leaveHistoryData,
              error: l,
              leaveAuthorityData: state.leaveAuthorityData,
              used: state.used,
              remaining: state.remaining,
              leaveAuthList: state.leaveAuthList,
              leaveKeyData: state.leaveKeyData,
              leaveData: state.leaveData,
              dayCannotLeave: state.dayCannotLeave)),
          (r) => leaveAuthority = r);
      // for(int i=0;i<leaveAuthority.length;i++){
      //   usedSum = 0;
      //   remainingSum = 0;
      //   for(int j=0;j<leaveHistory.length;j++){
      //     if(leaveAuthority[i].idLeaveType == leaveHistory[j].idLeaveType
      //         && leaveHistory[j].isApprove != 0){
      //       if(leaveHistory[j].used == null){
      //         usedSum = 999;
      //         break;
      //       }else{
      //         usedSum+=leaveHistory[j].used!;
      //       }
      //     }
      //   }
      //   leaveAuthority[i].leaveValue == null? remainingSum = 999:
      //   remainingSum = leaveAuthority[i].leaveValue! - usedSum;
      //   used.add(usedSum);
      //   remaining.add(remainingSum);
      // }
      for (int i = 0; i < leaveAuthority.length; i++) {
        usedSum = 0;
        remainingSum = 0;
        for (int j = 0; j < leaveHistory.length; j++) {
          if (leaveAuthority[i].idLeaveType == leaveHistory[j].idLeaveType &&
              leaveHistory[j].isApprove != 0) {
            if (leaveHistory[j].used == null) {
              usedSum = 999;
              break;
            } else {
              usedSum += leaveHistory[j].used!;
            }
          }
        }
        leaveAuthority[i].leaveValue == null
            ? remainingSum = 999
            : remainingSum = leaveAuthority[i].leaveValue! - usedSum;
        leaveData.add(LeaveAuthWithUsedRemaining(
            leaveAuth: leaveAuthority[i],
            used: usedSum,
            remaining: remainingSum,
            name: leaveAuthority[i].name!));
        leaveKeyData[leaveAuthority[i].name!] = [usedSum, remainingSum];
        // used.add(usedSum);
        // remaining.add(remainingSum);
      }
      emit(LeaveLoaded(
          leaveHistoryData: leaveHistory,
          leaveAuthorityData: leaveAuthority,
          used: used,
          remaining: remaining,
          leaveAuthList: leaveAuthority
              .map((e) => e.name)
              .where((name) => name != null)
              .toList()
              .cast<String>(),
          leaveKeyData: leaveKeyData,
          leaveData: leaveData,
          dayCannotLeave: state.dayCannotLeave));
    });
    on<GetDayCannotLeaveData>((event, emit) async {
      emit(LeaveLoading(
        leaveHistoryData: state.leaveHistoryData,
        leaveAuthorityData: state.leaveAuthorityData,
        // used: state.used,
        // remaining: state.remaining,
        leaveAuthList: state.leaveAuthList,
        leaveData: state.leaveData,
        dayCannotLeave: state.dayCannotLeave,
        leaveKeyData: state.leaveKeyData,
        used: state.used,
        remaining: state.remaining,
      ));
      var resLeave = await getDayCannotLeave(event.start, event.end);
      resLeave.fold(
          (l) => emit(LeaveFailure(
              leaveHistoryData: const [],
              error: l,
              leaveAuthorityData: const [],
              used: state.used,
              remaining: state.remaining,
              leaveAuthList: const [],
              leaveData: state.leaveData,
              dayCannotLeave: state.dayCannotLeave,
              leaveKeyData: state.leaveKeyData)),
          (r) => emit(LeaveLoaded(
                leaveHistoryData: state.leaveHistoryData,
                leaveAuthorityData: state.leaveAuthorityData,
                used: state.used,
                remaining: state.remaining,
                leaveAuthList: const [],
                leaveData: state.leaveData,
                dayCannotLeave: r,
                leaveKeyData: state.leaveKeyData,
              )));
    });

    on<SendLeaveRequestData>((event,emit) async{
      LeaveRequest data;
      double leaveQuota= event.leaveAuth!.firstWhere((element) => element.name == event.leaveType).leaveValue!.toDouble();
      emit(LeaveLoading(
          leaveHistoryData: state.leaveHistoryData,
          leaveAuthorityData: state.leaveAuthorityData,
          used: state.used,
          remaining: state.remaining,
          leaveAuthList: state.leaveAuthList,
          leaveKeyData: state.leaveKeyData,
          leaveData: state.leaveData,
          dayCannotLeave: state.dayCannotLeave));
      data = LeaveRequest(
          idLeaveType: event.leaveAuth!.firstWhere((element) => element.name == event.leaveType).idLeaveType.toString(),
          leaveName: event.leaveType,
          description: event.note,
          start: event.startDay,
          end: event.endDay,
          idEmp: event.idEmployees,
          used: event.used,
          quota: leaveQuota,
          balance: leaveQuota - event.used,
          remaining: event.remaining,
          idManagerEmployee: event.idManager,
          isApprove: null,
          isFullDay: event.isFullDay?1:0,
          isActive: 1,
          idHoliday: event.idHoliday,
          file: null,
          managerLV1Email: event.managerEmail);
      final result = await sendLeaveRequest(data);
      result.fold(
              (l) => emit(LeaveFailure(
                  leaveHistoryData: state.leaveHistoryData,
                  error: l,
                  leaveAuthorityData: state.leaveAuthorityData,
                  used: state.used,
                  remaining: state.remaining,
                  leaveAuthList: state.leaveAuthList,
                  leaveKeyData: state.leaveKeyData,
                  leaveData: state.leaveData,
                  dayCannotLeave: state.dayCannotLeave,
              ),),
              (r) => emit(LeaveResult(
                leaveType: event.leaveType,
                startDay: event.startDay,
                endDay: event.endDay,
                note: event.note,
                leaveHistoryData: state.leaveHistoryData,
                leaveAuthorityData: state.leaveAuthorityData,
                used: state.used,
                remaining: state.remaining,
                leaveAuthList: state.leaveAuthList,
                uses: event.used,
                remainNow: event.remaining,
                leaveKeyData: state.leaveKeyData,
                leaveData: state.leaveData,
                dayCannotLeave: state.dayCannotLeave,
          )));
    });
  }
}
