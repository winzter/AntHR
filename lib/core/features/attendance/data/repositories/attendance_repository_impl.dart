import 'package:anthr/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import '../../../../constanst/errorText.dart';
import '../../../../error/exception.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../data_sources/remote/attendance_remote_datasource.dart';

class AttendanceRepositoryImpl implements AttendanceRepository{

  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, List<AttendanceEntity>>> getAttendance() async{
    try {
      final data = await remoteDataSource.getAttendance();
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

  @override
  Future<Either<ErrorMessage, List<AttendanceEntity>>> getAttendanceByDate(String start, String end) async{
    try {
      final data = await remoteDataSource.getAttendanceByDate(start, end);
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