import 'package:dartz/dartz.dart';
import '../../../../error/failures.dart';
import '../entities/login_entity.dart';
import '../repositories/login_repository.dart';

class LoginUseCase{
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<ErrorMessage, LoginEntity>> call(String username,String password) async {
    return await repository.login(username,password);
  }
}