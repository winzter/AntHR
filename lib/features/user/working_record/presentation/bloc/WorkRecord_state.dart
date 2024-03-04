part of 'WorkRecord_bloc.dart';

class WorkRecordState extends Equatable {
  final bool isCheck;
  final List<Placemark>? address;

  WorkRecordState({this.isCheck = false, this.address});

  WorkRecordState copyWith({
    required List<Placemark> address,
    bool? isCheck,
  }) {
    return WorkRecordState(
        address: address??[], isCheck: isCheck??this.isCheck);
  }

  @override
  List<Object> get props => [isCheck];
}

final class LocationInitial extends WorkRecordState{

}
