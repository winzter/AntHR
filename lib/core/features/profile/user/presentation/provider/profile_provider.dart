import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../domain/entity/login_token_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/usecase/get_profile.dart';

class ProfileProvider extends ChangeNotifier {
 final GetProfile getProfile;
 ProfileProvider({required this.getProfile});

 ProfileEntity _profileData = const ProfileEntity();
 UserTokenEntity _userTokenData = const UserTokenEntity();

 late Map<String, dynamic> _myToken;
 bool _isLoading = true;
 bool _isPayslipValidate = false;
 String? _telephoneMobile;
 String? _address;
 String? _district;
 String? _province;
 String? _areaCode;
 String? _emergencyContact;
 String? _emergencyRelationship;
 String? _emergencyPhone;


 ProfileEntity get profileData => _profileData;
 bool get isLoading => _isLoading;
 UserTokenEntity get userTokenData => _userTokenData;
 bool get isPayslipValidate => _isPayslipValidate;
 Map<String, dynamic> get myToken => _myToken;
 String? get telephoneMobile => _telephoneMobile;
 String? get address => _address;
 String? get district => _district;
 String? get province => _province;
 String? get areaCode => _areaCode;
 String? get emergencyContact => _emergencyContact;
 String? get emergencyRelationship => _emergencyRelationship;
 String? get emergencyPhone => _emergencyPhone;


 Future<bool> getProfileData() async {
  try {
   var data = await getProfile();
   _profileData = data.foldRight(_profileData, (r, previous) => r);
   _telephoneMobile = _profileData.telephoneMobile;
   _address = _profileData.address;
   _district = _profileData.district;
   _province = _profileData.province;
   _areaCode = _profileData.areaCode;
   _emergencyContact = _profileData.emergencyContact;
   _emergencyRelationship = _profileData.emergencyRelationship;
   _emergencyPhone = _profileData.emergencyPhone;
   notifyListeners();
   return false;
  } catch (error) {
   Logger().e(error);
   notifyListeners();
   return true;
  }
 }

 void setPayslipValidate(bool isPass) {
  _isPayslipValidate = isPass;
  notifyListeners();
 }

 void setIsLoading(bool isIt){
  try{
   _isLoading = isIt;
   Future.delayed(Duration.zero, () {
    notifyListeners();
   });
  }catch(e){
   Logger().e(e);
  }

 }

 void setPhoneNum(String num) {
  _telephoneMobile = num;
  notifyListeners();
 }

 void setAddress(
     String address, String district, String province, String zipcode) {
  _address = address;
  _district = district;
  _province = province;
  _areaCode = zipcode;
  notifyListeners();
 }

 void setEmergency(String contract, String relationship, String phone) {
  _emergencyContact = contract;
  _emergencyRelationship = relationship;
  _emergencyPhone = phone;
  notifyListeners();
 }

 void setUserTokenData(UserTokenEntity data) {
  _userTokenData = data;
 }

 static ProfileProvider of(BuildContext context, {listen = true}) =>
     Provider.of<ProfileProvider>(context, listen: listen);
}
