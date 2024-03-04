import 'dart:developer';

import 'package:http/http.dart' as http;
import '../../../../../error/exception.dart';
import '../../../../../storage/secure_storage.dart';
import '../models/manager_profile_model.dart';

abstract class ManagerProfileRemoteDataSource{
  Future<ManagerProfileModel> getManagerProfile();
}

class ManagerProfileRemoteDataSourceImpl implements ManagerProfileRemoteDataSource{
  final http.Client client;

  ManagerProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<ManagerProfileModel> getManagerProfile() async{
    final response = await client.get(
      Uri.parse(
          "https://anthr-320007.uc.r.appspot.com/api/users/profile"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );

    if (response.statusCode == 200) {
      return managerProfileEntityFromJson(response.body);
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }
}