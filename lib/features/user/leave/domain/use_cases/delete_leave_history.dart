import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/leave_repositories.dart';

class DeleteLeaveHistory{
  final LeaveRepository repository;
  DeleteLeaveHistory({required this.repository});

  Future<Either<ErrorMessage,void>> call(int idLeave) async{
    return await repository.deleteLeaveHistory(idLeave);
  }
}