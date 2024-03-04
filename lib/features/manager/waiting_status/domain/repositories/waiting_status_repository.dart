import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/features/profile/manager/domain/entities/manager_profile_entity.dart';
import '../entities/entities.dart';

abstract class WaitingStatusRepository{
  Future<Either<ErrorMessage,List<RequestTimeManager>>> getRequestTimeManager({String? start , String? end});
  Future<Either<ErrorMessage,List<LeaveRequestManager>>> getLeaveRequestManager({String? start , String? end});
  Future<Either<ErrorMessage,List<PayrollSetting>>> getPayrollSetting();
  Future<Either<ErrorMessage,List<WithdrawLeaveManager>>> getWithdrawLeaveManager({String? start , String? end});
  Future<Either<ErrorMessage,void>> isRequestTimeApprove(
      String commentManagerLV1,
      String commentManagerLV2,
      List<int> idRequestTimeLv1,
      int isManagerLV1Approve,
      int? isManagerLV2Approve,
      List<int> idRequestTimeLv2,
      );
  Future<Either<ErrorMessage,void>> isLeaveApprove(
      String commentManager,
      List<int> idLeave,
      int isApprove,
      List<int>? idLeaveEmployeesWithdraw);
  Future<Either<ErrorMessage,void>> isLeaveWithdrawApprove();
}