import 'package:anthr/features/user/leave/data/data_sources/leave_request.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/leave_repositories.dart';
import '../data_sources/remote/leave_remote_data_source.dart';

class LeaveRepositoryImpl implements LeaveRepository{
  final LeaveRemoteDataSource remoteDataSource;
  LeaveRepositoryImpl({required this.remoteDataSource});

  @override
  double calculateDay(
      String type,
      DateTime startDay,
      DateTime endDay,
      int startTimeHour,
      int startTimeMinute,
      int endTimeHour,
      int endTimeMinute) {
    if (type == "fulltime") {
      Duration difference = endDay.difference(startDay);
      // log(((difference.inHours / 24) + 1).ceil().toString());
      return ((difference.inHours / 24) + 1).ceil().toDouble();
    } else {
      var numDiff = 0;
      if ((startTimeHour == endTimeHour && startTimeMinute == endTimeMinute) &&
          startDay == endDay) {
        return 1;
      }
      if (startTimeHour > 12) {
        numDiff = -1;
      }
      int hourDiff = endTimeHour - startTimeHour;
      int minuteDiff = endTimeMinute - startTimeMinute;
      double inDays = ((hourDiff + numDiff + (minuteDiff == 0 ? 0 : 0.5)) / 8);
      // log(inDays.toStringAsFixed(2));
      return double.parse(inDays.toStringAsFixed(2));
    }
  }

  @override
  Future<Either<ErrorMessage, void>> deleteLeaveHistory(int idLeave) async{
    try{
      final data = await remoteDataSource.deleteLeaveHistory(idLeave);
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
  Future<Either<ErrorMessage, List<LeaveAuthorityEntity>>> getLeaveAuthority() async{
    try{
      final data = await remoteDataSource.getLeaveAuthority();
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
  Future<Either<ErrorMessage, List<LeaveHistoryEntity>>> getLeaveHistory() async{
    try{
      final data = await remoteDataSource.getLeaveHistory();
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
  Future<Either<ErrorMessage, List<DayCannotLeave>>> getDayCannotLeave(DateTime start, DateTime end) async{
    try{
      final res = await remoteDataSource.getDayCannotLeave(start,end);
      return Right(res);
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
  Future<Either<ErrorMessage, void>> sendLeaveRequest(LeaveRequest data) async{
    try{
      final res = await remoteDataSource.sendLeaveRequest(data);
      return Right(res);
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