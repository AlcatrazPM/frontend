import 'package:json_annotation/json_annotation.dart';

part 'Account.g.dart';

@JsonSerializable()
class Account {
  String id;
  String password;
  String username;
  @JsonKey(name: "site")
  String website;
  @JsonKey(name: "favorite")
  bool isFavorite;

  @JsonKey(ignore: true)
  String iconUrl;

  Account({
    this.website = "",
    this.username = "",
    this.password = "",
    this.isFavorite = false,
    this.iconUrl,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
