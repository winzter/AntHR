part of 'LocationBloc_bloc.dart';

class LocationState extends Equatable {
  final bool isSetLocation;
  final List<Placemark>? address;

  const LocationState({this.isSetLocation = false, this.address});

  LocationState copyWith({
    bool? isSetLocation,
    required List<Placemark> address,
  }) {
    return LocationState(
        isSetLocation: isSetLocation ?? false,
        address: address);
  }

  @override
  List<Object> get props => [isSetLocation];
}

final class LocationInitial extends LocationState{

}
