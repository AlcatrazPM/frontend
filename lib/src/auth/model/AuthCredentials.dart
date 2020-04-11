
import 'package:json_annotation/json_annotation.dart';
part 'AuthCredentials.g.dart';
/// the credentials required to perform an auth request
@JsonSerializable()
class AuthCredentials{
  final String email;
  final String password;
  @JsonKey(includeIfNull: false)
  String username;
  AuthCredentials({this.email, this.username, this.password});
  AuthCredentials.register(this.email, this.username, this.password);
  AuthCredentials.login(this.email, this.password);

  factory AuthCredentials.fromJson(Map<String, dynamic> json) =>
      _$AuthCredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$AuthCredentialsToJson(this);
}

/// the response of an auth request
@JsonSerializable()
class AuthResponse{
  String jwt;
  String date;
  @JsonKey(name: "e_dek")
  String eDek;
  @JsonKey(name: "i_kek")
  String iKek;
  AuthResponse({this.jwt, this.iKek, this.eDek, this.date});
  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}