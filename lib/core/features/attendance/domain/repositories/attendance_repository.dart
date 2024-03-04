import 'package:dartz/dartz.dart';
import '../../../../error/failures.dart';
import '../entities/attendance_entity.dart';

abstract class AttendanceRepository{
  Future<Either<ErrorMessage,List<AttendanceEntity>>> getAttendance();
  Future<Either<ErrorMessage,List<AttendanceEntity>>> getAttendanceByDate(String start,String end);
}