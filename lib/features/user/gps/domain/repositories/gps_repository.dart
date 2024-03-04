import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/location_entity.dart';

abstract class GpsRepository {
  Future<Either<ErrorMessage,LineCheckIn>> getLocation(int idEmp);

  Future<Either<ErrorMessage,void>> sentLocation(
      String attendanceDateTime,
      int isCheckIn,
      int idAttendanceType,
      int? idGpsLocation,
      int idEmployee,
      int idCompany,
      String? address,
      double? lat,
      double? lng,
      );
}