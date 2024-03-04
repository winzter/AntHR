import 'package:anthr/features/user/summary_shfit_ot/data/data_sources/remote/shift_ot_remote_datasource.dart';
import 'package:anthr/features/user/summary_shfit_ot/data/repositories/summary_shift_ot_repository_impl.dart';
import 'package:anthr/features/user/summary_shfit_ot/domain/repositories/summary_shift_ot_repository.dart';
import 'package:anthr/features/user/timeline/data/data_sources/remote/attendance_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'core/features/login/data/data_sources/remote/login_api.dart';
import 'core/features/login/data/repositories/login_repository_impl.dart';
import 'core/features/login/domain/repositories/login_repository.dart';
import 'core/features/login/domain/use_cases/login_usecase.dart';
import 'core/features/login/presentation/bloc/login_bloc.dart';
import 'core/features/profile/user/data/datasource/remote/profile_remote_data_source.dart';
import 'core/features/profile/user/data/repository/profile_repository_impl.dart';
import 'core/features/profile/user/domain/repository/profile_repository.dart';
import 'core/features/profile/user/domain/usecase/get_profile.dart';
import 'core/features/profile/user/presentation/provider/profile_provider.dart';
import 'features/manager/overview/data/data_sources/remote/overview_remote_data_source.dart';
import 'features/manager/overview/data/repositories/overview_repositories_impl.dart';
import 'features/manager/overview/domain/repositories/overview_repository.dart';
import 'features/manager/overview/domain/use_cases/use_cases.dart';
import 'features/manager/overview/presentation/bloc/overview_bloc.dart';
import 'features/manager/waiting_status/data/data_sources/remote/waiting_status_remote_datasource.dart';
import 'features/manager/waiting_status/data/repositories/wait_status_repository_impl.dart';
import 'features/manager/waiting_status/domain/repositories/waiting_status_repository.dart';
import 'features/manager/waiting_status/domain/use_cases/usecases.dart';
import 'features/manager/waiting_status/presentation/bloc/waiting_status_bloc.dart';
import 'features/manager/working_time/data/data_sources/remote/working_time_remote_datasource.dart';
import 'features/manager/working_time/data/repositories/working_time_repository_impl.dart';
import 'features/manager/working_time/domain/repositories/working_time_repository.dart';
import 'features/manager/working_time/domain/use_cases/usecases.dart';
import 'features/manager/working_time/presentation/bloc/daily_detail_bloc/working_time_bloc.dart';
import 'features/manager/working_time/presentation/bloc/individual_detail/workingtime_individual_bloc.dart';
import 'features/user/edit_profile/data/data_sources/remote/edit_profile_remote_data_source.dart';
import 'features/user/edit_profile/data/repositories/profile_repository_impl.dart';
import 'features/user/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'features/user/edit_profile/domain/usecases/use_cases.dart';
import 'features/user/gps/data/data_sources/remote/gps_remote_data_source.dart';
import 'features/user/gps/data/repositories/gps_repository_impl.dart';
import 'features/user/gps/domain/repositories/gps_repository.dart';
import 'features/user/gps/domain/use_cases/usecases.dart';
import 'features/user/gps/presentation/bloc/gps_bloc.dart';
import 'features/user/item_status/data/data_sources/remote/item_status_remote_data_source.dart';
import 'features/user/item_status/data/repositories/item_status_repository_impl.dart';
import 'features/user/item_status/domain/repositories/item_status_repository.dart';
import 'features/user/item_status/domain/usecases/use_cases.dart';
import 'features/user/item_status/presentation/bloc/item_status_bloc.dart';
import 'features/user/leave/data/data_sources/remote/leave_remote_data_source.dart';
import 'features/user/leave/data/repositories/leave_repository_impl.dart';
import 'features/user/leave/domain/repositories/leave_repositories.dart';
import 'features/user/leave/domain/use_cases/use_cases.dart';
import 'features/user/leave/presentation/bloc/leave_bloc.dart';
import 'features/user/payslip/data/data_sources/remote/payslip_remote_data_source.dart';
import 'features/user/payslip/data/repositories/payslip_repository_impl.dart';
import 'features/user/payslip/domain/repositories/payslip_repository.dart';
import 'features/user/payslip/domain/usecases/get_payslip.dart';
import 'features/user/payslip/presentation/provider/payslip_provider.dart';
import 'features/user/summary_shfit_ot/domain/use_cases/getSummaryShiftAndOt.dart';
import 'features/user/summary_shfit_ot/presentation/bloc/shift_ot_bloc.dart';
import 'features/user/timeline/data/repositories/attendance_repository_impl.dart';
import 'features/user/timeline/domain/repositories/attendance_repository.dart';
import 'features/user/timeline/domain/use_cases/usecases.dart';
import 'features/user/timeline/presentation/bloc/timeline_bloc.dart';
import 'features/user/travelling/presentation/bloc/LocationBloc_bloc.dart';
import 'features/user/working_record/presentation/bloc/WorkRecord_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async{
  
  //! Provider
  sl.registerFactory(() => GetPayslipProvider(getPayslip: sl()));
  sl.registerFactory(() => ProfileProvider(getProfile: sl()));

  //! BLoC
    // * Login
  sl.registerFactory(() => LoginBloc(loginUseCase: sl(),));

    // * TimeLine
  sl.registerFactory(() => TimelineBloc(
    getAttendanceByDate: sl(),
    getEvents: sl(),
    sendTimeRequest: sl(),
    getPayrollSettingTimeLine: sl(),
    getTimeLineReasons: sl(),
  ));
    // * GPS
  sl.registerFactory(() => GpsBloc(getLocation: sl(), sendLocation: sl()));

    // * Leave
  sl.registerFactory(() => LeaveBloc(
      getLeaveHistory: sl(),
      getLeaveAuthority: sl(),
      deleteLeaveHistory: sl(),
      getDayCannotLeave: sl(),
      sendLeaveRequest: sl()));

    // * ItemStatus
  sl.registerFactory(() => ItemStatusBloc(
      getLeaveData: sl(),
      getRequestTimeData: sl(),
      getWithdraw: sl(),
      getPayrollSetting: sl(),
      deleteItem: sl()));

    // * Summary Shift And OT
  sl.registerFactory(() => ShiftOtBloc(
      getShiftAndOT: sl()));

    // * Travelling
  sl.registerFactory(() => LocationBloc());

    // * Work Record
  sl.registerFactory(() => WorkRecordBloc());

  // * Manager
    // ! ManagerWaitingStatus
  sl.registerFactory(() => WaitingStatusBloc(
      getLeaveRequestManager: sl(),
      getRequestTimeManager: sl(),
      getWithdrawLeaveManager: sl(),
      getPayrollSettingManager: sl(),
      isLeaveApprove: sl(),
      isRequestApprove: sl()));



    // ! ManagerWorkingTime
  sl.registerFactory(() => WorkingTimeBloc(
      getEmployeesAttendance: sl(),
      getEmployeesLeave: sl(),
      getEmployees: sl()));
  sl.registerFactory(() => WorkingTimeIndividualBloc(
      getEmployees: sl(),
      getAttendanceEmpDate: sl(),
      getReasonManager: sl(),
      sendTimeRequestManager: sl()));

  // ! ManagerOverview
  sl.registerFactory(() => OverviewBloc(
    getOverview: sl(),
    getDepartment: sl(),
    getOverTime: sl(),
    getWorkingTime: sl(),
    getCost: sl(),
  ));

  //! Use case
    // * Login Use Cases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));

    // * ShiftOT Use Cases
  sl.registerLazySingleton(() => GetSummaryShiftAndOt(repository: sl()));

    // * TimeLine Use Cases
  sl.registerLazySingleton(() => GetAttendanceByDate(repository: sl()));
  sl.registerLazySingleton(() => GetEvents(repository: sl()));
  sl.registerLazySingleton(() => SendTimeRequest(repository: sl()));
  sl.registerLazySingleton(() => GetPayrollSettingTimeLine(repository: sl()));
  sl.registerLazySingleton(() => GetTimeLineReasons(repository: sl()));

    // * ItemStatus Use Cases
  sl.registerLazySingleton(() => GetLeaveData(repository: sl()));
  sl.registerLazySingleton(() => GetRequestTimeData(repository: sl()));
  sl.registerLazySingleton(() => GetWithdraw(repository: sl()));
  sl.registerLazySingleton(() => GetPayrollSetting(repository: sl()));
  sl.registerLazySingleton(() => DeleteItem(repository: sl()));

    // * Payslip Use Cases
  sl.registerFactory(() => GetPayslip(sl()));

    // * Profile Use Cases
  sl.registerFactory(() => GetProfile(sl()));

    // * Edit Profile Use Cases
  sl.registerFactory(() => SendEditPhoneNumber(sl()));
  sl.registerFactory(() => SendEditAddress(sl()));
  sl.registerFactory(() => SendEditEmergencyContract(sl()));

    // * GPS Use Cases
  sl.registerLazySingleton(() => GetLocation(repository: sl()));
  sl.registerLazySingleton(() => SendLocation(repository: sl()));

    // * Leave Use Cases
  sl.registerLazySingleton(() => GetLeaveHistory(repository: sl()));
  sl.registerLazySingleton(() => GetLeaveAuthority(repository: sl()));
  sl.registerLazySingleton(() => DeleteLeaveHistory(repository: sl()));
  sl.registerLazySingleton(() => GetDayCannotLeave(repository: sl()));
  sl.registerLazySingleton(() => SendLeaveRequest(repository: sl()));

    // * WaitingStatus Manager
  sl.registerLazySingleton(() => GetLeaveRequestManager(repository: sl()));
  sl.registerLazySingleton(() => GetRequestTimeManager(repository: sl()));
  sl.registerLazySingleton(() => GetWithdrawLeaveManager(repository: sl()));
  sl.registerLazySingleton(() => GetPayrollSettingManager(repository: sl()));
  sl.registerLazySingleton(() => IsLeaveApprove(repository: sl()));
  sl.registerLazySingleton(() => IsRequestApprove(repository: sl()));

    // ! WorkingTime Manager
  sl.registerLazySingleton(() => GetEmployeesAttendance(repository: sl()));
  sl.registerLazySingleton(() => GetEmployeesLeave(repository: sl()));
  sl.registerLazySingleton(() => GetEmployees(repository: sl()));
  sl.registerLazySingleton(() => GetAttendanceEmpDate(repository: sl()));
  sl.registerLazySingleton(() => GetReasonManager(repository: sl()));
  sl.registerLazySingleton(() => SendTimeRequestManager(repository: sl()));

    // ! Overview Manager
  sl.registerLazySingleton(() => GetDepartment(repository: sl()));
  sl.registerLazySingleton(() => GetOverview(repository: sl()));
  sl.registerLazySingleton(() => GetOverTime(repository: sl()));
  sl.registerLazySingleton(() => GetWorkingTime(repository: sl()));
  sl.registerLazySingleton(() => GetCost(repository: sl()));

  // * Repository
    // ! Login Repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(loginApi: sl()));

    // ! ShiftOT Repository
  sl.registerLazySingleton<SummaryShiftAndOTRepository>(() => SummaryShiftAndOTRepositoryImpl(remoteDataSource: sl()));

    // ! TimeLine Repository
  sl.registerLazySingleton<TimeLineRepository>(() => TimeLineRepositoryImpl(remoteDataSource: sl()));

    // ! Gps Repository
  sl.registerLazySingleton<GpsRepository>(() => GpsRepositoryImpl(remoteDatasource: sl()));

    // ! Leave Repository
  sl.registerLazySingleton<LeaveRepository>(() => LeaveRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<ItemStatusRepository>(() => ItemStatusRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<PayslipRepository>(() => PayslipRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<EditProfileRepository>(() => EditProfileRepositoryImpl(remoteDataSource: sl()));

    // ! WaitingStatus
  sl.registerLazySingleton<WaitingStatusRepository>(() => WaitingStatusRepositoryImpl(remoteDataSource: sl()));

    // ! WorkingTime
  sl.registerLazySingleton<WorkingTimeRepository>(() => WorkingTimeRepositoryImpl(remoteDataSource: sl()));

    // ! Overview Manager
  sl.registerLazySingleton<OverviewRepository>(
          () => OverviewRepositoryImpl(remoteDataSource: sl()));

  // * Data Source
    // ! Login Remote Data Source
  sl.registerLazySingleton<LoginApi>(() => LoginApiImpl(client: sl()));

    // ! Shift and OT Data Source
  sl.registerLazySingleton<SummaryShiftAndOTRemoteDatasource>(() => SummaryShiftAndOTRemoteDatasourceImpl(client: sl()));

    // ! TimeLine Remote Data Source
  sl.registerLazySingleton<TimeLineRemoteDataSource>(() => TimeLineRemoteDataSourceImpl(client: sl()));

    // ! GPS Remote Data Source
  sl.registerLazySingleton<GpsRemoteDatasource>(() => GpsRemoteDatasourceImpl(client: sl()));

    // ! Leave Remote Data Source
  sl.registerLazySingleton<LeaveRemoteDataSource>(() => LeaveRemoteDataSourceImpl(client: sl(), dio: sl()));

    // ! Overview Manager
  sl.registerLazySingleton<OverviewRemoteDataSource>(
          () => OverviewRemoteDataSourceImpl(dio: sl()));

  sl.registerLazySingleton<ItemStatusRemoteDataSource>(() => ItemStatusRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PayslipRemoteDataSource>(() => PayslipRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<EditProfileRemoteDataSource>(() => EditProfileRemoteDataSourceImpl(client: sl()));


    // ! WaitingStatus
  sl.registerLazySingleton<WaitingStatusRemoteDataSource>(() => WaitingStatusRemoteDataSourceImpl(client: sl()));

    // ! WorkingTime
  sl.registerLazySingleton<WorkingTimeRemoteDataSource>(() => WorkingTimeRemoteDataSourceImpl(client: sl()));

  // * External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
}