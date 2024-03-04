import 'package:dartz/dartz.dart';
import 'package:anthr/core/error/exception.dart';
import 'package:anthr/core/error/failures.dart';
import 'package:http/http.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../domain/entities/payslip.dart';
import '../../domain/repositories/payslip_repository.dart';
import '../data_sources/remote/payslip_remote_data_source.dart';


class PayslipRepositoryImpl implements PayslipRepository {
  final PayslipRemoteDataSource remoteDataSource;

  PayslipRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, List<PayslipEntity>>> getPayslip(
      String year, String month) async {
    try {
      final data = await remoteDataSource.getPayslip(year, month);
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
