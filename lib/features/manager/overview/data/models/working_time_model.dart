import 'dart:convert';
import '../../domain/entities/entities.dart';

WorkingTimeModel workingTimeModelFromJson(String str) =>
    WorkingTimeModel.fromJson(json.decode(str));

// String workingTimeModelToJson(WorkingTimeModel data) =>
//     json.encode(data.toJson());

class WorkingTimeModel extends WorkingTimeEntity {
  WorkingTimeModel({
    required super.employeeTotal,
    required WorkingTimeEmployeeInfoModel? super.workingTimeEmployeeInfo,
  });

  factory WorkingTimeModel.fromJson(Map<String, dynamic> json) =>
      WorkingTimeModel(
        employeeTotal: json["employeeTotal"],
        workingTimeEmployeeInfo: json["workingTimeEmployeeInfo"] == null
            ? null
            : WorkingTimeEmployeeInfoModel.fromJson(json["workingTimeEmployeeInfo"]),
      );

// Map<String, dynamic> toJson() => {
//   "employeeTotal": employeeTotal,
//   "workingTimeEmployeeInfo": workingTimeEmployeeInfo?.toJson(),
// };
}

class WorkingTimeEmployeeInfoModel extends WorkingTimeEmployeeInfo {
  WorkingTimeEmployeeInfoModel({
    required List<LeaveModel>? super.leave,
    required super.leaveTotal,
    required super.lateTotal,
    required super.absentTotal,
    required List<Top5EmployeeModel>? super.top5LateEmployees,
    required List<Top5EmployeeModel>? super.top5AbsentEmployees,
  });

  factory WorkingTimeEmployeeInfoModel.fromJson(Map<String, dynamic> json) =>
      WorkingTimeEmployeeInfoModel(
        leave: json["leave"] == null
            ? []
            : List<LeaveModel>.from(json["leave"]!.map((x) => LeaveModel.fromJson(x))),
        leaveTotal: json["leaveTotal"],
        lateTotal: json["lateTotal"],
        absentTotal: json["absentTotal"],
        top5LateEmployees: json["top5LateEmployees"] == null
            ? []
            : List<Top5EmployeeModel>.from(json["top5LateEmployees"]!
                .map((x) => Top5EmployeeModel.fromJson(x))),
        top5AbsentEmployees: json["top5AbsentEmployees"] == null
            ? []
            : List<Top5EmployeeModel>.from(json["top5AbsentEmployees"]!
                .map((x) => Top5EmployeeModel.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "leave": leave == null
  //           ? []
  //           : List<dynamic>.from(leave!.map((x) => x.toJson())),
  //       "leaveTotal": leaveTotal,
  //       "lateTotal": lateTotal,
  //       "absentTotal": absentTotal,
  //       "top5LateEmployees": top5LateEmployees == null
  //           ? []
  //           : List<dynamic>.from(top5LateEmployees!.map((x) => x.toJson())),
  //       "top5AbsentEmployees": top5AbsentEmployees == null
  //           ? []
  //           : List<dynamic>.from(top5AbsentEmployees!.map((x) => x.toJson())),
  //     };
}

class LeaveModel extends Leave {
  LeaveModel({
    required super.idLeave,
    required super.idLeaveType,
    required super.name,
    required super.description,
    required super.start,
    required super.startText,
    required super.end,
    required super.endText,
    required super.isFullDay,
    required super.firstnameTh,
    required super.lastnameTh,
    required super.imageProfile,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
        idLeave: json["idLeave"],
        idLeaveType: json["idLeaveType"],
        name: json["name"],
        description: json["description"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        startText: json["startText"],
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        endText: json["endText"],
        isFullDay: json["isFullDay"],
        firstnameTh: json["firstname_TH"],
        lastnameTh: json["lastname_TH"],
        imageProfile: json["imageProfile"],
      );

  Map<String, dynamic> toJson() => {
        "idLeave": idLeave,
        "idLeaveType": idLeaveType,
        "name": name,
        "description": description,
        "start": start?.toIso8601String(),
        "startText": startText,
        "end": end?.toIso8601String(),
        "endText": endText,
        "isFullDay": isFullDay,
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "imageProfile": imageProfile,
      };
}

class Top5EmployeeModel extends Top5Employee {
  Top5EmployeeModel({
    required super.idEmployees,
    required super.firstnameTh,
    required super.lastnameTh,
    required super.imageName,
    required super.lateTotal,
    required super.absentTotal,
    required super.imageProfile,
  });

  factory Top5EmployeeModel.fromJson(Map<String, dynamic> json) =>
      Top5EmployeeModel(
        idEmployees: json["idEmployees"],
        firstnameTh: json["firstname_TH"],
        lastnameTh: json["lastname_TH"],
        imageName: json["imageName"],
        lateTotal: json["lateTotal"],
        absentTotal: json["absentTotal"],
        imageProfile: json["imageProfile"],
      );

  Map<String, dynamic> toJson() => {
        "idEmployees": idEmployees,
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "imageName": imageName,
        "lateTotal": lateTotal,
        "absentTotal": absentTotal,
        "imageProfile": imageProfile,
      };
}
