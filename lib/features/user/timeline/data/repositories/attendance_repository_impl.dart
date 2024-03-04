import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/features/profile/user/domain/entity/profile_entity.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../data_sources/remote/attendance_remote_datasource.dart';

class TimeLineRepositoryImpl implements TimeLineRepository{

  final TimeLineRemoteDataSource remoteDataSource;

  TimeLineRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, List<TimeLineEntity>>> getAttendance() async{
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
  Future<Either<ErrorMessage, List<TimeLineEntity>>> getAttendanceByDate(String start, String end) async{
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


  @override
  Map<String, List<String>> getEvents(List<TimeLineEntity> data) {
    Map<String, List<String>> events = {};
    for (var item in data) {
      events[DateFormat("yyyy-MM-dd").format(item.date!)];
      List<String> status = [];
      if(item.leave!.isNotEmpty){
        status.add(('leave'));
      }
      if(item.holiday != null){
        status.add('holiday');
      }
      if(item.ot!.isNotEmpty){
        status.add('ot');
      }
      if(item.requestTime!.isNotEmpty){
        status.add("request_time");
      }
      if(item.absent!){
        status.add("absent");
      }
      if (events.containsKey(item.date)) {
        events[DateFormat("yyyy-MM-dd").format(item.date!)]!.addAll(status);
      } else {
        events[DateFormat("yyyy-MM-dd").format(item.date!)] = List.from(status);
      }
    }
    return events;
  }

  @override
  Future<Either<ErrorMessage, void>> sendTimeRequest(
    CalculateTimeEntity result,
    int idEmployee,
    int idRequestType,
    int idRequestReason,
    String otherReason,
    DateTime start,
    DateTime end,
    DateTime workEndDate,
      ProfileEntity profileData
      ) async{
    try {
      final data = await remoteDataSource.sendTimeRequest(
          result,
          idEmployee,
          idRequestType,
          idRequestReason,
          otherReason,
          start,
          end,
          workEndDate,
          profileData
      );
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
  Future<Either<ErrorMessage, List<PayrollSettingTimeLine>>> getPayrollSettingTimeLine() async{
    try {
      final data = await remoteDataSource.getPayrollSettingTimeLine();
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
  Future<Either<ErrorMessage, List<ReasonsTimeLineRequest>>> getReasonsTimeLineRequest(int idCompany,int idVendor) async{
    try {
      final data = await remoteDataSource.getReasonsTimeLineRequest(idCompany, idVendor);
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