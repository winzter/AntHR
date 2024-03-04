import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/features/attendance/data/models/attendance_model.dart';
import '../../../../../../core/features/attendance/domain/entities/attendance_entity.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../../domain/entities/entities.dart';
import '../../models/models.dart';

abstract class WorkingTimeRemoteDataSource{
  Future<List<EmployeesAttendanceModel>> getEmployeesAttendance(String start,);
  Future<List<EmployeesLeaveModel>> getEmployeesLeave(String start,);
  Future<List<EmployeesModel>> getEmployees();
  Future<List<PayrollSettingModel>> getPayrollSetting();
  Future<List<ReasonEntity>> getReasonManager();
  Future<List<AttendanceEntity>> getAttendanceEmpDate(int id,String start,String end);
  Future<void> sendTimeRequestManager(
      CalculateTimeEntity result,
      int idEmployee,
      int idRequestType,
      String requestReason,
      String otherReason,
      DateTime start,
      DateTime end,
      DateTime workEndDate,
      EmployeesEntity profileData
      );

}

class WorkingTimeRemoteDataSourceImpl implements WorkingTimeRemoteDataSource{
  final http.Client client;

  WorkingTimeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EmployeesAttendanceModel>> getEmployeesAttendance(String start) async{
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/attendance-once?date=$start&role=manager"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    print(response.body);
    return employeesAttendanceFromJson(response.body);
  }

  @override
  Future<List<EmployeesLeaveModel>> getEmployeesLeave(String start) async{
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/company/admin/employee/request/leave?date=$start"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return employeesLeaveModelFromJson(response.body);
  }

  @override
  Future<List<EmployeesModel>> getEmployees() async{
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/employees?filter=manager"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return employeesModelFromJson(response.body);
  }

  @override
  Future<List<PayrollSettingModel>> getPayrollSetting() async{
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/payroll-setting"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return payrollSettingEntityFromJson(response.body);
  }

  @override
  Future<List<AttendanceEntity>> getAttendanceEmpDate(int id, String start, String end) async{
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/attendance/$id?start=$start&end=$end"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return attendanceDataFromJson(response.body);
  }

  @override
  Future<List<ReasonEntity>> getReasonManager() async{
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/request/reason"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return reasonFromJson(response.body);
  }

  @override
  Future<void> sendTimeRequestManager(
      CalculateTimeEntity result,
      int idEmployee,
      int idRequestType,
      String requestReason,
      String otherReason,
      DateTime start,
      DateTime end,
      DateTime workEndDate,
      EmployeesEntity profileData
      ) async{

    Map<int,String> indexReason = {
      1:"ทำต่อเนื่องเร่งด่วน",
      2:"ทำงานกะในวันหยุด",
      3:"อบรม",
      4:"กิจกรรมอื่นๆ ของบริษัท",
      5:"ปฏิบัติงานภายนอก",
      6:"ลายนิ้วมือมีปัญหา/เครื่องสแกนนิ้วขัดข้อง",
      7:"เรียกตัวฉุกเฉิน",
      8:"อื่นๆ",
      9:"ทำงานเร่งด่วนช่วงพักเที่ยง",
      10:"StandBy On Call",

    };

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
        'idEmployees': idEmployee,
        'idRequestReason': indexReason.keys.firstWhere((k) => indexReason[k] == requestReason),
        'idRequestType': idRequestType,
        'isActive': 1,
        'isDoubleApproval': result.xOTHoliday != 0?1:0,
        'isManagerLV1Approve': null,
        'isManagerLV2Approve': null,
        'managerLV1ApproveBy': 0,
        // 'managerLV1ApproveBy': profileData.managerLv1Id,
        'managerLV2ApproveBy': 0,
        // 'managerLV2ApproveBy': profileData.managerLv2Id,
        'otherReason': otherReason,
        'start': start.toString(),
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
    } else if (response.statusCode >= 500) {
      throw ErrorException(message: "Server error status : ${response.statusCode}");
    } else {
      throw http.ClientException("E");
    }
  }
}