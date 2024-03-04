import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/use_cases.dart';

part 'item_status_event.dart';
part 'item_status_state.dart';

class ItemStatusBloc extends Bloc<ItemStatusEvent, ItemStatusState> {
  final GetLeaveData getLeaveData;
  final GetRequestTimeData getRequestTimeData;
  final GetWithdraw getWithdraw;
  final GetPayrollSetting getPayrollSetting;
  final DeleteItem deleteItem;

  List<LeaveEntity> leaveData = [];
  List<RequestTimeEntity> reqTimeData = [];
  List<WithdrawEntity> withdrawData = [];
  List<PayrollSettingEntity> payrollSettingData = [];
  List<dynamic> dataRequestTime = [];
  List<dynamic> dataRequestOT = [];
  List<dynamic> allData = [];

  ItemStatusBloc({
    required this.getLeaveData,
    required this.getRequestTimeData,
    required this.getWithdraw,
    required this.getPayrollSetting,
    required this.deleteItem
  }) : super(ItemStatusInitial()) {

    on<GetItemStatusData>((event, emit) async{
      emit(ItemStatusLoading());
      leaveData.clear();
      reqTimeData.clear();
      withdrawData.clear();
      payrollSettingData.clear();
      dataRequestTime.clear();
      dataRequestOT.clear();
      allData.clear();
      var resLeave = await getLeaveData(event.startDate,event.endDate);
      var resReqTime = await getRequestTimeData(event.startDate,event.endDate);
      var resWithdraw = await getWithdraw(event.startDate,event.endDate);
      var resPayrollData = await getPayrollSetting();
      resLeave.fold(
              (l) => emit(ItemStatusStateFailure(error: l)),
              (r)=>leaveData=r);
      resReqTime.fold(
              (l) => emit(ItemStatusStateFailure(error: l)),
              (r) => reqTimeData = r);
      resWithdraw.fold(
              (l) => emit(ItemStatusStateFailure(error: l)),
              (r)=> withdrawData=r);
      for (var data in reqTimeData) {
        if (data.idRequestType == 2 || data.idRequestType == 3) {
          dataRequestOT.add(data);
        }
      }
      for (var data in reqTimeData) {
        if (data.idRequestType == 1) {
          dataRequestTime.add(data);
        }
      }
      allData = [...reqTimeData,...leaveData];
      resPayrollData.fold(
              (l) => emit(ItemStatusStateFailure(error: l)),
              (r) {
                emit(ItemStatusLoaded(
                  leaveData: leaveData,
                  requestTimeData: reqTimeData,
                  withdrawData: withdrawData,
                  payrollSettingData: r,
                  allData: allData,
                  dataRequestOT: dataRequestOT,
                  dataRequestTime: dataRequestTime
                ));
              });
    });

    on<DeleteItemData>((event,emit) async{
      emit(ItemStatusLoading());
      if (reqTimeData.isNotEmpty && leaveData.isNotEmpty) {

        if (event.index < reqTimeData.length && event.type != "ขอลา") {
          await deleteItem(dataRequestTime: event.requestTime);
          allData.removeAt(event.index);
          if (event.type == "ขอรับรองเวลาทำงาน" || event.type == "ขอทำงานล่วงเวลา") {
            if(event.type == "ขอรับรองเวลาทำงาน"){
              dataRequestTime.removeAt(event.index);
            }else{
              dataRequestOT.removeAt(event.index);
            }
            reqTimeData.removeAt(reqTimeData.indexWhere((data) => data.idRequestTime == event.requestTime!.idRequestTime,));
          } else if (event.type == "all") {
            reqTimeData.removeAt(event.index);
            if(event.requestTime!.idRequestType == 1){
              dataRequestTime.removeAt(dataRequestTime.indexWhere((data) => data.idRequestTime == event.requestTime!.idRequestTime,));
            }else if(event.requestTime!.idRequestType == 2 || event.requestTime!.idRequestType == 3){
              dataRequestOT.removeAt(dataRequestOT.indexWhere((data) => data.idRequestTime == event.requestTime!.idRequestTime,));
            }
          }
        }
        else {
          await deleteItem(dataLeave: event.leaveData);
          if (event.type == "all") {
            leaveData.removeAt((event.index - reqTimeData.length).abs());
          } else if (event.type == "ขอลา") {
            leaveData.removeAt(event.index);
          }
        }
        // item.numIsNotApprove();
      }
      emit(ItemStatusLoaded(
          leaveData: leaveData,
          requestTimeData: reqTimeData,
          withdrawData: withdrawData,
          payrollSettingData: payrollSettingData,
          allData: allData,
          dataRequestOT: dataRequestOT,
          dataRequestTime: dataRequestTime
      ));
    });
  }
}
