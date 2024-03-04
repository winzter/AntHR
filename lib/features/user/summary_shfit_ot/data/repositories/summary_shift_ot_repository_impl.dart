import 'package:dartz/dartz.dart';
import 'package:anthr/core/error/exception.dart';
import 'package:anthr/core/error/failures.dart';
import 'package:anthr/features/user/summary_shfit_ot/data/data_sources/remote/shift_ot_remote_datasource.dart';
import 'package:http/http.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../domain/repositories/summary_shift_ot_repository.dart';
import '../models/shift_ot_model.dart';


class SummaryShiftAndOTRepositoryImpl implements SummaryShiftAndOTRepository {
  final SummaryShiftAndOTRemoteDatasource remoteDataSource;

  SummaryShiftAndOTRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, ShiftAndOtModel>> getSummaryShiftAndOt(String start) async{
    try {
      final ShiftAndOtModel data = await remoteDataSource.getSummaryShiftAndOt(start);
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
