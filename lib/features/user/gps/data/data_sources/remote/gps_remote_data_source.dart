import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/location_model.dart';

abstract class GpsRemoteDatasource {
  Future<LineCheckInModel> getLocation(int idEmp);

  Future<void> sendLocation(
    String attendanceDateTime,
    int isCheckIn,
    int idAttendanceType,
    int? idGpsLocation,
    int idEmployee,
    int idCompany,
    String? address,
    double? lat,
    double? lng,
  );
}

class GpsRemoteDatasourceImpl implements GpsRemoteDatasource {
  final http.Client client;

  GpsRemoteDatasourceImpl({required this.client});

  @override
  Future<LineCheckInModel> getLocation(int idEmp) async {
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/line/profile/$idEmp?source=pwa&filter=${DateFormat("yyyy-MM-dd").format(DateTime.now())}"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return lineCheckInModelFromJson(response.body);
  }

  @override
  Future<void> sendLocation(
    String attendanceDateTime,
    int isCheckIn,
    int idAttendanceType,
    int? idGpsLocation,
    int idEmployee,
    int idCompany,
    String? address,
    double? lat,
    double? lng,
  ) async {
    final response = await client.post(
        Uri.parse("${NetworkAPI.baseURL}/api/line/attendance"),
        headers: {
          'x-access-token': '${await LoginStorage.readToken()}',
          "Content-Type": "application/json;charset=UTF-8",
        },
        body: jsonEncode({
        'attendanceDateTime': attendanceDateTime,
        'isCheckIn': isCheckIn==1,
        'idAttendanceType': idAttendanceType,
        'idGpsLocations': idGpsLocation,
        'idEmp': idEmployee,
        'idCompany': idCompany,
          if(address != null)
            'gpsAddress' : address,
          'latitude': lng,
          'longitude': lat,
        }));
    if (response.statusCode == 200) {
      log("CheckIn , CheckOut Success");
    } else {
      throw ErrorException(message: "Server Error Status :${response.statusCode}");
    }
  }
}
