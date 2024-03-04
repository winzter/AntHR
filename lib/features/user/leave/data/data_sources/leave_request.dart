import 'package:file_picker/file_picker.dart';

class LeaveRequest {
  final String idLeaveType;
  final String leaveName;
  final String? description;
  final DateTime start;
  final DateTime end;
  final int idEmp;
  final double used;
  final double quota;
  final double balance;
  final double remaining;
  final int idManagerEmployee;
  final int? isApprove;
  final int isFullDay;
  final int isActive;
  final int? idHoliday;
  final PlatformFile? file;
  final String? managerLV1Email;

  LeaveRequest({
    required this.idLeaveType,
    required this.leaveName,
    required this.description,
    required this.start,
    required this.end,
    required this.idEmp,
    required this.used,
    required this.quota,
    required this.balance,
    required this.remaining,
    required this.idManagerEmployee,
    required this.isApprove,
    required this.isFullDay,
    required this.isActive,
    required this.idHoliday,
    required this.file,
    required this.managerLV1Email,
  });
}