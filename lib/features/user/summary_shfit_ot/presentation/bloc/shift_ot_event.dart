part of 'shift_ot_bloc.dart';

abstract class ShiftOtEvent extends Equatable {
  const ShiftOtEvent();
}

class getShiftOT extends ShiftOtEvent{
  final String start;
  getShiftOT({required this.start});

  @override
  List<Object?> get props => [start];

}
