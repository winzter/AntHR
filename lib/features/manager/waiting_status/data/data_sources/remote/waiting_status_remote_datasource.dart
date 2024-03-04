import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/models.dart';

abstract class WaitingStatusRemoteDataSource{
  Future<List<RequestTimeManagerModel>> getRequestTimeManager({String? start,String? end});
  Future<List<LeaveRequestManagerModel>> getLeaveRequestManager({String? start,String? end});
  Future<List<WithdrawLeaveManagerModel>> getWithdrawLeaveManager({String? start,String? end});
  Future<List<PayrollSettingModel>> getPayrollSetting();
  Future<void> isLeaveApprove(
     String commentManager,
     List<int> idLeave,
     int isApprove,
     List<int>? idLeaveEmployeesWithdraw
  );
  Future<void> isRequestTimeApprove(
      String commentManagerLV1,
      String commentManagerLV2,
      List<int> idRequestTimeLv1,
      int isManagerLV1Approve,
      int? isManagerLV2Approve,
      List<int> idRequestTimeLv2,
      );
}

class WaitingStatusRemoteDataSourceImpl implements WaitingStatusRemoteDataSource{
  final http.Client client;

  WaitingStatusRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LeaveRequestManagerModel>> getLeaveRequestManager({String? start,String? end}) async{
    final response = (start != null && end != null)?
    await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request/leave?filter=manager&start=$start&end=$end"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    )
    :await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request/leave?filter=manager"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return leaveRequestManagerFromJson(response.body);
  }

  @override
  Future<List<RequestTimeManagerModel>> getRequestTimeManager({String? start,String? end}) async{
    final response = (start != null && end != null)?
    await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request-time?filter=manager&start=$start&end=$end"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    )
    :await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request-time?filter=manager"),
      headers: {
        'x-access-token': '${await LoginStorage.readToken()}',
      },
    );
    return requestTimeManagerModelFromJson(response.body);
  }

  @override
  Future<List<WithdrawLeaveManagerModel>> getWithdrawLeaveManager({String? start,String? end}) async{
    final response = (start != null && end != null)?
    await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request-time/withdraw?filter=manager&start=$start&end=$end"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    )
    :await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request/leave/withdraw?filter=manager"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return withdrawManagerFromJson(response.body);
  }

  @override
  Future<List<PayrollSettingModel>> getPayrollSetting() async{
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/payroll-setting"),
      headers: {
        "x-access-token": "${await LoginStorage.readToken()}",
      },
    );
    return payrollSettingFromJson(response.body);
  }

  @override
  Future<void> isLeaveApprove(String commentManager,  List<int> idLeave,  int isApprove,  List<int>? idLeaveEmployeesWithdraw) async{
    final response = await client.put(
      Uri.parse("${NetworkAPI.baseURL}/api/request/leave/approve?filter=manager"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}',"Content-Type": "application/json;charset=UTF-8"},
      body: jsonEncode(
        [
          {
            "approveDate" : DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now()),
            "commentManager" : commentManager,
            "idLeave" : idLeave,
            "isApprove" : isApprove
          },
          {
            "commentManager" : commentManager,
            "idLeave" : [],
            "idLeaveEmployeesWithdraw" : idLeaveEmployeesWithdraw,
            "isApprove" : isApprove
          }
        ]
      )
    );
    if (response.statusCode == 200) {
      log("Leave Approve Success : ${response.body}");
    } else {
      throw ErrorException(message: "Server error status code : ${response.statusCode}");
    }
  }

  @override
  Future<void> isRequestTimeApprove(
      String commentManagerLV1,
      String commentManagerLV2,
      List<int> idRequestTimeLv1,
      int isManagerLV1Approve,
      int? isManagerLV2Approve,
      List<int> idRequestTimeLv2,
      ) async{
    final response = await client.put(
        Uri.parse("${NetworkAPI.baseURL}/api/request-time/approve?filter=manager"),
        headers: {
          'x-access-token': '${await LoginStorage.readToken()}',
          "Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode(
            [
              {
                "approveDate" : DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now()),
                "comment":commentManagerLV1 == ""?null:commentManagerLV1,
                "idRequestTimeLV1" : idRequestTimeLv1,
                "isManagerLV1Approve" : isManagerLV1Approve
              },
              {
                "approveDate" : DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now()),
                "comment":commentManagerLV2 == ""?null:commentManagerLV2,
                "idRequestTimeLV2" : idRequestTimeLv2,
                "isManagerLV2Approve" : isManagerLV2Approve
              },
              {
                "idRequestTime":[],
                "comment":commentManagerLV1 == ""?null:commentManagerLV1,
                "idRequestTimeWithdraw":[],
                "isApprove": isManagerLV1Approve,
              }
            ]
        )
    );
    if (response.statusCode == 200) {
      log("Request Time Approve Success : ${response.body}");
    } else {
      throw ErrorException(message: "Server error status code : ${response.statusCode}");
    }
  }

}