import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../../constanst/network_api.dart';
import '../../../../../error/exception.dart';
import '../../../../../storage/secure_storage.dart';
import '../../../domain/entities/login_entity.dart';
import '../../models/login_model.dart';


abstract class LoginApi{
  Future<LoginEntity> login(String username,String password);
}

class LoginApiImpl implements LoginApi{
  final http.Client client;
  LoginApiImpl({required this.client});

  @override
  Future<LoginEntity> login(username,password) async{
    var url = Uri.parse("${NetworkAPI.baseURL}/api/auth/signin");
    Map tokenData;
    final res = await client.post(url,
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
        },
        body: jsonEncode({
          "username":username,
          "password":password
        }));
    if(res.statusCode == 200){
      var data = loginFromJson(res.body);
      tokenData = JwtDecoder.decode(data.accessToken!);
      await LoginStorage.setMapData(
          tokenData['idRoles'],
          tokenData['idUsers'],
          tokenData['employeeId'],
          tokenData['idEmp'],
          tokenData['idVendor'],
          tokenData['idCompany'],
          tokenData['iat'],
          tokenData['exp']
      );
      await LoginStorage.setToken(data.accessToken!);
      return LoginEntity(
          roles: data.roles,
          accessToken: data.accessToken);
    }else{
      throw ErrorException(message: res.statusCode.toString());
    }
  }

}

