import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/shift_ot_entity.dart';

abstract class SummaryShiftAndOTRepository{
  Future<Either<ErrorMessage,ShiftAndOtEntity>> getSummaryShiftAndOt(String start);
}