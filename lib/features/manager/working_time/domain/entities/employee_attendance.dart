import 'package:equatable/equatable.dart';


class EmployeesAttendanceEntity extends Equatable{
  final DateTime? attendanceDateTime;
  final String? firstname;
  final String? employeeId;
  final int? idAttendanceType;
  final String? gpsLocationsName;
  final String? positionsName;
  final int? isCheckIn;
  final int? idEmp;
  final String? lastname;
  final String? time;
  final String? attendanceDateTimeText;

  const EmployeesAttendanceEntity({
    this.attendanceDateTime,
    this.firstname,
    this.employeeId,
    this.idAttendanceType,
    this.gpsLocationsName,
    this.positionsName,
    this.isCheckIn,
    this.idEmp,
    this.lastname,
    this.time,
    this.attendanceDateTimeText,
  });



  @override
  List<Object?> get props => [
    attendanceDateTime,
    firstname,
    employeeId,
    idAttendanceType,
    gpsLocationsName,
    positionsName,
    isCheckIn,
    idEmp,
    lastname,
    time,
    attendanceDateTimeText,
  ];
}
