import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/features/attendance/domain/entities/attendance_entity.dart';
import '../repositories/working_time_repository.dart';

class GetAttendanceEmpDate{
  final WorkingTimeRepository repository;

  GetAttendanceEmpDate({required this.repository});

  Future<Either<ErrorMessage,List<AttendanceEntity>>> call(int id,String start,String end) async{
    return await repository.getAttendanceEmpDate(id,start,end);
  }
}