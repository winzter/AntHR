import 'dart:convert';
import '../../domain/entities/entities.dart';

List<LeaveHistoryModel> leaveHistoryDataFromJson(String str) =>
    List<LeaveHistoryModel>.from(
        json.decode(str).map((x) => LeaveHistoryModel.fromJson(x)));

String leaveHistoryDataToJson(List<LeaveHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveHistoryModel extends LeaveHistoryEntity{
  const LeaveHistoryModel({
    required super.idLeave,
    required super.idLeaveType,
    required super.description,
    required super.start,
    required super.end,
    required super.idEmp,
    required super.used,
    required super.quota,
    required super.balance,
    required super.remaining,
    required super.idManagerEmployee,
    required super.approveDate,
    required super.isApprove,
    required super.isFullDay,
    required super.workingStart,
    required super.workingEnd,
    required super.isActive,
    required super.createDate,
    required super.isWithdraw,
    required super.filename,
    required super.commentManager,
    required super.name,
    required super.firstname,
    required super.lastname,
    required super.managerName,
    required super.managerEmail,
    required super.startText,
    required super.endText,
    required super.createLeaveText,
  });

  factory LeaveHistoryModel.fromJson(Map<String, dynamic> json) =>
      LeaveHistoryModel(
        idLeave: json["idLeave"],
        idLeaveType: json["idLeaveType"],
        description: json["description"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        idEmp: json["idEmp"],
        used: json["used"]?.toDouble(),
        quota: json["quota"],
        balance: json["balance"]?.toDouble(),
        remaining: json["remaining"]?.toDouble(),
        idManagerEmployee: json["idManagerEmployee"],
        approveDate: json["approveDate"] == null
            ? null
            : DateTime.parse(json["approveDate"]),
        isApprove: json["isApprove"],
        isFullDay: json["isFullDay"],
        workingStart: json["workingStart"],
        workingEnd: json["workingEnd"],
        isActive: json["isActive"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        isWithdraw: json["isWithdraw"],
        filename: json["filename"],
        commentManager: json["commentManager"],
        name: json["name"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        managerName: json["managerName"],
        managerEmail: json["managerEmail"],
        startText: json["startText"],
        endText: json["endText"],
        createLeaveText: json["createLeaveText"],
      );

  Map<String, dynamic> toJson() => {
    "idLeave": idLeave,
    "idLeaveType": idLeaveType,
    "description": description,
    "start": start?.toIso8601String(),
    "end": end?.toIso8601String(),
    "idEmp": idEmp,
    "used": used,
    "quota": quota,
    "balance": balance,
    "remaining": remaining,
    "idManagerEmployee": idManagerEmployee,
    "approveDate": approveDate?.toIso8601String(),
    "isApprove": isApprove,
    "isFullDay": isFullDay,
    "workingStart": workingStart,
    "workingEnd": workingEnd,
    "isActive": isActive,
    "createDate": createDate?.toIso8601String(),
    "isWithdraw": isWithdraw,
    "filename": filename,
    "commentManager": commentManager,
    "name": name,
    "firstname": firstname,
    "lastname": lastname,
    "managerName": managerName,
    "managerEmail": managerEmail,
    "startText": startText,
    "endText": endText,
    "createLeaveText": createLeaveText,
  };
}