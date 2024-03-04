import 'dart:convert';
import '../../domain/entities/entities.dart';

OverviewModel overviewModelFromJson(String str) => OverviewModel.fromJson(json.decode(str));

// String overviewModelToJson(OverviewModel data) => json.encode(data.toJson());

class OverviewModel extends OverviewEntity{

  OverviewModel({
    required super.employeeTotal,
    required List<EmployeeTotalAllYear>? super.employeeTotalAllYear,
    required super.salaryTotal,
    required List<SalaryTotalAllYear>? super.salaryTotalAllYear,
    required OtTotal? super.otTotal,
    required List<OtTotalAllYear>? super.otTotalAllYear,
    required EmployeeInfo? super.employeeInfo,
    required WorkingTimeEmployeeInfo? super.workingTimeEmployeeInfo,
    required EmployeeOtOver36Total? super.employeeOtOver36Total,
  });

  factory OverviewModel.fromJson(Map<String, dynamic> json) => OverviewModel(
    employeeTotal: json["employeeTotal"],
    employeeTotalAllYear: json["employeeTotalAllYear"] == null ? [] : List<EmployeeTotalAllYear>.from(json["employeeTotalAllYear"]!.map((x) => EmployeeTotalAllYear.fromJson(x))),
    salaryTotal: json["salaryTotal"]?.toDouble(),
    salaryTotalAllYear: json["salaryTotalAllYear"] == null ? [] : List<SalaryTotalAllYear>.from(json["salaryTotalAllYear"]!.map((x) => SalaryTotalAllYear.fromJson(x))),
    otTotal: json["otTotal"] == null ? null : OtTotal.fromJson(json["otTotal"]),
    otTotalAllYear: json["otTotalAllYear"] == null ? [] : List<OtTotalAllYear>.from(json["otTotalAllYear"]!.map((x) => OtTotalAllYear.fromJson(x))),
    employeeInfo: json["employeeInfo"] == null ? null : EmployeeInfo.fromJson(json["employeeInfo"]),
    workingTimeEmployeeInfo: json["workingTimeEmployeeInfo"] == null ? null : WorkingTimeEmployeeInfo.fromJson(json["workingTimeEmployeeInfo"]),
    employeeOtOver36Total: json["employeeOTOver36Total"] == null ? null : EmployeeOtOver36Total.fromJson(json["employeeOTOver36Total"]),
  );

  // Map<String, dynamic> toJson() => {
  //   "employeeTotal": employeeTotal,
  //   "employeeTotalAllYear": employeeTotalAllYear == null ? [] : List<dynamic>.from(employeeTotalAllYear!.map((x) => x.toJson())),
  //   "salaryTotal": salaryTotal,
  //   "salaryTotalAllYear": salaryTotalAllYear == null ? [] : List<dynamic>.from(salaryTotalAllYear!.map((x) => x.toJson())),
  //   "otTotal": otTotal?.toJson(),
  //   "otTotalAllYear": otTotalAllYear == null ? [] : List<dynamic>.from(otTotalAllYear!.map((x) => x.toJson())),
  //   "employeeInfo": employeeInfo?.toJson(),
  //   "workingTimeEmployeeInfo": workingTimeEmployeeInfo?.toJson(),
  //   "employeeOTOver36Total": employeeOtOver36Total?.toJson(),
  // };
}

