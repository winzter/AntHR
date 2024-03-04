import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/working_time_repository.dart';

class SendTimeRequestManager {
  final WorkingTimeRepository repository;
  SendTimeRequestManager({required this.repository});

  Future<Either<ErrorMessage, void>> call(
      CalculateTimeEntity result,
      int idEmployee,
      int idRequestType,
      String requestReason,
      String otherReason,
      DateTime start,
      DateTime end,
      DateTime workEndDate,
      String note,
      EmployeesEntity profileData
      ) async {
    return await repository.sendTimeRequestManager(
        result,
        idEmployee,
        idRequestType,
        requestReason,
        otherReason,
        start,
        end,
        workEndDate,
        profileData
    );
  }
}