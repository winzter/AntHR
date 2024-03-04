import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/waiting_status_repository.dart';

class GetLeaveRequestManager{
  final WaitingStatusRepository repository;

  GetLeaveRequestManager({required this.repository});

  Future<Either<ErrorMessage,List<LeaveRequestManager>>> call({String? start , String? end}) async{
    return await repository.getLeaveRequestManager(start: start,end: end);
  }
}