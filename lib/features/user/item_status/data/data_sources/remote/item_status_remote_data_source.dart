import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/models.dart';

abstract class ItemStatusRemoteDataSource {
  Future<List<LeaveModel>> getLeave(String startDate, String endDate);
  Future<List<RequestTimeModel>> getRequestTime(
      String startDate, String endDate);
  Future<List<WithdrawModel>> getWithdraw(String startDate, String endDate);
  Future<List<PayrollSettingModel>> getPayrollSetting();
  Future<void> deleteItem({LeaveModel? dataLeave, RequestTimeModel? dataRequestTime});
}

class ItemStatusRemoteDataSourceImpl implements ItemStatusRemoteDataSource {
  final http.Client client;

  ItemStatusRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LeaveModel>> getLeave(String startDate, String endDate) async {
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request/leave?filter=id&start=$startDate&end=$endDate"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );

    if (response.statusCode == 200) {

      return leaveFromJson(response.body);
    } else {
      throw ErrorException(message: '');
    }
  }

  @override
  Future<List<PayrollSettingModel>> getPayrollSetting() async {
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/payroll-setting"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );

    if (response.statusCode == 200) {
      return payrollSettingFromJson(response.body);
    } else {
      throw ErrorException(message: '');
    }
  }

  @override
  Future<List<RequestTimeModel>> getRequestTime(
      String startDate, String endDate) async {
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request-time?filter=id&start=$startDate&end=$endDate"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );

    if (response.statusCode == 200) {
      return requestTimeFromJson(response.body);
    } else {
      throw ErrorException(message: '');
    }
  }

  @override
  Future<List<WithdrawModel>> getWithdraw(
      String startDate, String endDate) async {
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request/leave/withdraw?filter=id&start=$startDate&end=$endDate"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );

    if (response.statusCode == 200) {
      return withdrawFromJson(response.body);
    } else {
      throw ErrorException(message: '');
    }
  }

  @override
  Future<void> deleteItem(
      {LeaveModel? dataLeave, RequestTimeModel? dataRequestTime}) async {
    Map data;
      dataLeave == null ?
      data = {
        "idRequestTime": dataRequestTime!.idRequestTime,
        "isApprove": dataRequestTime.isDoubleApproval == 1 ?
        dataRequestTime.isManagerLv2Approve:dataRequestTime.managerLv1Id,
        "managerApprove": dataRequestTime.isDoubleApproval == 1 ?
        dataRequestTime.managerLv2Id :dataRequestTime.managerLv1Id  //managerId
      }:
      data = {
        "idLeave": dataLeave.idLeave,
        "isApprove": dataLeave.isApprove,
        "managerApprove": dataLeave.idManagerEmployee
      };
    log("$data");
    final response = await client.put(
        Uri.parse(dataLeave == null
            ? "${NetworkAPI.baseURL}/api/request-time/withdraw"
            : "${NetworkAPI.baseURL}/api/request/leave/withdraw"),
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          'x-access-token': '${await LoginStorage.readToken()}'
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      log("Delete Item List Success");
    } else {
      throw ErrorException(message: '');
    }
  }
}
