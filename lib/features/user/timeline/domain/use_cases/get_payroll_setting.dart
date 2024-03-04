import 'package:anthr/features/user/timeline/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/attendance_repository.dart';

class GetPayrollSettingTimeLine {
  final TimeLineRepository repository;
  GetPayrollSettingTimeLine({required this.repository});

  Future<Either<ErrorMessage, List<PayrollSettingTimeLine>>> call() async {
    return await repository.getPayrollSettingTimeLine();
  }
}