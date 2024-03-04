import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/data_sources/leave_request.dart';
import '../entities/entities.dart';

abstract class LeaveRepository {
  Future<Either<ErrorMessage , List<LeaveHistoryEntity>>> getLeaveHistory();
  Future<Either<ErrorMessage,void>> deleteLeaveHistory(int idLeave);
  Future<Either<ErrorMessage,List<LeaveAuthorityEntity>>> getLeaveAuthority ();
  Future<Either<ErrorMessage,void>> sendLeaveRequest(LeaveRequest data);

  Future<Either<ErrorMessage,List<DayCannotLeave>>> getDayCannotLeave(DateTime start,DateTime end);
  double calculateDay(
      String type,
      DateTime startDay,
      DateTime endDay,
      int startTimeHour,
      int startTimeMinute,
      int endTimeHour,
      int endTimeMinute);
}