import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/item_status_repository.dart';

class GetWithdraw {
  final ItemStatusRepository repository;
  GetWithdraw({required this.repository});

  Future<Either<ErrorMessage, List<WithdrawEntity>>> call(
      String startDate, String endDate) async {
    return await repository.getWithdraw(startDate, endDate);
  }
}
