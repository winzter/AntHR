import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/models.dart';
import 'package:http/http.dart' as http;
import '../leave_request.dart';

abstract class LeaveRemoteDataSource {
  Future<List<LeaveHistoryModel>> getLeaveHistory();
  Future<void> deleteLeaveHistory(int idLeave);
  Future<List<LeaveAuthorityModel>> getLeaveAuthority();
  Future<List<DayCannotLeaveModel>> getDayCannotLeave(DateTime start,DateTime end);
  Future<void> sendLeaveRequest(LeaveRequest data);

}

class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  final http.Client client;
  final Dio dio;

  LeaveRemoteDataSourceImpl( {required this.client,required this.dio,});

  @override
  Future<void> deleteLeaveHistory(int idLeave) async {
    final response = await client.put(
        Uri.parse("${NetworkAPI.baseURL}/api/request/leave/withdraw"),
        headers: {
          'x-access-token': '${await LoginStorage.readToken()}',
          "Content-Type": "application/json;charset=UTF-8",
        },
        body: jsonEncode({'idLeave': idLeave}));
    if (response.statusCode == 200) {
      log("Delete Leave History Success");
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<List<LeaveAuthorityModel>> getLeaveAuthority() async {
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/employee/leave"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );

    if (response.statusCode == 200) {
      return leaveAuthorityDataFromJson(response.body);
    } else {
      throw ErrorException(message: '');
    }
  }

  @override
  Future<List<LeaveHistoryModel>> getLeaveHistory() async {
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request/leave/year?filter=${DateFormat('yyyy').format(DateTime.now())}"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );

    if (response.statusCode == 200) {
      return leaveHistoryDataFromJson(response.body);
    } else {
      throw ErrorException(message: '');
    }
  }

  @override
  Future<List<DayCannotLeaveModel>> getDayCannotLeave(DateTime start, DateTime end) async{
    try{
      final response = await client.get(
        Uri.parse("${NetworkAPI.baseURL}/api/pattern/leave?start=${DateFormat('yyyy-MM-dd').format(start)}&end=${DateFormat('yyyy-MM-dd').format(end)}"),
        headers: {'x-access-token': '${await LoginStorage.readToken()}'},
      );
      if (response.statusCode == 200) {
        return dayCannotLeaveModelFromJson(response.body);
      } else {
        throw ErrorException(message: "Server error occurred");
      }
    }catch (error){
      log("Errors: $error");
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<void> sendLeaveRequest(LeaveRequest data) async {
    log(data.leaveName);
    FormData sendData = FormData.fromMap({
      'idLeaveType': data.idLeaveType.toString(),
      'description':  data.description==null?null.toString():'"${data.description}"',
      'start': '"${data.start}"',
      'end': '"${data.end}"',
      'idEmp': data.idEmp.toString(),
      'used': data.used.toString(),
      'quota': data.quota.toString(),
      'balance': data.used.toString(),
      'remaining': data.remaining.toStringAsFixed(2),
      'idManagerEmployee': data.idManagerEmployee.toString(),
      'isApprove': null.toString(),
      'isFullDay': data.isFullDay.toString(),
      'isActive': data.isActive.toString(),
      'managerLV1Email': data.managerLV1Email != null?'"${data.managerLV1Email}"': null.toString(),
      // 'leaveName': data.leaveName.toString(),
      if (data.file != null)
        'file': await MultipartFile.fromFile(data.file!.path!,
          filename: data.file!.name)
    });
    try{
      var response = await dio.post("${NetworkAPI.baseURL}/api/employee/leave",
          options: Options(
            headers: {
            "x-access-token": "${await LoginStorage.readToken()}",
            'Content-Type': 'multipart/form-data',
          },
          ),
          data: sendData);
      if (response.statusCode == 200 && response.data.toString() != "{errorCode: ERROR_DUPLICATED}") {
        log("Send LeaveRequest Success");
      } else {
        throw ErrorException(message: "Server error occurred");
      }
    }catch (error){
      log("Errors: $error");
      throw ErrorException(message: "Server error occurred");
    }
  }
}
