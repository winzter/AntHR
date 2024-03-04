import 'package:flutter/material.dart';
import 'package:anthr/features/user/summary_shfit_ot/data/data_sources/remote/shift_ot_remote_datasource.dart';
import 'package:anthr/features/user/summary_shfit_ot/data/repositories/summary_shift_ot_repository_impl.dart';
import 'package:anthr/features/user/summary_shfit_ot/presentation/provider/shift_ot_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'core/features/attendance/data/data_sources/remote/attendance_remote_datasource.dart';
import 'core/features/attendance/data/repositories/attendance_repository_impl.dart';
import 'core/features/attendance/domain/use_cases/get_attendance.dart';
import 'core/features/attendance/presentation/provider/attendance_provider.dart';
import 'core/features/profile/manager/data/data_sources/profile_remote_data_source.dart';
import 'core/features/profile/manager/data/repositories/profile_repository_impl.dart';
import 'core/features/profile/manager/domain/usecases/get_manager_profile.dart';
import 'core/features/profile/manager/presentation/provider/manager_profile_provider.dart';
import 'core/features/profile/user/data/datasource/remote/profile_remote_data_source.dart';
import 'core/features/profile/user/data/repository/profile_repository_impl.dart';
import 'core/features/profile/user/domain/usecase/get_profile.dart';
import 'core/features/profile/user/presentation/provider/profile_provider.dart';
import 'core/provider/bottom_navbar/bottom_navbar_provider.dart';
import 'features/manager/waiting_status/presentation/providers/radio_button_provider.dart';
import 'features/user/edit_profile/data/data_sources/remote/edit_profile_remote_data_source.dart';
import 'features/user/edit_profile/data/repositories/profile_repository_impl.dart';
import 'features/user/edit_profile/domain/usecases/use_cases.dart';
import 'features/user/edit_profile/presentation/provider/edit_profile_provider.dart';
import 'features/user/home/presentation/provider/leave_provider.dart';
import 'features/user/item_status/data/data_sources/remote/item_status_remote_data_source.dart';
import 'features/user/item_status/data/repositories/item_status_repository_impl.dart';
import 'features/user/item_status/domain/usecases/use_cases.dart';
import 'features/user/item_status/presentation/provider/item_status_provider.dart';
import 'features/user/payslip/data/data_sources/remote/payslip_remote_data_source.dart';
import 'features/user/payslip/data/repositories/payslip_repository_impl.dart';
import 'features/user/payslip/domain/usecases/get_payslip.dart';
import 'features/user/payslip/presentation/provider/payslip_provider.dart';
import 'features/user/summary_shfit_ot/domain/use_cases/getSummaryShiftAndOt.dart';

class Injection extends StatelessWidget {
  final Widget? router;
  const Injection({super.key, this.router});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NavIndex()),
          ChangeNotifierProvider(create: (context) => RadioButtonProvider()),
          ChangeNotifierProvider(create: (context) => ManagerRadioButtonProvider()),

            // * Attendance
          ChangeNotifierProvider(create: (context) => AttendanceProvider(
              getAttendance: GetAttendance(
                  repository: AttendanceRepositoryImpl(
                      remoteDataSource: AttendanceRemoteDataSourceImpl(
                          client: http.Client()))))),
            // * Payslip
          ChangeNotifierProvider(
              create: (_) => GetPayslipProvider(
                  getPayslip: GetPayslip(PayslipRepositoryImpl(
                      remoteDataSource: PayslipRemoteDataSourceImpl(
                          client: http.Client()))))),

            // * Shift And OT
          ChangeNotifierProvider(
              create: (_) => GetShiftAndOTProvider(
                  getSummaryShiftAndOt: GetSummaryShiftAndOt(
                      repository: SummaryShiftAndOTRepositoryImpl(
                          remoteDataSource: SummaryShiftAndOTRemoteDatasourceImpl(
                              client: http.Client()))))),

            // * Profile
          ChangeNotifierProvider(
              create: (_)=>ProfileProvider(
              getProfile: GetProfile(
                  ProfileRepositoryImpl(remoteDataSource: 
                  ProfileRemoteDataSourceImpl(client: http.Client()))))),

            // * Edit Profile
          ChangeNotifierProvider(
              create: (_)=>EditProfileProvider(
              sendEditPhoneNumber: SendEditPhoneNumber(
                  EditProfileRepositoryImpl(
                      remoteDataSource:
                      EditProfileRemoteDataSourceImpl(client: http.Client()))),
              sendEditAddress: SendEditAddress(EditProfileRepositoryImpl(
                  remoteDataSource:
                  EditProfileRemoteDataSourceImpl(client: http.Client()))),
              sendEditEmergencyContract: SendEditEmergencyContract(
                  EditProfileRepositoryImpl(
                  remoteDataSource:
                  EditProfileRemoteDataSourceImpl(client: http.Client()))),
                changePassword: ChangePassword(repository: EditProfileRepositoryImpl(remoteDataSource: EditProfileRemoteDataSourceImpl(client: http.Client()))),)),





          /* * Manager * */
          ChangeNotifierProvider(create: (_)=>WaitingProvider(
              getLeaveData: GetLeaveData(
                  repository: ItemStatusRepositoryImpl(
                      remoteDataSource: ItemStatusRemoteDataSourceImpl(
                          client: http.Client()))),
              getRequestTimeData: GetRequestTimeData(
                  repository: ItemStatusRepositoryImpl(
                      remoteDataSource: ItemStatusRemoteDataSourceImpl(
                          client: http.Client()))))),

          ChangeNotifierProvider(create: (context) => ManagerProfileProvider(
              getManagerProfile: GetManagerProfile(
                  repository: ManagerProfileRepositoryImpl(
                      remoteDataSource: ManagerProfileRemoteDataSourceImpl(
                          client: http.Client()))))),

        ],
        child: router,
      );
}
