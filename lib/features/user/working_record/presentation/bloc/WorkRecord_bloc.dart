import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

part 'WorkRecord_event.dart';

part 'WorkRecord_state.dart';

class WorkRecordBloc extends Bloc<WorkRecordEvent, WorkRecordState> {
  WorkRecordBloc() : super(LocationInitial()) {

    on<GetCurrentAddress>((event, emit) async {
      List<Placemark> address = await placemarkFromCoordinates(event.lat, event.lng);
      emit(state.copyWith(address: address,isCheck: event.isCheck));
    });
  }
}