class EmployeeInfo extends EmployeeInfoEntity{
  EmployeeInfo({
    required super.maleTotal,
    required super.femaleTotal,
    required super.averageAge,
    required super.averageWorkExperience,
    required super.employeeInTotal,
    required super.employeeIn,
    required super.employeeOutTotal,
    required super.employeeOut,
  });

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) => EmployeeInfo(
    maleTotal: json["maleTotal"],
    femaleTotal: json["femaleTotal"],
    averageAge: json["averageAge"]?.toDouble(),
    averageWorkExperience: json["averageWorkExperience"]?.toDouble(),
    employeeInTotal: json["employeeInTotal"],
    employeeIn: json["employeeIn"] == null ? [] : List<dynamic>.from(json["employeeIn"]!.map((x) => x)),
    employeeOutTotal: json["employeeOutTotal"],
    employeeOut: json["employeeOut"] == null ? [] : List<dynamic>.from(json["employeeOut"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "maleTotal": maleTotal,
    "femaleTotal": femaleTotal,
    "averageAge": averageAge,
    "averageWorkExperience": averageWorkExperience,
    "employeeInTotal": employeeInTotal,
    "employeeIn": employeeIn == null ? [] : List<dynamic>.from(employeeIn!.map((x) => x)),
    "employeeOutTotal": employeeOutTotal,
    "employeeOut": employeeOut == null ? [] : List<dynamic>.from(employeeOut!.map((x) => x)),
  };
}

class EmployeeOtOver36Total extends EmployeeOtOver36TotalEntity{
  EmployeeOtOver36Total({
    required List<WeekInMonth>? super.weekInMonth,
    required super.top5EmployeeOver36,
  });

  factory EmployeeOtOver36Total.fromJson(Map<String, dynamic> json) => EmployeeOtOver36Total(
    weekInMonth: json["weekInMonth"] == null ? [] : List<WeekInMonth>.from(json["weekInMonth"]!.map((x) => WeekInMonth.fromJson(x))),
    top5EmployeeOver36: json["top5EmployeeOver36"] == null ? [] : List<dynamic>.from(json["top5EmployeeOver36"]!.map((x) => x)),
  );

  // Map<String, dynamic> toJson() => {
  //   "weekInMonth": weekInMonth == null ? [] : List<dynamic>.from(weekInMonth!.map((x) => x.toJson())),
  //   "top5EmployeeOver36": top5EmployeeOver36 == null ? [] : List<dynamic>.from(top5EmployeeOver36!.map((x) => x)),
  // };
}

class WeekInMonth extends WeekInMonthEntity{

  WeekInMonth({
    required super.weekStartDate,
    required super.weekEndDate,
    required super.yearWeek,
    required super.weekStartDateText,
    required super.weekEndDateText,
    required super.over36HoursEmployeeTotal,
    required super.over36HoursEmployee,
  });

  factory WeekInMonth.fromJson(Map<String, dynamic> json) => WeekInMonth(
    weekStartDate: json["weekStartDate"] == null ? null : DateTime.parse(json["weekStartDate"]),
    weekEndDate: json["weekEndDate"] == null ? null : DateTime.parse(json["weekEndDate"]),
    yearWeek: json["yearWeek"],
    weekStartDateText: json["weekStartDateText"] == null ? null : DateTime.parse(json["weekStartDateText"]),
    weekEndDateText: json["weekEndDateText"] == null ? null : DateTime.parse(json["weekEndDateText"]),
    over36HoursEmployeeTotal: json["over36HoursEmployeeTotal"],
    over36HoursEmployee: json["over36HoursEmployee"] == null ? [] : List<dynamic>.from(json["over36HoursEmployee"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "weekStartDate": weekStartDate?.toIso8601String(),
    "weekEndDate": weekEndDate?.toIso8601String(),
    "yearWeek": yearWeek,
    "weekStartDateText": "${weekStartDateText!.year.toString().padLeft(4, '0')}-${weekStartDateText!.month.toString().padLeft(2, '0')}-${weekStartDateText!.day.toString().padLeft(2, '0')}",
    "weekEndDateText": "${weekEndDateText!.year.toString().padLeft(4, '0')}-${weekEndDateText!.month.toString().padLeft(2, '0')}-${weekEndDateText!.day.toString().padLeft(2, '0')}",
    "over36HoursEmployeeTotal": over36HoursEmployeeTotal,
    "over36HoursEmployee": over36HoursEmployee == null ? [] : List<dynamic>.from(over36HoursEmployee!.map((x) => x)),
  };
}

class EmployeeTotalAllYear extends EmployeeTotalAllYearEntity{


  EmployeeTotalAllYear({
    required super.month,
    required super.year,
    required super.employeeTotal,
  });

  factory EmployeeTotalAllYear.fromJson(Map<String, dynamic> json) => EmployeeTotalAllYear(
    month: json["month"],
    year: json["year"],
    employeeTotal: json["employeeTotal"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "year": year,
    "employeeTotal": employeeTotal,
  };
}

class OtTotal extends OtTotalEntity{
  OtTotal({
    required The15? the2,
    required The15? the3,
    required The15? the15,
  }):super(
    the2:the2,
    the3:the3,
    the15:the15,
    );

  factory OtTotal.fromJson(Map<String, dynamic> json) => OtTotal(
    the2: json["2"] == null ? null : The15.fromJson(json["2"]),
    the3: json["3"] == null ? null : The15.fromJson(json["3"]),
    the15: json["1.5"] == null ? null : The15.fromJson(json["1.5"]),
  );

  // Map<String, dynamic> toJson() => {
  //   "2": the2?.toJson(),
  //   "3": the3?.toJson(),
  //   "1.5": the15?.toJson(),
  // };
}

class The15 extends The15Entity{


  The15({
    required super.payTotal,
    required super.hourTotal,
  });

  factory The15.fromJson(Map<String, dynamic> json) => The15(
    payTotal: json["payTotal"]?.toDouble(),
    hourTotal: json["hourTotal"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "payTotal": payTotal,
    "hourTotal": hourTotal,
  };
}

class OtTotalAllYear extends OtTotalAllYearEntity{
  OtTotalAllYear({
    required super.payTotal,
    required super.month,
    required super.year,
  });

  factory OtTotalAllYear.fromJson(Map<String, dynamic> json) => OtTotalAllYear(
    payTotal: json["payTotal"]?.toDouble(),
    month: json["month"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "payTotal": payTotal,
    "month": month,
    "year": year,
  };
}

class SalaryTotalAllYear extends SalaryTotalAllYearEntity{
  SalaryTotalAllYear({
    required super.month,
    required super.year,
    required super.salaryTotal,
  });

  factory SalaryTotalAllYear.fromJson(Map<String, dynamic> json) => SalaryTotalAllYear(
    month: json["month"],
    year: json["year"],
    salaryTotal: json["salaryTotal"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "year": year,
    "salaryTotal": salaryTotal,
  };
}

class WorkingTimeEmployeeInfo extends WorkingTimeEmployeeInfoEntity{


  WorkingTimeEmployeeInfo({
    required List<Leave>? super.leave,
    required super.leaveTotal,
    required super.lateTotal,
    required super.absentTotal,
    required super.top5LateEmployees,
    required List<Top5AbsentEmployee>? super.top5AbsentEmployees,
  });

  factory WorkingTimeEmployeeInfo.fromJson(Map<String, dynamic> json) => WorkingTimeEmployeeInfo(
    leave: json["leave"] == null ? [] : List<Leave>.from(json["leave"]!.map((x) => Leave.fromJson(x))),
    leaveTotal: json["leaveTotal"],
    lateTotal: json["lateTotal"],
    absentTotal: json["absentTotal"],
    top5LateEmployees: json["top5LateEmployees"] == null ? [] : List<dynamic>.from(json["top5LateEmployees"]!.map((x) => x)),
    top5AbsentEmployees: json["top5AbsentEmployees"] == null ? [] : List<Top5AbsentEmployee>.from(json["top5AbsentEmployees"]!.map((x) => Top5AbsentEmployee.fromJson(x))),
  );

  // Map<String, dynamic> toJson() => {
  //   "leave": leave == null ? [] : List<dynamic>.from(leave!.map((x) => x.toJson())),
  //   "leaveTotal": leaveTotal,
  //   "lateTotal": lateTotal,
  //   "absentTotal": absentTotal,
  //   "top5LateEmployees": top5LateEmployees == null ? [] : List<dynamic>.from(top5LateEmployees!.map((x) => x)),
  //   "top5AbsentEmployees": top5AbsentEmployees == null ? [] : List<dynamic>.from(top5AbsentEmployees!.map((x) => x.toJson())),
  // };
}

class Leave extends LeaveEntity{

  Leave({
    required super.idLeave,
    required super.idLeaveType,
    required super.name,
    required super.description,
    required super.start,
    required super.startText,
    required super.end,
    required super.endText,
    required super.isFullDay,
    required super.firstnameTh,
    required super.lastnameTh,
    required super.imageProfile,
  });

  factory Leave.fromJson(Map<String, dynamic> json) => Leave(
    idLeave: json["idLeave"],
    idLeaveType: json["idLeaveType"],
    name: json["name"],
    description: json["description"],
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    startText: json["startText"],
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    endText: json["endText"],
    isFullDay: json["isFullDay"],
    firstnameTh: json["firstname_TH"],
    lastnameTh: json["lastname_TH"],
    imageProfile: json["imageProfile"],
  );

  Map<String, dynamic> toJson() => {
    "idLeave": idLeave,
    "idLeaveType": idLeaveType,
    "name": name,
    "description": description,
    "start": start?.toIso8601String(),
    "startText": startText,
    "end": end?.toIso8601String(),
    "endText": endText,
    "isFullDay": isFullDay,
    "firstname_TH": firstnameTh,
    "lastname_TH": lastnameTh,
    "imageProfile": imageProfile,
  };
}

class Top5AbsentEmployee extends Top5AbsentEmployeeEntity{


  Top5AbsentEmployee({
    required super.idEmployees,
    required super.firstnameTh,
    required super.lastnameTh,
    required super.imageName,
    required super.lateTotal,
    required super.absentTotal,
    required super.imageProfile,
  });

  factory Top5AbsentEmployee.fromJson(Map<String, dynamic> json) => Top5AbsentEmployee(
    idEmployees: json["idEmployees"],
    firstnameTh: json["firstname_TH"],
    lastnameTh: json["lastname_TH"],
    imageName: json["imageName"],
    lateTotal: json["lateTotal"],
    absentTotal: json["absentTotal"],
    imageProfile: json["imageProfile"],
  );

  Map<String, dynamic> toJson() => {
    "idEmployees": idEmployees,
    "firstname_TH": firstnameTh,
    "lastname_TH": lastnameTh,
    "imageName": imageName,
    "lateTotal": lateTotal,
    "absentTotal": absentTotal,
    "imageProfile": imageProfile,
  };
}
