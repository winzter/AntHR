import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';

abstract class EditProfileRepository{
  Future<Either<ErrorMessage , void>> sendEditAddress(String address,String zipcode,String district,String province);
  Future<Either<ErrorMessage , void>> changePassword(String oldPass,String newPass,String confirm);
  Future<Either<ErrorMessage , void>> sendEditPhoneNumber(String phoneNum);
  Future<Either<ErrorMessage , void>> sendEditEmergencyContract(String emergencyName,String phoneNum,String emergencyRelationship);
}