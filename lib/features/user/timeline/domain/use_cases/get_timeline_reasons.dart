import 'package:anthr/features/user/timeline/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/attendance_repository.dart';

class GetTimeLineReasons {
  final TimeLineRepository repository;
  GetTimeLineReasons({required this.repository});

  Future<Either<ErrorMessage, List<ReasonsTimeLineRequest>>> call(int idCompany,int idVendor) async {
    return await repository.getReasonsTimeLineRequest(idCompany,idVendor);
  }
}