import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/item_status_repository.dart';

class GetPayrollSetting {
  final ItemStatusRepository repository;
  GetPayrollSetting({required this.repository});

  Future<Either<ErrorMessage, List<PayrollSettingEntity>>> call() async {
    return await repository.getPayrollSetting();
  }
}
