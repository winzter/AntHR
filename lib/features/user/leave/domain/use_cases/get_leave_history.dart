import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/leave_history_entity.dart';
import '../repositories/leave_repositories.dart';

class GetLeaveHistory{
  final LeaveRepository repository;

  GetLeaveHistory({required this.repository});

  Future<Either<ErrorMessage,List<LeaveHistoryEntity>>> call() async{
    return await repository.getLeaveHistory();
  }
}