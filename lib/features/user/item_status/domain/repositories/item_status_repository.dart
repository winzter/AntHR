import 'package:dartz/dartz.dart';
import 'package:anthr/core/error/failures.dart';
import '../entities/entities.dart';

abstract class ItemStatusRepository {
  Future<Either<ErrorMessage, List<LeaveEntity>>> getLeave(
      String startDate, String endDate);
  Future<Either<ErrorMessage, List<RequestTimeEntity>>> getRequestTime(
      String startDate, String endDate);
  Future<Either<ErrorMessage, List<WithdrawEntity>>> getWithdraw(
      String startDate, String endDate);
  Future<Either<ErrorMessage, List<PayrollSettingEntity>>> getPayrollSetting();
  Future<Either<ErrorMessage, void>> deleteItem(
      {LeaveEntity? dataLeave, RequestTimeEntity? dataRequestTime});
}
