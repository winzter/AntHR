import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/features/profile/manager/domain/entities/manager_profile_entity.dart';
import '../../domain/entities/entities.dart';
import '../../domain/use_cases/usecases.dart';

part 'waiting_status_event.dart';

part 'waiting_status_state.dart';

class WaitingStatusBloc extends Bloc<WaitingStatusEvent, WaitingStatusState> {
  final GetLeaveRequestManager getLeaveRequestManager;
  final GetRequestTimeManager getRequestTimeManager;
  final GetWithdrawLeaveManager getWithdrawLeaveManager;
  final GetPayrollSettingManager getPayrollSettingManager;
  final IsLeaveApprove isLeaveApprove;
  final IsRequestApprove isRequestApprove;

  List<LeaveRequestManager> leaveData = [];
  List<LeaveRequestManager> leaveNotApproveData = [];
  List<RequestTimeManager> reqTimeData = [];
  List<WithdrawLeaveManager> withdrawData = [];
  List<PayrollSetting> payrollData = [];
  List<RequestTimeManager> dataRequestTime = [];
  List<RequestTimeManager> dataNotApproveRequestTime = [];
  List<RequestTimeManager> dataRequestOT = [];
  List<RequestTimeManager> dataNotApproveRequestOT = [];

  WaitingStatusBloc({
    required this.getLeaveRequestManager,
    required this.getPayrollSettingManager,
    required this.getRequestTimeManager,
    required this.getWithdrawLeaveManager,
    required this.isLeaveApprove,
    required this.isRequestApprove,
  }) : super(const WaitingStatusInitial(
            requestTimeData: [],
            leaveRequestData: [],
            payrollSetting: [],
            dataOt: [],
            dataNotApproveOt: [],
            leaveNotApproveData: [],
            dataRequestTime: [],
            dataNotApproveRequestTime: [],
            withdrawLeaveData: [])) {
    on<GetWaitingStatus>((event, emit) async {
      leaveData.clear();
      leaveNotApproveData.clear();
      reqTimeData.clear();
      withdrawData.clear();
      payrollData.clear();
      dataRequestTime.clear();
      dataNotApproveRequestTime.clear();
      dataRequestOT.clear();
      dataNotApproveRequestOT.clear();
      print("leaveData ${leaveData.length}");
      emit(WaitingStatusLoading(
          requestTimeData: reqTimeData,
          leaveRequestData: leaveData,
          withdrawLeaveData: withdrawData,
          payrollSetting: payrollData,
          dataOt: dataRequestOT,
          dataRequestTime: dataRequestTime,
          dataNotApproveOt: dataNotApproveRequestOT,
          leaveNotApproveData: leaveNotApproveData,
          dataNotApproveRequestTime: dataNotApproveRequestTime
      ));
      var resLeave =
          await getLeaveRequestManager(start: event.start, end: event.end);
      var resReqTime =
          await getRequestTimeManager(start: event.start, end: event.end);
      var resWithdraw =
          await getWithdrawLeaveManager(start: event.start, end: event.end);
      // var resPayroll = await getPayrollSettingManager();
      resLeave.fold(
          (l) => emit(WaitingStatusFailure(
            error: l,
              requestTimeData: state.requestTimeData,
              leaveRequestData: state.leaveRequestData,
              payrollSetting: state.payrollSetting,
              dataOt: state.dataOt,
              dataNotApproveOt: state.dataNotApproveOt,
              leaveNotApproveData: state.leaveNotApproveData,
              dataRequestTime: state.dataRequestTime,
              dataNotApproveRequestTime: state.dataNotApproveRequestTime,
              withdrawLeaveData: state.withdrawLeaveData
          )), (r) => leaveData = r);
      resReqTime.fold(
          (l) => emit(WaitingStatusFailure(error: l,
              requestTimeData: state.requestTimeData,
              leaveRequestData: state.leaveRequestData,
              payrollSetting: state.payrollSetting,
              dataOt: state.dataOt,
              dataNotApproveOt: state.dataNotApproveOt,
              leaveNotApproveData: state.leaveNotApproveData,
              dataRequestTime: state.dataRequestTime,
              dataNotApproveRequestTime: state.dataNotApproveRequestTime,
              withdrawLeaveData: state.withdrawLeaveData
          )), (r) => reqTimeData = r);
      resWithdraw.fold(
          (l) => emit(WaitingStatusFailure(error: l,
              requestTimeData: state.requestTimeData,
              leaveRequestData: state.leaveRequestData,
              payrollSetting: state.payrollSetting,
              dataOt: state.dataOt,
              dataNotApproveOt: state.dataNotApproveOt,
              leaveNotApproveData: state.leaveNotApproveData,
              dataRequestTime: state.dataRequestTime,
              dataNotApproveRequestTime: state.dataNotApproveRequestTime,
              withdrawLeaveData: state.withdrawLeaveData
          )), (r) => withdrawData = r);

      // resPayroll.fold(
      //         (l) => emit(WaitingStatusFailure(error: l)),
      //         (r) => payrollData = r);
      for (var data in leaveData) {
        if (data.isApprove == null) {
          leaveNotApproveData.add(data);
        }
      }
      for (var data in reqTimeData) {
        if (data.idRequestType == 2 || data.idRequestType == 3) {
          dataRequestOT.add(data);
          if (data.isDoubleApproval == 0 && data.isManagerLv1Approve == null) {
            dataNotApproveRequestOT.add(data);
          } else if (data.isDoubleApproval == 1 &&
              data.isManagerLv1Approve == null) {
            dataNotApproveRequestOT.add(data);
          } else if (data.isDoubleApproval == 1 &&
              data.isManagerLv2Approve == null &&
              data.managerLv2Id == event.managerData.idManagerEmployee!) {
            dataNotApproveRequestOT.add(data);
          }
        }
      }

      for (var data in reqTimeData) {
        if (data.idRequestType == 1) {
          dataRequestTime.add(data);
          if (data.isDoubleApproval == 0 && data.isManagerLv1Approve == null) {
            dataNotApproveRequestTime.add(data);
          }
        }
      }
      emit(WaitingStatusLoaded(
          requestTimeData: reqTimeData,
          leaveRequestData: leaveData,
          withdrawLeaveData: withdrawData,
          payrollSetting: payrollData,
          dataOt: dataRequestOT,
          dataRequestTime: dataRequestTime,
          dataNotApproveOt: dataNotApproveRequestOT,
          leaveNotApproveData: leaveNotApproveData,
          dataNotApproveRequestTime: dataNotApproveRequestTime));
    });

    on<IsApproveLeaveWaitingStatus>((event, emit) async {
      List<int> idLeave = [];
      for (var i in event.indexes) {
        idLeave.add(leaveNotApproveData[i].idLeave!);
      }
      var sendLeaveApprove = await isLeaveApprove(
          commentManager: event.comment!,
          idLeave: idLeave,
          idLeaveEmployeesWithdraw: [],
          isApprove: event.isApprove);
      sendLeaveApprove.fold((l) => emit(WaitingStatusSendRequestFailed(
          requestTimeData: state.requestTimeData,
          leaveRequestData: state.leaveRequestData,
          payrollSetting: state.payrollSetting,
          dataOt: state.dataOt,
          dataNotApproveOt: state.dataNotApproveOt,
          leaveNotApproveData: state.leaveNotApproveData,
          dataRequestTime: state.dataRequestTime,
          dataNotApproveRequestTime: state.dataNotApproveRequestTime,
          withdrawLeaveData: state.withdrawLeaveData)),
          (r) => emit(WaitingStatusSendRequestSuccess(
              requestTimeData: state.requestTimeData,
              leaveRequestData: state.leaveRequestData,
              payrollSetting: state.payrollSetting,
              dataOt: state.dataOt,
              dataNotApproveOt: state.dataNotApproveOt,
              leaveNotApproveData: state.leaveNotApproveData,
              dataRequestTime: state.dataRequestTime,
              dataNotApproveRequestTime: state.dataNotApproveRequestTime,
              withdrawLeaveData: state.withdrawLeaveData
          )));
    });

    on<IsApproveRequestTimeWaitingStatus>((event, emit) async {
      List<int> idRequestTime = [];

      if (event.type == "ขอรับรองเวลาทำงาน") {
        for (var i in event.indexes) {
          idRequestTime.add(dataNotApproveRequestTime[i].idRequestTime!);
        }
        var sendRequestApprove = await isRequestApprove(
            commentManagerLV1: event.commentManagerLV1,
            commentManagerLV2: event.commentManagerLV2,
            idRequestTimeLv1: idRequestTime,
            idRequestTimeLv2: [],
            isManagerLV1Approve: event.isManagerLV1Approve!,
            isManagerLV2Approve: null);
        sendRequestApprove.fold((l) => emit(WaitingStatusSendRequestFailed
          (
            requestTimeData: state.requestTimeData,
            leaveRequestData: state.leaveRequestData,
            payrollSetting: state.payrollSetting,
            dataOt: state.dataOt,
            dataNotApproveOt: state.dataNotApproveOt,
            leaveNotApproveData: state.leaveNotApproveData,
            dataRequestTime: state.dataRequestTime,
            dataNotApproveRequestTime: state.dataNotApproveRequestTime,
            withdrawLeaveData: state.withdrawLeaveData
        )),
            (r) => emit(WaitingStatusSendRequestSuccess(
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                leaveNotApproveData: state.leaveNotApproveData,
                dataRequestTime: state.dataRequestTime,
                dataNotApproveRequestTime: state.dataNotApproveRequestTime,
                withdrawLeaveData: state.withdrawLeaveData
            )));
      }
      else if (event.type == "ขอทำงานล่วงเวลา") {
        List<int> idRequestTimeLV1 = [];
        List<int> idRequestTimeLV2 = [];
        for (var i in event.indexes) {
          if (dataNotApproveRequestOT[i].isDoubleApproval == 1) {
            if (dataNotApproveRequestOT[i].managerLv2ApproveBy != null &&
                dataNotApproveRequestOT[i].managerLv2ApproveBy ==
                    event.idManager) {
              idRequestTimeLV2.add(dataNotApproveRequestOT[i].idRequestTime!);
            }
          }
          if (dataNotApproveRequestOT[i].managerLv1ApproveBy! ==
              event.idManager) {
            idRequestTimeLV1.add(dataNotApproveRequestOT[i].idRequestTime!);
          }
        }
        var sendRequestApprove = await isRequestApprove(
            commentManagerLV1: event.commentManagerLV1,
            commentManagerLV2: event.commentManagerLV2,
            idRequestTimeLv1: idRequestTimeLV1,
            idRequestTimeLv2: idRequestTimeLV2,
            isManagerLV1Approve: event.isManagerLV1Approve!,
            isManagerLV2Approve: idRequestTimeLV2.isNotEmpty
                ? event.isManagerLV1Approve!
                : null);
        sendRequestApprove.fold((l) => emit(WaitingStatusSendRequestFailed(
            requestTimeData: state.requestTimeData,
            leaveRequestData: state.leaveRequestData,
            payrollSetting: state.payrollSetting,
            dataOt: state.dataOt,
            dataNotApproveOt: state.dataNotApproveOt,
            leaveNotApproveData: state.leaveNotApproveData,
            dataRequestTime: state.dataRequestTime,
            dataNotApproveRequestTime: state.dataNotApproveRequestTime,
            withdrawLeaveData: state.withdrawLeaveData
        )),
            (r) => emit(WaitingStatusSendRequestSuccess(
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                leaveNotApproveData: state.leaveNotApproveData,
                dataRequestTime: state.dataRequestTime,
                dataNotApproveRequestTime: state.dataNotApproveRequestTime,
                withdrawLeaveData: state.withdrawLeaveData
            )));
      }
    });
  }
}
