part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();
}

class GetGPSLocation extends GpsEvent{

  final int idEmp;

  const GetGPSLocation({required this.idEmp});
  @override
  List<Object?> get props => [idEmp];
}

class SendGPSLocation extends GpsEvent{
  final String attendanceDateTime;
  final int isCheckIn;
  final int idAttendanceType;
  final int? idGpsLocation;
  final int idEmployee;
  final  int idCompany;
  final double? lat;
  final double? lng;
  final List<geo.Placemark>? address;

  const SendGPSLocation({
    required this.attendanceDateTime,
    required this.isCheckIn,
    required this.idAttendanceType,
    required this.idGpsLocation,
    required this.idEmployee,
    required this.idCompany,
    this.lat,
    this.lng,
    this.address
  });
  @override
  List<Object?> get props => [
    attendanceDateTime,
    isCheckIn,
    idAttendanceType,
    idGpsLocation,
    idEmployee,
    idCompany,
    lat,
    lng,
    address,
  ];
}

class ChangeLocation extends GpsEvent{
  final String selectedLocation;
  const ChangeLocation({required this.selectedLocation});
  @override
  List<Object?> get props => [selectedLocation];
}

class GetCurrentAddress extends GpsEvent {
  final double lat;
  final double lng;

  const GetCurrentAddress({required this.lat, required this.lng});

  @override
  List<Object?> get props => [lat, lng];
}
