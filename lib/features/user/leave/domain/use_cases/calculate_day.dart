import '../repositories/leave_repositories.dart';

class CalculateDay{
  final LeaveRepository repository;
  CalculateDay(this.repository);

  double call(String type,DateTime startDay,DateTime endDay,
      int startTimeHour,
      int startTimeMinute,
      int endTimeHour,
      int endTimeMinute){
    return repository.calculateDay(type, startDay, endDay, startTimeHour, startTimeMinute,endTimeHour,endTimeMinute);
  }
}