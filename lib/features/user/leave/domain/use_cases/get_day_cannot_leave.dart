import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/day_cannot_leave_entity.dart';
import '../repositories/leave_repositories.dart';

class GetDayCannotLeave {
  final LeaveRepository repository;
  GetDayCannotLeave({required this.repository});

  Future<Either<ErrorMessage,List<DayCannotLeave>>>call(DateTime start,DateTime end) async{
    return await repository.getDayCannotLeave(start,end);
  }
}