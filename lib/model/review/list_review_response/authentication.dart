import 'package:json_annotation/json_annotation.dart';

part 'authentication.g.dart';

@JsonSerializable()
class Authentication {
  bool? lock;
  bool? status;
  bool? isPhoneVerified;

  Authentication({this.lock, this.status, this.isPhoneVerified});

  factory Authentication.fromJson(Map<String, dynamic> json) {
    return _$AuthenticationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AuthenticationToJson(this);
}
