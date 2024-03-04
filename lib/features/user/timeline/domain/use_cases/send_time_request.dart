import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/features/profile/user/domain/entity/profile_entity.dart';
import '../entities/calculate_time_entity.dart';
import '../repositories/attendance_repository.dart';

class SendTimeRequest {
  final TimeLineRepository repository;
  SendTimeRequest({required this.repository});

  Future<Either<ErrorMessage, void>> call(
      CalculateTimeEntity result,
        int idEmployee,
        int idRequestType,
        int idRequestReason,
        String otherReason,
        DateTime start,
        DateTime end,
        DateTime workEndDate,
        String note,
      ProfileEntity profileData
      ) async {
    return await repository.sendTimeRequest(
        result,
        idEmployee,
        idRequestType,
        idRequestReason,
        otherReason,
        start,
        end,
        workEndDate,
        profileData
    );
  }
}