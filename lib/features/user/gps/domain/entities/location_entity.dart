import 'package:equatable/equatable.dart';

class LineCheckIn extends Equatable{
  final int? idCompany;
  final String? firstname;
  final String? lastname;
  final int? idEmp;
  final dynamic mainWorkingLocationPoint;
  final dynamic methodAttendance;
  final List<GroupGpsLocation>? groupGpsLocations;
  final List<dynamic>? attendance;

  const LineCheckIn({
    this.idCompany,
    this.firstname,
    this.lastname,
    this.idEmp,
    this.mainWorkingLocationPoint,
    this.methodAttendance,
    this.groupGpsLocations,
    this.attendance,
  });


  @override
  List<Object?> get props => [
    idCompany,
    firstname,
    lastname,
    idEmp,
    mainWorkingLocationPoint,
    methodAttendance,
    groupGpsLocations,
    attendance
  ];
}

class GroupGpsLocation extends Equatable{
  final int? idGroupGpsLocations;
  final String? name;
  final int? idCompany;
  final int? idVendor;
  final dynamic createBy;
  final DateTime? createDate;
  final dynamic editBy;
  final dynamic editDate;
  final dynamic deleteBy;
  final dynamic deleteDate;
  final int? isActive;
  final List<Location>? locations;

  const GroupGpsLocation({
    this.idGroupGpsLocations,
    this.name,
    this.idCompany,
    this.idVendor,
    this.createBy,
    this.createDate,
    this.editBy,
    this.editDate,
    this.deleteBy,
    this.deleteDate,
    this.isActive,
    this.locations,
  });

  @override
  List<Object?> get props => [
    idGroupGpsLocations,
    name,
    idCompany,
    idVendor,
    createBy,
    createDate,
    editBy,
    editDate,
    deleteBy,
    deleteDate,
    isActive,
    locations,
  ];

}

class Location extends Equatable{
  final String? name;
  final List<Position>? positions;
  final int? idGpsLocations;
  final int? idGroupGpsLocations;

  const Location({
    this.name,
    this.positions,
    this.idGpsLocations,
    this.idGroupGpsLocations,
  });

  @override
  List<Object?> get props => [
    name,
    positions,
    idGpsLocations,
    idGroupGpsLocations,
  ];
}

class Position extends Equatable{
  final double? lat;
  final double? lng;
  final int? idGpsPosition;
  final int? idGpsLocations;
  final int? idGroupGpsLocations;

  const Position({
    this.lat,
    this.lng,
    this.idGpsPosition,
    this.idGpsLocations,
    this.idGroupGpsLocations,
  });

  @override
  List<Object?> get props => [
    lat,
    lng,
    idGpsPosition,
    idGpsLocations,
    idGroupGpsLocations,
  ];
}
