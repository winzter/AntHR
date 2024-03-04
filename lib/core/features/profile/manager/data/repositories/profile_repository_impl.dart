import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import '../../../../../constanst/errorText.dart';
import '../../../../../error/exception.dart';
import '../../../../../error/failures.dart';
import '../../domain/entities/manager_profile_entity.dart';
import '../../domain/repositories/manager_profile_repository.dart';
import '../data_sources/profile_remote_data_source.dart';

class ManagerProfileRepositoryImpl implements ManagerProfileRepository{

  final ManagerProfileRemoteDataSource remoteDataSource;

  ManagerProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, ManagerProfileEntity>> getManagerProfile() async{
    try {
      final data = await remoteDataSource.getManagerProfile();
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