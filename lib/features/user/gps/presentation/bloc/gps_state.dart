part of 'gps_bloc.dart';

enum FetchStatus { fetching, success, failed, init, selected }

class GpsState extends Equatable {
  final FetchStatus status;
  final LineCheckIn? locationData;
  final List<geo.Placemark>? address;
  final bool isPoint;
  final List<DropdownMenuItem<String>> dropDownData;
  final Map<int, List<Location>> subLocations;
  final List<GroupGpsLocation> groupGpsLocations;
  final String? selectedLocation;
  final ErrorMessage? error;
  final double? lat;
  final double? lng;

  const GpsState({
    this.status = FetchStatus.init,
    this.locationData,
    this.dropDownData = const [],
    this.subLocations = const {},
    this.selectedLocation,
    this.error,
    this.groupGpsLocations = const [],
    this.address,
    this.isPoint = false,
    this.lat,
    this.lng,
  });

  GpsState copyWith({
    LineCheckIn? locationData,
    FetchStatus? status,
    List<DropdownMenuItem<String>>? dropDownData,
    Map<int, List<Location>>? subLocations,
    String? selectedLocation,
    ErrorMessage? error,
    List<GroupGpsLocation>? groupGpsLocations,
    List<geo.Placemark>? address,
    double? lat,
    double? lng,
    bool? isPoint,
  }) {
    return GpsState(
      status: status ?? this.status,
      locationData: locationData ?? this.locationData,
      dropDownData: dropDownData ?? this.dropDownData,
      subLocations: subLocations ?? this.subLocations,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      error: error ?? this.error,
      groupGpsLocations: groupGpsLocations ?? this.groupGpsLocations,
      address: address ?? this.address,
      isPoint: isPoint ?? this.isPoint,
      lat: lat??this.lat,
      lng: lng??this.lng,
    );
  }

  @override
  List<Object?> get props => [
    status,
    locationData,
    dropDownData,
    subLocations,
    selectedLocation,
    error,
    address,
    isPoint,
    lat,
    lng,
  ];
}

class GpsInitial extends GpsState {
  @override
  List<Object> get props => [];
}
