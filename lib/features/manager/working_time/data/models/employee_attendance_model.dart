import 'dart:convert';
import '../../domain/entities/entities.dart';

List<EmployeesAttendanceModel> employeesAttendanceFromJson(String str) => List<EmployeesAttendanceModel>.from(json.decode(str).map((x) => EmployeesAttendanceModel.fromJson(x)));

String employeesAttendanceToJson(List<EmployeesAttendanceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeesAttendanceModel extends EmployeesAttendanceEntity{

  const EmployeesAttendanceModel({
    required super.attendanceDateTime,
    required super.firstname,
    required super.employeeId,
    required super.idAttendanceType,
    required super.gpsLocationsName,
    required super.positionsName,
    required super.isCheckIn,
    required super.idEmp,
    required super.lastname,
    required super.time,
    required super.attendanceDateTimeText,
  });

  factory EmployeesAttendanceModel.fromJson(Map<String, dynamic> json) => EmployeesAttendanceModel(
    attendanceDateTime: json["attendanceDateTime"] == null ? null : DateTime.parse(json["attendanceDateTime"]),
    firstname: json["firstname"],
    employeeId: json["employeeId"],
    idAttendanceType: json["idAttendanceType"],
    gpsLocationsName: json["gpsLocationsName"],
    positionsName: json["positionsName"],
    isCheckIn: json["isCheckIn"],
    idEmp: json["idEmp"],
    lastname: json["lastname"],
    time: json["time"],
    attendanceDateTimeText: json["attendanceDateTimeText"],
  );

  Map<String, dynamic> toJson() => {
    "attendanceDateTime": attendanceDateTime?.toIso8601String(),
    "firstname": firstname,
    "employeeId": employeeId,
    "idAttendanceType": idAttendanceType,
    "gpsLocationsName": gpsLocationsName,
    "positionsName": positionsName,
    "isCheckIn": isCheckIn,
    "idEmp": idEmp,
    "lastname": lastname,
    "time": time,
    "attendanceDateTimeText": attendanceDateTimeText,
  };
}
