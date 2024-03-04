import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import '../../domain/entities/attendance_entity.dart';
import '../../domain/use_cases/get_attendance.dart';



class AttendanceProvider extends ChangeNotifier {
  final GetAttendance getAttendance;

  AttendanceProvider({required this.getAttendance});
  List<AttendanceEntity> _attendanceData = [];
  final Map<int,List<mp.LatLng>> _allCheckInOutLocations = {};
  bool _isCheckIn = false;
  bool _isCheckOut = false;
  bool _isAtStatus = false;
  int? _idGpsLocation;

  List<AttendanceEntity> get attendanceData => _attendanceData;
  bool get isCheckIn => _isCheckIn;
  bool get isCheckOut => _isCheckOut;
  bool get isAtStatus => _isAtStatus;
  int? get idGpsLocation => _idGpsLocation;



  void isAt(bool isAt){
    _isAtStatus = isAt;
  }

  void setIsCheckIn(bool status){
    _isCheckIn = status;
  }

  void setIsCheckOut(bool status){
    _isCheckOut = status;
  }

  void setIdGpsLocation(int id){
    _idGpsLocation = id;
  }

  void locationCheck(double lat,double lng){
    _allCheckInOutLocations.forEach((key, value) {
      if(mp.PolygonUtil.containsLocation(mp.LatLng(lat, lng),value,true)){
        isAt(true);
        setIdGpsLocation(key);
      }
    });
  }

  void setCheckIsInPolygons(int index,List<mp.LatLng> data){
    _allCheckInOutLocations[index] = data;
  }

  Future<bool> getAttendanceData() async {
    try {
      var data = await getAttendance();
      _attendanceData = data.foldRight(_attendanceData, (r, previous) => r);
      _attendanceData[1].attendance!.round1!.checkIn != null ?
      setIsCheckIn(_attendanceData[1].attendance!.round1!.checkIn!.isCheckIn!.runtimeType == int?_attendanceData[1].attendance!.round1!.checkIn!.isCheckIn! == true:_attendanceData[1].attendance!.round1!.checkIn!.isCheckIn! == 1):
      // setIsCheckIn(true):
      setIsCheckIn(false);
      _attendanceData[1].attendance!.round1!.checkOut != null ?
      setIsCheckOut(_attendanceData[1].attendance!.round1!.checkOut!.isCheckIn!.runtimeType == int?_attendanceData[1].attendance!.round1!.checkOut!.isCheckIn! == true:_attendanceData[1].attendance!.round1!.checkOut!.isCheckIn! == 1):
      // setIsCheckOut(true):
      setIsCheckOut(false);
      notifyListeners();
      return false;
    } catch (error) {
      Logger().e("${error.toString()} attendance provider");
      notifyListeners();
      return true;
    }
  }



  static AttendanceProvider of(BuildContext context, {listen = true}) =>
      Provider.of<AttendanceProvider>(context, listen: listen);
}
