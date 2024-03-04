import 'package:dartz/dartz.dart';
import 'package:anthr/features/user/summary_shfit_ot/domain/entities/shift_ot_entity.dart';
import 'package:anthr/features/user/summary_shfit_ot/domain/repositories/summary_shift_ot_repository.dart';
import '../../../../../core/error/failures.dart';

class GetSummaryShiftAndOt {
  final SummaryShiftAndOTRepository repository;
  GetSummaryShiftAndOt({required this.repository});

  Future<Either<ErrorMessage, ShiftAndOtEntity>> call(String start) async {
    return await repository.getSummaryShiftAndOt(start);
  }
}