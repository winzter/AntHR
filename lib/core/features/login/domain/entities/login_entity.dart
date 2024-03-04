class LoginEntity{
  int? id;
  String? username;
  List<String>? roles;
  String? accessToken;

  LoginEntity({
    this.id,
    this.username,
    this.roles,
    this.accessToken,
  });
}