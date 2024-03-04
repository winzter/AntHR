import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/edit_profile_repository.dart';


class ChangePassword{
  final EditProfileRepository repository;
  ChangePassword({required this.repository});

  Future<Either<ErrorMessage, void>> call(String oldPass,String newPass,String confirm) async {
    return await repository.changePassword(oldPass,newPass,confirm);
  }
}
