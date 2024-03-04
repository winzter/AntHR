import 'dart:convert';

import '../../domain/entities/location_entity.dart';

LineCheckInModel lineCheckInModelFromJson(String str) => LineCheckInModel.fromJson(json.decode(str));



class LineCheckInModel extends LineCheckIn{

  const LineCheckInModel({
    required super.idCompany,
    required super.firstname,
    required super.lastname,
    required super.idEmp,
    required super.mainWorkingLocationPoint,
    required super.methodAttendance,
    required super.groupGpsLocations,
    required super.attendance,
  });

  factory LineCheckInModel.fromJson(Map<String, dynamic> json) => LineCheckInModel(
    idCompany: json["idCompany"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    idEmp: json["idEmp"],
    mainWorkingLocationPoint: json["mainWorkingLocationPoint"],
    methodAttendance: json["methodAttendance"],
    groupGpsLocations: json["groupGpsLocations"] == null || json["groupGpsLocations"].runtimeType == bool ? [] : List<GroupGpsLocationModel>.from(json["groupGpsLocations"]!.map((x) => GroupGpsLocationModel.fromJson(x))),
    attendance: json["attendance"] == null ? [] : List<dynamic>.from(json["attendance"]!.map((x) => x)),
  );
}

class GroupGpsLocationModel extends GroupGpsLocation{

  const GroupGpsLocationModel({
    required super.idGroupGpsLocations,
    required super.name,
    required super.idCompany,
    required super.idVendor,
    required super.createBy,
    required super.createDate,
    required super.editBy,
    required super.editDate,
    required super.deleteBy,
    required super.deleteDate,
    required super.isActive,
    required super.locations,
  });

  factory GroupGpsLocationModel.fromJson(Map<String, dynamic> json) => GroupGpsLocationModel(
    idGroupGpsLocations: json["idGroupGpsLocations"],
    name: json["name"],
    idCompany: json["idCompany"],
    idVendor: json["idVendor"],
    createBy: json["createBy"],
    createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
    editBy: json["editBy"],
    editDate: json["editDate"],
    deleteBy: json["deleteBy"],
    deleteDate: json["deleteDate"],
    isActive: json["isActive"],
    locations: json["locations"] == null ? [] : List<LocationModel>.from(json["locations"]!.map((x) => LocationModel.fromJson(x))),
  );

}

class LocationModel extends Location{


  const LocationModel({
    required super.name,
    required super.positions,
    required super.idGpsLocations,
    required super.idGroupGpsLocations,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    name: json["name"],
    positions: json["positions"] == null ? [] : List<PositionModel>.from(json["positions"]!.map((x) => PositionModel.fromJson(x))),
    idGpsLocations: json["idGpsLocations"],
    idGroupGpsLocations: json["idGroupGpsLocations"],
  );
}

class PositionModel extends Position {

  const PositionModel({
    required super.lat,
    required super.lng,
    required super.idGpsPosition,
    required super.idGpsLocations,
    required super.idGroupGpsLocations,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) => PositionModel(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    idGpsPosition: json["idGpsPosition"],
    idGpsLocations: json["idGpsLocations"],
    idGroupGpsLocations: json["idGroupGpsLocations"],
  );

}
