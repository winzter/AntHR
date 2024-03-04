import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/item_status_repository.dart';

class GetRequestTimeData {
  final ItemStatusRepository repository;
  GetRequestTimeData({required this.repository});

  Future<Either<ErrorMessage, List<RequestTimeEntity>>> call(
      String startDate, String endDate) async {
    return await repository.getRequestTime(startDate, endDate);
  }
}
