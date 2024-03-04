part of 'item_status_bloc.dart';

abstract class ItemStatusState extends Equatable {
  const ItemStatusState();

}

class ItemStatusInitial extends ItemStatusState {
  @override
  List<Object> get props => [];
}

class ItemStatusLoading extends ItemStatusState{
  @override
  List<Object?> get props => [];
}

class ItemStatusLoaded extends ItemStatusState{
   final List<LeaveEntity>? leaveData;
   final List<RequestTimeEntity>? requestTimeData;
   final List<WithdrawEntity>? withdrawData;
   final List<PayrollSettingEntity>? payrollSettingData;
   final List<dynamic>? allData;
   final List<dynamic>? dataRequestOT;
   final List<dynamic>? dataRequestTime;
   const ItemStatusLoaded({this.leaveData,this.requestTimeData,this.withdrawData,this.payrollSettingData,this.allData,this.dataRequestOT,this.dataRequestTime});
  @override
  List<Object?> get props => [leaveData,requestTimeData,withdrawData];

}


class ItemStatusStateFailure extends ItemStatusState{
  final ErrorMessage error;

  const ItemStatusStateFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

