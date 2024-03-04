import 'dart:convert';
import '../../domain/entities/manager_profile_entity.dart';

ManagerProfileModel managerProfileEntityFromJson(String str) => ManagerProfileModel.fromJson(json.decode(str));

// String managerProfileEntityToJson(ManagerProfileEntity data) => json.encode(data.toJson());

class ManagerProfileModel extends ManagerProfileEntity{


  const ManagerProfileModel({
    required int? idManagerEmployee,
    required String? name,
    required String? positionsName,
    required String? email,
    required int? idUsers,
    required int? idCompany,
    required int? isActive,
    required dynamic userLineId,
  }):super(
      idManagerEmployee:idManagerEmployee,
      name:name,
      positionsName:positionsName,
      email: email,
      idUsers:idUsers,
      idCompany:idCompany,
      isActive:isActive,
      userLineId:userLineId
  );

  factory ManagerProfileModel.fromJson(Map<String, dynamic> json) => ManagerProfileModel(
    idManagerEmployee: json["idManagerEmployee"],
    name: json["name"],
    positionsName: json["positionsName"],
    email: json["email"],
    idUsers: json["idUsers"],
    idCompany: json["idCompany"],
    isActive: json["isActive"],
    userLineId: json["userLineID"],
  );
  Map<String, dynamic> toJson() => {
    "idManagerEmployee": idManagerEmployee,
    "name": name,
    "positionsName": positionsName,
    "email": email,
    "idUsers": idUsers,
    "idCompany": idCompany,
    "isActive": isActive,
    "userLineID": userLineId,
  };
}
