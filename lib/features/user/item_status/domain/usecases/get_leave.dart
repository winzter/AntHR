import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/item_status_repository.dart';

class GetLeaveData {
  final ItemStatusRepository repository;
  GetLeaveData({required this.repository});

  Future<Either<ErrorMessage, List<LeaveEntity>>> call(
      String startDate, String endDate) async {
    return await repository.getLeave(startDate, endDate);
  }
}
