import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/edit_profile_repository.dart';


class SendEditAddress{
  final EditProfileRepository repository;
  SendEditAddress(this.repository);

  Future<Either<ErrorMessage, void>> call(String address,String zipcode,String district,String province) async {
    return await repository.sendEditAddress(address,zipcode,district,province);
  }
}
