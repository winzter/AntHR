import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/features/attendance/domain/entities/attendance_entity.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/use_cases/usecases.dart';

part 'workingtime_individual_event.dart';
part 'workingtime_individual_state.dart';

class WorkingTimeIndividualBloc extends Bloc<WorkingTimeIndividualEvent, WorkingTimeIndividualState> {

  final GetEmployees getEmployees;
  final GetAttendanceEmpDate getAttendanceEmpDate;
  final GetReasonManager getReasonManager;
  final SendTimeRequestManager sendTimeRequestManager;

  Map<int,String> indexReasonType = {
    1:"ทำต่อเนื่องเร่งด่วน",
    2:"ทำงานกะในวันหยุด",
    3:"อบรม",
    4:"กิจกรรมอื่นๆ ของบริษัท",
    5:"ปฏิบัติงานภายนอก",
    6:"ลายนิ้วมือมีปัญหา/เครื่องสแกนนิ้วขัดข้อง",
    7:"เรียกตัวฉุกเฉิน",
    8:"อื่นๆ",
    9:"ทำงานเร่งด่วนช่วงพักเที่ยง",
    10:"StandBy On Call",

  };

  List<String> reasonData = [
    "ทำต่อเนื่องเร่งด่วน",
    "ทำงานกะในวันหยุด",
    "ทำงานเร่งด่วนช่วงพักเที่ยง",
    "StandBy On Call",
    "อบรม",
    "กิจกรรมอื่นๆ ของบริษัท",
    "ปฏิบัติงานภายนอก",
    "ลายนิ้วมือมีปัญหา/เครื่องสแกนนิ้วขัดข้อง",
    "เรียกตัวฉุกเฉิน",
    "อื่นๆ",
  ];

  WorkingTimeIndividualBloc({
    required this.getEmployees,
    required this.sendTimeRequestManager,
    required this.getAttendanceEmpDate,
    required this.getReasonManager
  }) :
        super(WorkingTimeIndividualInitial(empData: [], empAttendanceData: [], reasons: [])) {

    on<GetEmployeesData>((event, emit) async{
      List<EmployeesEntity> empData = [];

      emit(WorkingTimeIndividualLoading(
          empData: state.empData,
          empAttendanceData: state.empAttendanceData,
          reasons: reasonData));
      var res = await getEmployees();
      res.fold((l) => emit(WorkingTimeIndividualFailure(
          empData: state.empData,
          error: l,
          empAttendanceData: state.empAttendanceData,
          reasons: state.reasons)),
              (r) => emit(WorkingTimeIndividualLoaded(
                  empData: r,
                  empAttendanceData: state.empAttendanceData,
                  reasons: state.reasons,
                  showingData: [],
                  idEmp: null)));
    });

    on<GetAttendanceEmpDateData>((event, emit) async{
      emit(WorkingTimeIndividualLoading(
          empData: state.empData,
          empAttendanceData: state.empAttendanceData,
          reasons: state.reasons,));
      var res = await getAttendanceEmpDate(event.id,event.start,event.end);
      res.fold((l) => emit(WorkingTimeIndividualFailure(
          empData: state.empData,
          error: l,
          empAttendanceData: state.empAttendanceData,
          reasons: state.reasons)),
              (r) => emit(WorkingTimeIndividualLoaded(
                  empData: state.empData,
                  empAttendanceData: r,
                  reasons: reasonData,
                  showingData: r.sublist(
                      1,r.length-1),
                  idEmp: event.id)));
    });

    on<SendTimeRequestData>((event, emit) async{
      emit(WorkingTimeIndividualLoading(
          empData: state.empData,
          empAttendanceData: state.empAttendanceData,
          reasons: state.reasons));
      var response = await sendTimeRequestManager(
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
              (l) => emit(WorkingTimeIndividualFailure(error: l, reasons: state.reasons, empData: state.empData, empAttendanceData: state.empAttendanceData)),
              (r) => emit(SendTimeRequestSuccess(empData: state.empData, empAttendanceData: state.empAttendanceData, reasons: state.reasons)));
    });

  }
}
