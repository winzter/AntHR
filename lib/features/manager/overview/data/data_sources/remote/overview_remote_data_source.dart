import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/cost_model.dart';
import '../../models/models.dart';

abstract class OverviewRemoteDataSource {
  Future<OverviewModel> getOverview(String month,String year, int? idDepartment, int? idSection);
  Future<OvertimeModel> getOverTime(String month,String year, int? idDepartment, int? idSection);
  Future<WorkingTimeModel> getWorkingTime(String month,String year, int? idDepartment, int? idSection);
  Future<CostModel> getCost(String month,String year, int? idDepartment, int? idSection);
  Future<List<DepartmentModel>> getDepartment();
}

class OverviewRemoteDataSourceImpl implements OverviewRemoteDataSource{

  final Dio dio;

  OverviewRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<DepartmentModel>> getDepartment() async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/departments?idCompany=8',
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    if (response.statusCode == 200) {
      return departmentModelFromJson(jsonEncode(response.data));
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<OverviewModel> getOverview(String month, String year,int? idDepartment,int? idSection) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/dashboard/overview',
        queryParameters: {
          'mode':'manager',
          'month': month,
          'year': year,
          if(idDepartment != null && idDepartment != 999)
            'idDepartment':idDepartment,
          if(idSection != null && idSection != 999)
            'idSection':idSection
        },
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    if (response.statusCode == 200) {
      return overviewModelFromJson(jsonEncode(response.data));
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<OvertimeModel> getOverTime(String month, String year, int? idDepartment, int? idSection) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/dashboard/overtime',
        queryParameters: {
          'mode':'manager',
          'month': month,
          'year': year,
          if(idDepartment != null && idDepartment != 999)
            'idDepartment':idDepartment,
          if(idSection != null && idSection != 999)
            'idSection':idSection
        },
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    if (response.statusCode == 200) {
      return overtimeModelFromJson(jsonEncode(response.data));
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<WorkingTimeModel> getWorkingTime(String month, String year, int? idDepartment, int? idSection) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/dashboard/workingtime',
        queryParameters: {
          'mode':'manager',
          'month': month,
          'year': year,
          if(idDepartment != null && idDepartment != 999)
            'idDepartment':idDepartment,
          if(idSection != null && idSection != 999)
            'idSection':idSection
        },
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    if (response.statusCode == 200) {
      return workingTimeModelFromJson(jsonEncode(response.data));
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<CostModel> getCost(String month, String year, int? idDepartment, int? idSection) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/dashboard/cost',
        queryParameters: {
          'mode':'manager',
          'month': month,
          'year': year,
          if(idDepartment != null && idDepartment != 999)
            'idDepartment':idDepartment,
          if(idSection != null && idSection != 999)
            'idSection':idSection
        },
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    if (response.statusCode == 200) {
      return costModelFromJson(jsonEncode(response.data));
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }
}