import 'dart:convert';
import '../../domain/entities/reason_entity.dart';

List<ReasonsTimeLineRequestModel> reasonsTimeLineRequestFromJson(String str) => List<ReasonsTimeLineRequestModel>.from(json.decode(str).map((x) => ReasonsTimeLineRequestModel.fromJson(x)));

String reasonsTimeLineRequestToJson(List<ReasonsTimeLineRequestModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReasonsTimeLineRequestModel extends ReasonsTimeLineRequest{
  ReasonsTimeLineRequestModel({
    required super.idRequestReason,
    required super.name,
    required super.idCompany,
    required super.idVendor,
    required super.indexReason,
    required super.idRequestType,
    required super.isPayShift,
    required super.isBreak,
    required super.isOt,
    required super.isResign,
    required super.isActive,
  });

  factory ReasonsTimeLineRequestModel.fromJson(Map<String, dynamic> json) => ReasonsTimeLineRequestModel(
    idRequestReason: json["idRequestReason"],
    name: json["name"],
    idCompany: json["idCompany"],
    idVendor: json["idVendor"],
    indexReason: json["indexReason"],
    idRequestType: json["idRequestType"],
    isPayShift: json["isPayShift"],
    isBreak: json["isBreak"],
    isOt: json["isOT"],
    isResign: json["isResign"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "idRequestReason": idRequestReason,
    "name": name,
    "idCompany": idCompany,
    "idVendor": idVendor,
    "indexReason": indexReason,
    "idRequestType": idRequestType,
    "isPayShift": isPayShift,
    "isBreak": isBreak,
    "isOT": isOt,
    "isResign": isResign,
    "isActive": isActive,
  };
}
