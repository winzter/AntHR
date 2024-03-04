// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../../domain/entities/entities.dart';
// import '../../domain/usecases/use_cases.dart';
//
// class ItemStatusProvider extends ChangeNotifier {
//   final GetLeaveData getLeave;
//   final GetWithdraw getWithdraw;
//   final DeleteItem deleteItem;
//   final GetPayrollSetting getPayrollSetting;
//   final GetRequestTimeData getRequestTime;
//
//   List<LeaveEntity> leaveData = [];
//   List<WithdrawEntity> withdrawData = [];
//   List<RequestTimeEntity> requestTimeData = [];
//   List<PayrollSettingEntity> payrollSettingData = [];
//   List allData = [];
//   List dataRequestTime = [];
//
//   DateTimeRange dateRange = DateTimeRange(
//       start: DateTime(DateTime.now().year, DateTime.now().month, 1),
//       end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0));
//   String _startDate = "";
//   String _endDate = "";
//   String _type = "all";
//   int numApprove = 0;
//
//   ItemStatusProvider({
//     required this.getLeave,
//     required this.getWithdraw,
//     required this.getPayrollSetting,
//     required this.getRequestTime,
//     required this.deleteItem});
//
//   String get startDate => _startDate;
//   String get endDate => _endDate;
//   String get type => _type;
//
//   void setDateRange(DateTimeRange dateRange) {
//     this.dateRange = dateRange;
//     // notifyListeners();
//   }
//
//   void setType(String userType){
//     _type = userType;
//     notifyListeners();
//   }
//
//   void numIsNotApprove() {
//     int waitApprove = 0;
//     for (var data in requestTimeData) {
//       if (data.isDoubleApproval == 0) {
//         if (data.isManagerLv1Approve == null && data.isWithdraw == null) {
//           waitApprove++;
//         }
//       } else {
//         if (data.isManagerLv2Approve == null && data.isWithdraw == null) {
//           waitApprove++;
//         }
//       }
//     }
//     for (var data in leaveData) {
//       if (data.isApprove == null && data.isWithdraw == null) {
//         waitApprove++;
//       }
//     }
//     numApprove = waitApprove;
//     notifyListeners();
//   }
//
//   void clearData() {
//     leaveData.clear();
//     withdrawData.clear();
//     payrollSettingData.clear();
//     requestTimeData.clear();
//     allData.clear();
//     dataRequestTime.clear();
//     _type = "all";
//     numApprove = 0;
//   }
//
//   String isFullDay(DateTime start, DateTime end) {
//     if (DateFormat('HH:mm').format(start) == "00:00" &&
//         DateFormat('HH:mm').format(end) == "00:00") {
//       return "     เต็มวัน";
//     } else {
//       return "${DateFormat('HH:mm').format(start)} - ${DateFormat('HH:mm').format(end)}";
//     }
//   }
//
//   Future getAllData(DateTimeRange dateTimeRange) async {
//     _startDate = DateFormat("yyyy-MM-dd").format(dateTimeRange.start);
//     _endDate = DateFormat("yyyy-MM-dd").format(dateTimeRange.end);
//     try {
//       await getLeaveData(_startDate, _endDate);
//       await getRequestTimeData(_startDate, _endDate);
//       await getPayrollSettingData();
//       await getWithdrawData(_startDate, _endDate);
//       allData = [...requestTimeData, ...leaveData];
//       numIsNotApprove();
//       notifyListeners();
//     } catch (error) {
//       log(error.toString());
//       notifyListeners();
//     }
//   }
//
//   Future<void> getLeaveData(String startDate, String endDate) async {
//     try {
//       var data = await getLeave(_startDate, _endDate);
//       leaveData = data.foldRight(leaveData, (r, previous) => r);
//       notifyListeners();
//     } catch (error) {
//       log(error.toString());
//       notifyListeners();
//     }
//   }
//
//   Future<void> getRequestTimeData(String startDate, String endDate) async {
//     try {
//       var data = await getRequestTime(_startDate, _endDate);
//       requestTimeData = data.foldRight(requestTimeData, (r, previous) => r);
//       notifyListeners();
//     } catch (error) {
//       log(error.toString());
//       notifyListeners();
//     }
//   }
//
//   Future<void> getWithdrawData(String startDate, String endDate) async {
//     try {
//       var data = await getWithdraw(_startDate, _endDate);
//       withdrawData = data.foldRight(withdrawData, (r, previous) => r);
//       notifyListeners();
//     } catch (error) {
//       log(error.toString());
//       notifyListeners();
//     }
//   }
//
//   Future<void> getPayrollSettingData() async {
//     try {
//       var data = await getPayrollSetting();
//       payrollSettingData =
//           data.foldRight(payrollSettingData, (r, previous) => r);
//       notifyListeners();
//     } catch (error) {
//       log(error.toString());
//       notifyListeners();
//     }
//   }
//
//   Future<void> deleteItemData({RequestTimeEntity? requestTime, LeaveEntity? leaveData}) async {
//     try {
//       if (leaveData != null) {
//         await deleteItem(dataLeave: leaveData);
//       } else if (requestTime != null) {
//         await deleteItem(dataRequestTime: requestTime);
//       } else {
//         throw Exception('Both leaveData and requestTime are null.');
//       }
//       notifyListeners();
//     } catch (error) {
//       log(error.toString());
//       notifyListeners();
//     }
//   }
//
//   static ItemStatusProvider of(BuildContext context, {listen = true}) =>
//       Provider.of<ItemStatusProvider>(context, listen: listen);
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RadioButtonProvider extends ChangeNotifier{
  String _type = "all";

  String get type => _type;

  void setType(String userType){
    // log("$userType");
    _type = userType;
    notifyListeners();
  }

  String isFullDay(DateTime start, DateTime end) {
    if (DateFormat('HH:mm').format(start) == "00:00" &&
        DateFormat('HH:mm').format(end) == "00:00") {
      return "     เต็มวัน";
    } else {
      return "${DateFormat('HH:mm').format(start)} - ${DateFormat('HH:mm').format(end)}";
    }
  }
}