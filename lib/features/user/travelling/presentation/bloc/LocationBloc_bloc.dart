import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

part 'LocationBloc_event.dart';

part 'LocationBloc_state.dart';

class LocationBloc extends Bloc<GpsEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {

    on<GetCurrentAddress>((event, emit) async {
      List<Placemark> address = await placemarkFromCoordinates(event.lat, event.lng);
      emit(state.copyWith(address: address,isSetLocation: true));
    });
  }
}
