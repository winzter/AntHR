import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable{
  final int? idEmp;
  final String? employeeId;
  final String? title;
  final String? firstname;
  final String? lastname;
  final String? personalId;
  final DateTime? birthday;
  final String? telephoneMobile;
  final String? email;
  final String? emergencyContact;
  final String? emergencyRelationship;
  final String? emergencyPhone;
  final String? address;
  final String? district;
  final String? province;
  final String? areaCode;
  final int? idCompany;
  final int? idVendor;
  final DateTime? hiringDate;
  final int? idPaymentType;
  final String? positionsName;
  final String? sectionName;
  final String? departmentName;
  final String? divisionName;
  final String? companyName;
  final String? jobGroupName;
  final String? vendorName;
  final String? jobLevelName;
  final String? personnelLevelName;
  final String? employeeTypeName;
  final int? managerLv1Id;
  final String? managerLv1Name;
  final String? managerLv1Position;
  final String? managerLv1Email;
  final int? managerLv2Id;
  final String? managerLv2Name;
  final String? managerLv2Position;
  final String? managerLv2Email;
  final List<dynamic>? education;

  const ProfileEntity({
    this.idEmp,
    this.employeeId,
    this.title,
    this.firstname,
    this.lastname,
    this.personalId,
    this.birthday,
    this.telephoneMobile,
    this.email,
    this.emergencyContact,
    this.emergencyRelationship,
    this.emergencyPhone,
    this.address,
    this.district,
    this.province,
    this.areaCode,
    this.idCompany,
    this.idVendor,
    this.hiringDate,
    this.idPaymentType,
    this.positionsName,
    this.sectionName,
    this.departmentName,
    this.divisionName,
    this.companyName,
    this.jobGroupName,
    this.vendorName,
    this.jobLevelName,
    this.personnelLevelName,
    this.employeeTypeName,
    this.managerLv1Id,
    this.managerLv1Name,
    this.managerLv1Position,
    this.managerLv1Email,
    this.managerLv2Id,
    this.managerLv2Name,
    this.managerLv2Position,
    this.managerLv2Email,
    this.education,
  });
  @override
  List<Object?> get props => [];
}

class EducationEntity extends Equatable{
  final String? degree;
  final String? university;
  final String? faculty;
  final String? major;
  final int? fromYear;
  final int? endYear;
  final String? gpa;

  const EducationEntity({
    this.degree,
    this.university,
    this.faculty,
    this.major,
    this.fromYear,
    this.endYear,
    this.gpa,
  });
  @override
  List<Object?> get props => [];
}