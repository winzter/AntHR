import 'package:dartz/dartz.dart';
import '../../../../../error/failures.dart';
import '../entities/manager_profile_entity.dart';
import '../repositories/manager_profile_repository.dart';

class GetManagerProfile {
  final ManagerProfileRepository repository;

  GetManagerProfile({required this.repository});

  Future<Either<ErrorMessage , ManagerProfileEntity>> call() async{
    return await repository.getManagerProfile();
  }

}