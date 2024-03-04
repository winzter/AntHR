import 'package:dartz/dartz.dart';
import 'package:anthr/core/error/failures.dart';
import '../entities/payslip.dart';

abstract class PayslipRepository {
  Future<Either<ErrorMessage, List<PayslipEntity>>> getPayslip(
      String year, String month);
}
