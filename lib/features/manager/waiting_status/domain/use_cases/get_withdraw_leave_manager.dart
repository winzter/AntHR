import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/waiting_status_repository.dart';

class GetWithdrawLeaveManager{
  final WaitingStatusRepository repository;

  GetWithdrawLeaveManager({required this.repository});

  Future<Either<ErrorMessage,List<WithdrawLeaveManager>>> call({String? start , String? end}) async{
    return await repository.getWithdrawLeaveManager(start: start,end: end);
  }
}