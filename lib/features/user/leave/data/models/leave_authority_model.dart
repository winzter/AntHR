import 'dart:convert';
import '../../domain/entities/entities.dart';

List<LeaveAuthorityModel> leaveAuthorityDataFromJson(String str) =>
    List<LeaveAuthorityModel>.from(
        json.decode(str).map((x) => LeaveAuthorityModel.fromJson(x)));

String leaveAuthorityDataToJson(List<LeaveAuthorityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveAuthorityModel extends LeaveAuthorityEntity{
  const LeaveAuthorityModel({
    required int? idLeaveType,
    required String? name,
    required int? indexLeave,
    required String? createBy,
    required DateTime? createDate,
    required dynamic updateBy,
    required dynamic updateDate,
    required int? minLeave,
    required int? idVendor,
    required int? isPaid,
    required int? isLeaveStep,
    required int? leaveValue,
    required int? carryValue,
    required String? gender,
    required int? isAfterProbation,
    required String? managerLv1,
    required dynamic managerLv2,
    required int? isActive,
    required dynamic isMain,
    required dynamic conditionType,
    required dynamic moreThanYears,
    required dynamic carry,
    required dynamic moreThanJobLevel,
    required dynamic idLeaveSteps,
    required double? remaining,
    required double? used,
 }):super(
    idLeaveType: idLeaveType,
    name: name,
    indexLeave: indexLeave,
    createBy: createBy,
    createDate: createDate,
    updateBy: updateBy,
    updateDate: updateDate,
    minLeave: minLeave,
    idVendor: idVendor,
    isPaid: isPaid,
    isLeaveStep: isLeaveStep,
    leaveValue: leaveValue,
    carryValue: carryValue,
    gender: gender,
    isAfterProbation: isAfterProbation,
    managerLv1: managerLv1,
    managerLv2: managerLv2,
    isActive: isActive,
    isMain: isMain,
    conditionType: conditionType,
    moreThanYears: moreThanYears,
    carry: carry,
    moreThanJobLevel: moreThanJobLevel,
    idLeaveSteps: idLeaveSteps,
  );

  factory LeaveAuthorityModel.fromJson(Map<String, dynamic> json) =>
      LeaveAuthorityModel(
        idLeaveType: json["idLeaveType"],
        name: json["name"],
        indexLeave: json["indexLeave"],
        createBy: json["createBy"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        updateBy: json["updateBy"],
        updateDate: json["updateDate"],
        minLeave: json["minLeave"],
        idVendor: json["idVendor"],
        isPaid: json["isPaid"],
        isLeaveStep: json["isLeaveStep"],
        leaveValue: json["leaveValue"],
        carryValue: json["carryValue"],
        gender: json["gender"],
        isAfterProbation: json["isAfterProbation"],
        managerLv1: json["managerLv1"],
        managerLv2: json["managerLv2"],
        isActive: json["isActive"],
        isMain: json["isMain"],
        conditionType: json["conditionType"],
        moreThanYears: json["moreThanYears"],
        carry: json["carry"],
        moreThanJobLevel: json["moreThanJobLevel"],
        idLeaveSteps: json["idLeaveSteps"],
        remaining: json["remaining"],
        used: json["used"],
      );

  Map<String, dynamic> toJson() => {
    "idLeaveType": idLeaveType,
    "name": name,
    "indexLeave": indexLeave,
    "createBy": createBy,
    "createDate": createDate?.toIso8601String(),
    "updateBy": updateBy,
    "updateDate": updateDate,
    "minLeave": minLeave,
    "idVendor": idVendor,
    "isPaid": isPaid,
    "isLeaveStep": isLeaveStep,
    "leaveValue": leaveValue,
    "carryValue": carryValue,
    "gender": gender,
    "isAfterProbation": isAfterProbation,
    "managerLv1": managerLv1,
    "managerLv2": managerLv2,
    "isActive": isActive,
    "isMain": isMain,
    "conditionType": conditionType,
    "moreThanYears": moreThanYears,
    "carry": carry,
    "moreThanJobLevel": moreThanJobLevel,
    "idLeaveSteps": idLeaveSteps,
    "remaining": remaining,
    "used": used
  };
}