import 'package:equatable/equatable.dart';

class LeaveAuthorityEntity extends Equatable{

  final int? idLeaveType;
  final String? name;
  final int? indexLeave;
  final String? createBy;
  final DateTime? createDate;
  final dynamic updateBy;
  final dynamic updateDate;
  final int? minLeave;
  final int? idVendor;
  final int? isPaid;
  final int? isLeaveStep;
  final int? leaveValue;
  final int? carryValue;
  final String? gender;
  final int? isAfterProbation;
  final String? managerLv1;
  final dynamic managerLv2;
  final int? isActive;
  final dynamic isMain;
  final dynamic conditionType;
  final dynamic moreThanYears;
  final dynamic carry;
  final dynamic moreThanJobLevel;
  final dynamic idLeaveSteps;
  final double? remaining = 0;
  final double? used = 0;

  const LeaveAuthorityEntity({
    this.idLeaveType,
    this.name,
    this.indexLeave,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.updateDate,
    this.minLeave,
    this.idVendor,
    this.isPaid,
    this.isLeaveStep,
    this.leaveValue,
    this.carryValue,
    this.gender,
    this.isAfterProbation,
    this.managerLv1,
    this.managerLv2,
    this.isActive,
    this.isMain,
    this.conditionType,
    this.moreThanYears,
    this.carry,
    this.moreThanJobLevel,
    this.idLeaveSteps,
  });

  @override
  List<Object?> get props => [];
}