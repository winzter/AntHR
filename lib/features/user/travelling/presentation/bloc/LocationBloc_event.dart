part of 'LocationBloc_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();
}

class GetCurrentAddress extends GpsEvent {
  final double lat;
  final double lng;

  GetCurrentAddress({required this.lat, required this.lng});

  @override
  List<Object?> get props => [lat, lng];
}
