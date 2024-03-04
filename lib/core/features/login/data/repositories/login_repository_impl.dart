import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import '../../../../constanst/errorText.dart';
import '../../../../error/exception.dart';
import '../../../../error/failures.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../data_sources/remote/login_api.dart';


class LoginRepositoryImpl implements LoginRepository{
  final LoginApi loginApi;
  LoginRepositoryImpl({required this.loginApi});
  @override
  Future<Either<ErrorMessage, LoginEntity>> login(String username, String password) async{
    try{
      final data = await loginApi.login(username, password);
      return Right(data);
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