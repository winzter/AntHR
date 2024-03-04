import 'package:http/http.dart' as http;
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/shift_ot_model.dart';

abstract class SummaryShiftAndOTRemoteDatasource{
  Future<ShiftAndOtModel> getSummaryShiftAndOt(String start);
}

class SummaryShiftAndOTRemoteDatasourceImpl implements SummaryShiftAndOTRemoteDatasource{
  final http.Client client;

  SummaryShiftAndOTRemoteDatasourceImpl({required this.client});

  @override
  Future<ShiftAndOtModel> getSummaryShiftAndOt(String start) async{
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/payment/summary-time?start=$start&end=$start"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {

      return shiftAndOtModelFromJson(response.body);
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

}