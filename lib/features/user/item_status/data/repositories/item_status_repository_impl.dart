import 'package:dartz/dartz.dart';
import 'package:anthr/core/error/failures.dart';
import 'package:http/http.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../../../../core/error/exception.dart';
import '../../domain/entities/leave_entity.dart';
import '../../domain/entities/payroll_entity.dart';
import '../../domain/entities/request_time_entity.dart';
import '../../domain/entities/withdraw_entity.dart';
import '../../domain/repositories/item_status_repository.dart';
import '../data_sources/remote/item_status_remote_data_source.dart';
import '../models/models.dart';

class ItemStatusRepositoryImpl implements ItemStatusRepository {
  final ItemStatusRemoteDataSource remoteDataSource;

  ItemStatusRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, void>> deleteItem(
      {LeaveEntity? dataLeave, RequestTimeEntity? dataRequestTime}) async {
    try {
      if (dataLeave == null) {
        await remoteDataSource.deleteItem(
            dataRequestTime: dataRequestTime as RequestTimeModel);
      } else {
        await remoteDataSource.deleteItem(dataLeave: dataLeave as LeaveModel);
      }
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
  Future<Either<ErrorMessage, List<LeaveEntity>>> getLeave(
      String startDate, String endDate) async {
    try {
      final data = await remoteDataSource.getLeave(startDate, endDate);
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
  Future<Either<ErrorMessage, List<PayrollSettingEntity>>> getPayrollSetting() async {
    try {
      final data = await remoteDataSource.getPayrollSetting();
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
  Future<Either<ErrorMessage, List<RequestTimeEntity>>> getRequestTime(String startDate, String endDate) async {
    try {
      final data = await remoteDataSource.getRequestTime(startDate, endDate);
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
  Future<Either<ErrorMessage, List<WithdrawEntity>>> getWithdraw(String startDate, String endDate) async {
    try {
      final data = await remoteDataSource.getWithdraw(startDate, endDate);
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
