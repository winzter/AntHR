import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/error/failures.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/use_cases/usecases.dart';
part 'working_time_event.dart';
part 'working_time_state.dart';

class WorkingTimeBloc extends Bloc<WorkingTimeEvent, WorkingTimeState> {

  final GetEmployeesAttendance getEmployeesAttendance;
  final GetEmployeesLeave getEmployeesLeave;
  final GetEmployees getEmployees;

  WorkingTimeBloc({
    required this.getEmployeesAttendance,
    required this.getEmployeesLeave,
    required this.getEmployees
  }) : super(WorkingTimeInitial(
      empAttendanceCheckIn: const [],
      empLeave: const [],
      empAttendanceCheckOut: const [],
      empData: const [])) {

    List<EmployeesLeaveEntity> empLeave = [];
    List<EmployeesAttendanceEntity> empAttendanceCheckIn = [];
    List<EmployeesAttendanceEntity> empAttendance = [];
    List<EmployeesAttendanceEntity> empAttendanceCheckOut = [];

    on<GetWorkingTimeData>((event, emit) async{
      log("1");
      emit(WorkingTimeLoading(
          empAttendanceCheckIn: state.empAttendanceCheckIn,
          empLeave: state.empLeave,
          empAttendanceCheckOut: state.empAttendanceCheckOut,
          empData: const []));
      var resEmployeesAttendance = await getEmployeesAttendance(event.start);
      resEmployeesAttendance.fold(
              (l) => emit(WorkingTimeFailure(
                  error: l,
                  empAttendanceCheckIn: state.empAttendanceCheckIn,
                  empLeave: state.empLeave,
                  empAttendanceCheckOut: state.empAttendanceCheckOut,
                  empData: state.empData)),
              (r)=> empAttendance = r);
      log("2");
      var resEmployeesLeave = await getEmployeesLeave(event.start);
      resEmployeesLeave.fold(
              (l) => emit(WorkingTimeFailure(
                  error: l,
                  empAttendanceCheckIn: state.empAttendanceCheckIn,
                  empLeave: state.empLeave,
                  empAttendanceCheckOut: state.empAttendanceCheckOut,
                  empData: state.empData)),
              (r)=> empLeave = r);
      for(var data in empAttendance){
        if(data.isCheckIn! == 0){
          empAttendanceCheckOut.add(data);
        }else if(data.isCheckIn == 1){
          empAttendanceCheckIn.add(data);
        }
      }
      var resEmpData = await getEmployees();
      resEmpData.fold(
              (l) => emit(WorkingTimeFailure(
                  error: l,
                  empAttendanceCheckIn: state.empAttendanceCheckIn,
                  empLeave: state.empLeave,
                  empAttendanceCheckOut: state.empAttendanceCheckOut,
                  empData: state.empData)),
              (r) => emit(WorkingTimeLoaded(
                  empAttendanceCheckIn: empAttendanceCheckIn,
                  empLeave: empLeave,
                  empAttendanceCheckOut: empAttendanceCheckOut,
                  empData: r)));

    });

    on<ShowSomeEmpAttendance> ((event,emit){
      emit(WorkingTimeLoading(
          empAttendanceCheckIn: const [],
          empLeave: const [],
          empAttendanceCheckOut: const [],
          empData: state.empData));

      if(event.empId != null){
        List<EmployeesAttendanceEntity> eachEmpCheckIn = [...empAttendanceCheckIn.where((e) => e.idEmp == event.empId)];
        List<EmployeesAttendanceEntity> eachEmpCheckOut = [...empAttendanceCheckOut.where((e) => e.idEmp == event.empId)];
        List<EmployeesLeaveEntity>  eachDataLeave = [...empLeave.where((e) => e.idEmp == event.empId)];
        emit(WorkingTimeLoaded(
            empAttendanceCheckIn: eachEmpCheckIn,
            empLeave: eachDataLeave,
            empAttendanceCheckOut: eachEmpCheckOut,
            empData: state.empData));
      }else{
        emit(WorkingTimeLoaded(
            empAttendanceCheckIn: empAttendanceCheckIn,
            empLeave: empLeave,
            empAttendanceCheckOut: empAttendanceCheckOut,
            empData: state.empData));
      }
    });
  }
}
