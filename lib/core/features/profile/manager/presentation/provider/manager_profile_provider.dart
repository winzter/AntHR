import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/manager_profile_entity.dart';
import '../../domain/usecases/get_manager_profile.dart';

class ManagerProfileProvider extends ChangeNotifier {
 final GetManagerProfile getManagerProfile;
 ManagerProfileProvider({required this.getManagerProfile});

 ManagerProfileEntity _profileData = const ManagerProfileEntity();


 ManagerProfileEntity get profileData => _profileData;


 Future<void> getManagerProfileData() async {
  try {
   var data = await getManagerProfile();
   _profileData = data.foldRight(_profileData, (r, previous) => r);
   notifyListeners();
  } catch (error) {
   log(error.toString());
   notifyListeners();
  }
 }


 static ManagerProfileProvider of(BuildContext context, {listen = true}) =>
     Provider.of<ManagerProfileProvider>(context, listen: listen);
}
