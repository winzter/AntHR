import 'package:http/http.dart' as http;
import '../../../../../../constanst/network_api.dart';
import '../../../../../../storage/secure_storage.dart';
import '../../model/profile_model.dart';

abstract class ProfileRemoteDataSource{
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource{
  final http.Client client;

  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<ProfileModel> getProfile() async{
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/users/profile"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return profileFromJson(response.body);
  }
}