import 'package:dartz/dartz.dart';
import 'package:anthr/core/error/failures.dart';
import 'package:http/http.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../../../../core/error/exception.dart';
import '../../domain/repositories/edit_profile_repository.dart';
import '../data_sources/remote/edit_profile_remote_data_source.dart';

class EditProfileRepositoryImpl extends EditProfileRepository{

  final EditProfileRemoteDataSourceImpl remoteDataSource;

  EditProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, void>> sendEditAddress(String address,String zipcode,String district,String province) async{
    try {
      await remoteDataSource.sendEditAddress(address, zipcode, district,province);
      return const Right(null);
    } on ErrorException catch (e){
      ErrorText.logger.e(e.message);
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on ClientException catch (e){
      ErrorText.logger.e(e.message);
      return Left(ErrorMessage(errMsgText: ErrorText.clientError));
    } on FormatException catch (e){
      ErrorText.logger.e(e.message);
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }

  @override
  Future<Either<ErrorMessage, void>> sendEditEmergencyContract(String emergencyName,String phoneNum,String emergencyRelationship) async{
    try {
      await remoteDataSource.sendEditEmergencyContract(emergencyName, phoneNum, emergencyRelationship);
      return const Right(null);
    } on ErrorException catch (e){
      ErrorText.logger.e(e.message);
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on ClientException catch (e){
      ErrorText.logger.e(e.message);
      return Left(ErrorMessage(errMsgText: ErrorText.clientError));
    } on FormatException catch (e){
      ErrorText.logger.e(e.message);
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }

  @override
  Future<Either<ErrorMessage, void>> changePassword(String oldPass,String newPass,String confirm) async{
    try {
      await remoteDataSource.changePassword(oldPass, newPass, confirm);
      return const Right(null);
    } on ErrorException catch (e){
      ErrorText.logger.e(e.message);
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on ClientException catch (e){
      ErrorText.logger.e(e.message);
      return Left(ErrorMessage(errMsgText: ErrorText.clientError));
    } on FormatException catch (e){
      ErrorText.logger.e(e.message);
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }

  @override
  Future<Either<ErrorMessage, void>> sendEditPhoneNumber(String phoneNum) async{
    try {
      await remoteDataSource.sendEditPhoneNumber(phoneNum);
      return const Right(null);
    } on ErrorException catch (e){
      ErrorText.logger.e(e.message);
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on ClientException catch (e){
      ErrorText.logger.e(e.message);
      return Left(ErrorMessage(errMsgText: ErrorText.clientError));
    } on FormatException catch (e){
      ErrorText.logger.e(e.message);
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }
}