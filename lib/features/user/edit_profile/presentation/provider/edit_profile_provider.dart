import 'dart:developer';
import 'package:flutter/material.dart';
import '../../domain/usecases/use_cases.dart';

class EditProfileProvider extends ChangeNotifier{
  final SendEditPhoneNumber sendEditPhoneNumber;
  final SendEditAddress sendEditAddress;
  final ChangePassword changePassword;
  final SendEditEmergencyContract sendEditEmergencyContract;
  // final ChangePassword changePassword;

  EditProfileProvider({
    required this.sendEditPhoneNumber,
    required this.sendEditAddress,
    required this.sendEditEmergencyContract,
    required this.changePassword,
  });

  Future<void> sendEditPhoneNumberData(String phoneNum) async{
    try{
      await sendEditPhoneNumber(phoneNum);
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
    }
  }

  Future<void> sendEditAddressData(String address,String zipcode ,String district,String province) async{
    try{
      await sendEditAddress(address,district,province,zipcode);
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
    }
  }

  Future<void> sendEditEmergencyContractData(String emergencyName,String phoneNum,String emergencyRelationship) async{
    try{
      await sendEditEmergencyContract(emergencyName,phoneNum,emergencyRelationship);
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
    }
  }

  Future<bool> changePasswordData(String oldPass, String newPass,
      String confirm, BuildContext context) async {
    var res = await changePassword(oldPass, newPass, confirm);
    bool isError = true;
    res.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '${l.errMsgText}',
          style: const TextStyle(fontSize: 17,fontFamily: 'kanit'),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
      notifyListeners();
      isError = true;
    }, (r) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'เปลี่ยนรหัสผ่านสำเร็จ',
          style: TextStyle(fontSize: 17,fontFamily: 'kanit'),
        ),
        backgroundColor: Color(0xff6FC9E4),
        behavior: SnackBarBehavior.floating,
      ));
      notifyListeners();
      isError = false;
    });
    notifyListeners();
    return isError;
  }
}