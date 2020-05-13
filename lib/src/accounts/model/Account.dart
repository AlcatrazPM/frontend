import 'dart:typed_data';

import 'package:alkatrazpm/src/ui_utils/UIUtils.dart';
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
  Uint8List iconBytes = Uint8List(1);

  Account({
    this.website = "",
    this.username = "",
    this.password = "",
    this.isFavorite = false,
    this.iconBytes,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
