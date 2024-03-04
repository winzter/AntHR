import 'package:equatable/equatable.dart';

class EmployeesEntity extends Equatable{
  final int? idEmp;
  final String? employeeId;
  final String? title;
  final String? firstname;
  final String? lastname;
  final String? telephoneMobile;
  final String? positionsName;
  final String? sectionName;
  final dynamic departmentName;
  final int? idCompany;
  final dynamic divisionName;
  final String? companyName;
  final dynamic jobGroupName;
  final String? vendorName;
  final dynamic jobLevelName;
  final dynamic personnelLevelName;
  final String? employeeTypeName;
  final String? paymentTypeName;

  const EmployeesEntity({
    this.idEmp,
    this.employeeId,
    this.title,
    this.firstname,
    this.lastname,
    this.telephoneMobile,
    this.positionsName,
    this.sectionName,
    this.departmentName,
    this.idCompany,
    this.divisionName,
    this.companyName,
    this.jobGroupName,
    this.vendorName,
    this.jobLevelName,
    this.personnelLevelName,
    this.employeeTypeName,
    this.paymentTypeName,
  });

  @override
  List<Object?> get props => [
    idEmp,
    employeeId,
    title,
    firstname,
    lastname,
    telephoneMobile,
    positionsName,
    sectionName,
    departmentName,
    idCompany,
    divisionName,
    companyName,
    jobGroupName,
    vendorName,
    jobLevelName,
    personnelLevelName,
    employeeTypeName,
    paymentTypeName,
  ];
}
