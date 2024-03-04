import 'dart:convert';
import '../../domain/entities/entities.dart';


List<EmployeesModel> employeesModelFromJson(String str) => List<EmployeesModel>.from(json.decode(str).map((x) => EmployeesModel.fromJson(x)));

String employeesModelToJson(List<EmployeesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeesModel extends EmployeesEntity {


  EmployeesModel({
    required int? idEmp,
    required String? employeeId,
    required String? title,
    required String? firstname,
    required String? lastname,
    required String? telephoneMobile,
    required String? positionsName,
    required String? sectionName,
    required dynamic departmentName,
    required int? idCompany,
    required dynamic divisionName,
    required String? companyName,
    required dynamic jobGroupName,
    required String? vendorName,
    required dynamic jobLevelName,
    required dynamic personnelLevelName,
    required String? employeeTypeName,
    required String? paymentTypeName,
  }):super(
    idEmp:idEmp,
    employeeId:employeeId,
    title:title,
    firstname:firstname,
    lastname:lastname,
    telephoneMobile:telephoneMobile,
    positionsName:positionsName,
    sectionName:sectionName,
    departmentName:departmentName,
    idCompany:idCompany,
    divisionName:divisionName,
    companyName:companyName,
    jobGroupName:jobGroupName,
    vendorName:vendorName,
    jobLevelName:jobLevelName,
    personnelLevelName:personnelLevelName,
    employeeTypeName:employeeTypeName,
    paymentTypeName:paymentTypeName,
  );

  factory EmployeesModel.fromJson(Map<String, dynamic> json) => EmployeesModel(
    idEmp: json["idEmp"],
    employeeId: json["employeeId"],
    title: json["title"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    telephoneMobile: json["telephoneMobile"],
    positionsName: json["positionsName"],
    sectionName: json["sectionName"],
    departmentName: json["departmentName"],
    idCompany: json["idCompany"],
    divisionName: json["divisionName"],
    companyName: json["companyName"],
    jobGroupName: json["jobGroupName"],
    vendorName: json["vendorName"],
    jobLevelName: json["jobLevelName"],
    personnelLevelName: json["personnelLevelName"],
    employeeTypeName: json["employeeTypeName"],
    paymentTypeName: json["paymentTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "idEmp": idEmp,
    "employeeId": employeeId,
    "title": title,
    "firstname": firstname,
    "lastname": lastname,
    "telephoneMobile": telephoneMobile,
    "positionsName": positionsName,
    "sectionName": sectionName,
    "departmentName": departmentName,
    "idCompany": idCompany,
    "divisionName": divisionName,
    "companyName": companyName,
    "jobGroupName": jobGroupName,
    "vendorName": vendorName,
    "jobLevelName": jobLevelName,
    "personnelLevelName": personnelLevelName,
    "employeeTypeName": employeeTypeName,
    "paymentTypeName": paymentTypeName,
  };
}
