import 'package:equatable/equatable.dart';


class ManagerProfileEntity extends Equatable{
  final int? idManagerEmployee;
  final String? name;
  final String? positionsName;
  final String? email;
  final int? idUsers;
  final int? idCompany;
  final int? isActive;
  final dynamic userLineId;

  const ManagerProfileEntity({
    this.idManagerEmployee,
    this.name,
    this.positionsName,
    this.email,
    this.idUsers,
    this.idCompany,
    this.isActive,
    this.userLineId,
  });

  @override
  List<Object?> get props => [
    idManagerEmployee,
    name,
    positionsName,
    email,
    idUsers,
    idCompany,
    isActive,
    userLineId,
  ];
}
