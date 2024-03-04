part of 'WorkRecord_bloc.dart';

abstract class WorkRecordEvent extends Equatable {
  const WorkRecordEvent();
}

class GetCurrentAddress extends WorkRecordEvent {
  final bool isCheck;
  final double lat;
  final double lng;

  GetCurrentAddress({required this.lat, required this.lng,required this.isCheck});

  @override
  List<Object?> get props => [lat, lng,isCheck];
}
