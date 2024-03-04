import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/features/profile/user/domain/entity/profile_entity.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../../domain/entities/entities.dart';
import '../../models/models.dart';

abstract class TimeLineRemoteDataSource{
  Future<List<TimeLineModel>> getAttendance();
  Future<List<PayrollSettingTimeLineModel>> getPayrollSettingTimeLine();
  Future<List<TimeLineModel>> getAttendanceByDate(String start,String end);
  Future<List<ReasonsTimeLineRequest>> getReasonsTimeLineRequest(int idCompany,int idVendor);
  Future<void> sendTimeRequest(
      CalculateTimeEntity result,
      int idEmployee,
      int idRequestType,
      int idRequestReason,
      String otherReason,
      DateTime start,
      DateTime end,
      DateTime workEndDate,
      ProfileEntity profileData
      );
}

class TimeLineRemoteDataSourceImpl implements TimeLineRemoteDataSource{
  final http.Client client;

  TimeLineRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TimeLineModel>> getAttendance() async{
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/attendance?start=${DateFormat('yyyy-MM-dd').format(DateTime.now())}&end=${DateFormat('yyyy-MM-dd').format(DateTime.now())}"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      return getAttendanceDataFromJson(response.body);
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<List<TimeLineModel>> getAttendanceByDate(String start, String end) async{
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/attendance?start=$start&end=$end"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      return getAttendanceDataFromJson(response.body);
    } else if (response.statusCode >= 500) {
      throw ErrorException(message: "Server error occurred");
    } else {
      throw http.ClientException("Connection timed out");
    }
  }

  @override
  Future<void> sendTimeRequest(
      CalculateTimeEntity result,
      int idEmployee,
      int idRequestType,
      int idRequestReason,
      String otherReason,
      DateTime start,
      DateTime end,
      DateTime workEndDate,
      ProfileEntity profileData
      ) async{


    var response = await client.post(
      Uri.parse("${NetworkAPI.baseURL}/api/requestTimes"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": "${await LoginStorage.readToken()}"
      },
      body: jsonEncode({
        'amountHours': result.xOT+result.xWorkingMonthlyHoliday+result.xWorkingDailyHoliday+result.xOTHoliday,
        'approvalLevel': result.xOTHoliday != 0?2:1,
        'end': end.toString(),
        'idEmp': idEmployee,
        'idRequestReason': idRequestReason,
        'idRequestType': idRequestType,
        'isActive': 1,
        'isDoubleApproval': result.xOTHoliday != 0?1:0,
        'isManagerLV1Approve': null,
        'isManagerLV2Approve': null,
        'managerLV1ApproveBy': profileData.managerLv1Id,
        'managerLV2ApproveBy': profileData.managerLv2Id,
        'otherReason': otherReason,
        'start': start.toString(),
        'updateBy': await LoginStorage.readIdUsers(),
        'updateDate': DateTime.now().toString(),
        'workDate': DateFormat('yyyy-MM-dd').format(workEndDate),
        'xOT': result.xOT,
        'xOTHoliday': result.xOTHoliday,
        'xWorkingDailyHoliday': result.xWorkingDailyHoliday,
        'xWorkingMonthlyHoliday': result.xWorkingMonthlyHoliday
      }
      ),
    );
    if (response.statusCode == 200) {
      log("Send Time Request Success");
    } else if (response.statusCode == 500) {
      throw ErrorException(message: "มีรายการคำขอซ้ำกับรายการที่มีอยู่");
    }
  }

  @override
  Future<List<PayrollSettingTimeLineModel>> getPayrollSettingTimeLine() async{
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/payroll-setting"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      return payrollSettingTimeLineModelFromJson(response.body);
    } else if (response.statusCode >= 500) {
      throw ErrorException(message: "Server error occurred");
    } else {
      throw http.ClientException("Connection timed out");
    }
  }

  @override
  Future<List<ReasonsTimeLineRequest>> getReasonsTimeLineRequest(int idCompany,int idVendor) async{
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request-time/vendor-reason?idVendor=$idVendor&idCompany=$idCompany"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return reasonsTimeLineRequestFromJson(response.body);
  }
  
}