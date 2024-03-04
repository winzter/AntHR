import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/waiting_status_repository.dart';

class GetPayrollSettingManager{
  final WaitingStatusRepository repository;

  GetPayrollSettingManager({required this.repository});

  Future<Either<ErrorMessage,List<PayrollSetting>>> call() async{
    return await repository.getPayrollSetting();
  }
}