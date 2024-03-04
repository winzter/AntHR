import 'package:dartz/dartz.dart';
import '../../../../../error/failures.dart';
import '../entities/manager_profile_entity.dart';

abstract class ManagerProfileRepository{
  Future<Either<ErrorMessage , ManagerProfileEntity>> getManagerProfile();
}