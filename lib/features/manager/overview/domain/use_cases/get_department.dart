import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/overview_repository.dart';

class GetDepartment{
  final OverviewRepository repository;

  GetDepartment({required this.repository});

  Future<Either<ErrorMessage, List<DepartmentEntity>>> call() async{
    return await repository.getDepartment();
  }
}