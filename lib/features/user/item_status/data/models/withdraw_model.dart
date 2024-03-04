import 'dart:convert';
import '../../domain/entities/entities.dart';

List<WithdrawModel> withdrawFromJson(String str) => List<WithdrawModel>.from(
    json.decode(str).map((x) => WithdrawModel.fromJson(x)));

String withdrawToJson(List<WithdrawModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WithdrawModel extends WithdrawEntity {
  const WithdrawModel({
    required int? idLeaveEmployeesWithdraw,
    required int? idLeave,
    required int? managerApprove,
    required int? isApprove,
    required DateTime? approveDate,
    required dynamic fillInCreate,
    required dynamic fillInApprove,
    required DateTime? createDate,
    required int? isActive,
    required dynamic commentManager,
    required int? idLeaveType,
    required String? name,
    required int? isFullDay,
    required DateTime? start,
    required DateTime? end,
    required String? managerName,
    required String? managerEmail,
    required String? startText,
    required String? endText,
    required String? approveDateText,
    required String? createDateText,
  }) : super(
          idLeaveEmployeesWithdraw: idLeaveEmployeesWithdraw,
          idLeave: idLeave,
          managerApprove: managerApprove,
          isApprove: isApprove,
          approveDate: approveDate,
          fillInCreate: fillInCreate,
          fillInApprove: fillInApprove,
          createDate: createDate,
          isActive: isActive,
          commentManager: commentManager,
          idLeaveType: idLeaveType,
          name: name,
          isFullDay: isFullDay,
          start: start,
          end: end,
          managerName: managerName,
          managerEmail: managerEmail,
          startText: startText,
          endText: endText,
          approveDateText: approveDateText,
          createDateText: createDateText,
        );

  factory WithdrawModel.fromJson(Map<String, dynamic> json) => WithdrawModel(
        idLeaveEmployeesWithdraw: json["idLeaveEmployeesWithdraw"],
        idLeave: json["idLeave"],
        managerApprove: json["managerApprove"],
        isApprove: json["isApprove"],
        approveDate: json["approveDate"] == null
            ? null
            : DateTime.parse(json["approveDate"]),
        fillInCreate: json["fillInCreate"],
        fillInApprove: json["fillInApprove"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        isActive: json["isActive"],
        commentManager: json["commentManager"],
        idLeaveType: json["idLeaveType"],
        name: json["name"],
        isFullDay: json["isFullDay"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        managerName: json["managerName"],
        managerEmail: json["managerEmail"],
        startText: json["startText"],
        endText: json["endText"],
        approveDateText: json["approveDateText"],
        createDateText: json["createDateText"],
      );

  Map<String, dynamic> toJson() => {
        "idLeaveEmployeesWithdraw": idLeaveEmployeesWithdraw,
        "idLeave": idLeave,
        "managerApprove": managerApprove,
        "isApprove": isApprove,
        "approveDate": approveDate?.toIso8601String(),
        "fillInCreate": fillInCreate,
        "fillInApprove": fillInApprove,
        "createDate": createDate?.toIso8601String(),
        "isActive": isActive,
        "commentManager": commentManager,
        "idLeaveType": idLeaveType,
        "name": name,
        "isFullDay": isFullDay,
        "start": start?.toIso8601String(),
        "end": end?.toIso8601String(),
        "managerName": managerName,
        "managerEmail": managerEmail,
        "startText": startText,
        "endText": endText,
        "approveDateText": approveDateText,
        "createDateText": createDateText,
      };
}
