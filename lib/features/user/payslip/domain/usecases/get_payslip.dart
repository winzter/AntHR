import 'package:dartz/dartz.dart';
import 'package:anthr/core/error/failures.dart';
import '../entities/payslip.dart';
import '../repositories/payslip_repository.dart';


class GetPayslip {
  final PayslipRepository repository;

  GetPayslip(this.repository);

  Future<Either<ErrorMessage, List<PayslipEntity>>> call(
      {required String year, required String month}) async {
    return await repository.getPayslip(year, month);
  }
}
