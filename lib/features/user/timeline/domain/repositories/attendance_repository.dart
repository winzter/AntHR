import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/features/profile/user/domain/entity/profile_entity.dart';
import '../entities/entities.dart';

abstract class TimeLineRepository{
  Future<Either<ErrorMessage,List<TimeLineEntity>>> getAttendance();
  Future<Either<ErrorMessage,List<TimeLineEntity>>> getAttendanceByDate(String start,String end);
  Map<String,List<String>> getEvents(List<TimeLineEntity> data);
  Future<Either<ErrorMessage,List<PayrollSettingTimeLine>>> getPayrollSettingTimeLine();
  Future<Either<ErrorMessage,List<ReasonsTimeLineRequest>>> getReasonsTimeLineRequest(int idCompany,int idVendor);
  Future<Either<ErrorMessage,void>> sendTimeRequest(
      CalculateTimeEntity result,
      int idEmployee,
      int idRequestType,
      int idRequestReason,
      String otherReason,
      DateTime start,
      DateTime end,
      DateTime workEndDate,
      ProfileEntity profileData
      );
}