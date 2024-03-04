import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../../item_status/domain/entities/entities.dart';
import '../../../item_status/domain/usecases/use_cases.dart';


class WaitingProvider extends ChangeNotifier {
  final GetLeaveData getLeaveData;
  final GetRequestTimeData getRequestTimeData;
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month, 1),
      end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0));
  List<RequestTimeEntity> _requestTime = [];
  List<RequestTimeEntity> _requestTimeNotApprove = [];
  List<RequestTimeEntity> _requestTimeApprove = [];
  List<LeaveEntity> _leaveHistory = [];
  List<LeaveEntity> _leaveNotApprove = [];
  List<LeaveEntity> _leaveApprove = [];



  WaitingProvider({required this.getLeaveData,required this.getRequestTimeData, });

  List<LeaveEntity> get leaveHistory => _leaveHistory;
  List<RequestTimeEntity> get requestTime => _requestTime;
  List<RequestTimeEntity> get requestTimeNotApprove => _requestTimeNotApprove;
  List<RequestTimeEntity> get requestTimeApprove => _requestTimeApprove;
  List<LeaveEntity> get leaveNotApprove => _leaveNotApprove;
  List<LeaveEntity> get leaveApprove => _leaveApprove;



  Future<bool> getLeave() async {
    try {
      DateTime start = DateTime(DateTime.now().year, DateTime.now().month, 1);
      DateTime end = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

      var data = await getLeaveData(
          DateFormat("yyyy-MM-dd").format(start),
          DateFormat("yyyy-MM-dd").format(end)
      );
      _leaveHistory = data.foldRight(_leaveHistory, (r, previous) => r);
      notifyListeners();
      return false;
    } catch (error) {
     Logger().e(error);
      notifyListeners();
      return true;
    }
  }

  Future<bool> getRequestTime() async {
    try {
      var data = await getRequestTimeData(
         DateFormat("yyyy-MM-dd").format(dateRange.start),
         DateFormat("yyyy-MM-dd").format(dateRange.end)
      );
      _requestTime = data.foldRight(_requestTime, (r, previous) => r);
      notifyListeners();
      return false;
    } catch (error) {
      Logger().e(error);
      notifyListeners();
      return true;
    }
  }

  Future<bool> getAllData() async{
    bool isLeaveError = false;
    bool isRequestTimeError = false;
    _requestTimeApprove.clear();
    _requestTimeNotApprove.clear();
    _leaveNotApprove.clear();
    _leaveApprove.clear();
    await getLeave().then((value) => isLeaveError = value);
    await getRequestTime().then((value) => isRequestTimeError = value);;
    isNotApprove();
    isApprove();
    notifyListeners();
    return (isLeaveError && isRequestTimeError);
  }

  Future getAllDataByDate(DateTimeRange period) async{
    dateRange = period;
    _requestTimeApprove.clear();
    _requestTimeNotApprove.clear();
    _leaveNotApprove.clear();
    _leaveApprove.clear();
    await getLeave();
    await getRequestTime();
    isNotApprove();
    isApprove();
    notifyListeners();
  }

  int numRequestIsNotApprove(){
    return _requestTimeNotApprove.length + _leaveNotApprove.length;
  }

  void isNotApprove() {
    _requestTimeNotApprove.clear();
    _leaveNotApprove.clear();
    if (_requestTime.isNotEmpty) {
      _requestTime.sort((a, b) => a.start!.compareTo(b.start!));
       for(var i in _requestTime){
         if(i.isDoubleApproval == 0 && i.isWithdraw == null){
           if(i.isManagerLv1Approve == null){
             _requestTimeNotApprove.add(i);
           }
         }
         else if(i.isDoubleApproval == 1 && i.isWithdraw == null){
           if(i.isManagerLv2Approve == null){
             _requestTimeNotApprove.add(i);
           }
         }
       }
    }
    if(_leaveHistory.isNotEmpty){
      _leaveHistory.sort((a, b) => a.start!.compareTo(b.start!));
      _leaveNotApprove = _leaveHistory
          .where((element) => element.isApprove == null && element.isWithdraw == null)
          .toList();
    }
  }

  void isApprove() {
    _requestTimeApprove.clear();
    if (_requestTime.isNotEmpty) {
      _requestTime.sort((a, b) => a.start!.compareTo(b.start!));
      for(var i in _requestTime){
        if(i.isDoubleApproval == 0){
          if(i.isManagerLv1Approve == 1){
            _requestTimeApprove.add(i);
          }
        }
        else{
          if(i.isManagerLv1Approve == 1 && i.isManagerLv2Approve == 1){
            _requestTimeApprove.add(i);
          }
        }
      }
    }
    if(_leaveHistory.isNotEmpty){
      _leaveApprove = _leaveHistory
          .where((element) => element.isApprove == 1)
          .where((e) => e.isWithdraw == null)
          .toList();
    }
  }


  static WaitingProvider of(BuildContext context, {listen = true}) =>
      Provider.of<WaitingProvider>(context, listen: listen);
}
