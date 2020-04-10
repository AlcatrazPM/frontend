import 'package:dart_json_mapper/dart_json_mapper.dart';

/// the credentials required to perform an auth request
@jsonSerializable
class AuthCredentials{
  final String email;
  final String password;
  @JsonProperty(ignoreIfNull: true)
  String username;
  AuthCredentials.register(this.email, this.username, this.password);
  AuthCredentials.login(this.email, this.password);
}

/// the response of an auth request
@jsonSerializable
class AuthResponse{
  String jwt;
  String dataRaw;
  String eDek;
  String iKek;

  AuthResponse({this.jwt, this.iKek, this.eDek, this.dataRaw});
}