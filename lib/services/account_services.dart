import 'package:get_storage/get_storage.dart';

class AccountServices {
  final _box = GetStorage();
  final _tokenKey = "userToken";
  final _userIdKey = "userIdKey";
  final _accountInfo = "accountInfo";
  final _accountType = "accountType";
  final _languageCode = "languageCode";
  final _notificationToken = "notificationToken";
  final _referralId = "referralId";
  final _isFirstBuild = "isFirstBuild";
  final _accountAdress = "accountAdress";
  final _accountVendor = "accountVendor";

  String getUserToken() => _box.read(_tokenKey) ?? "";
  String getUserId() => _box.read(_userIdKey) ?? "";
  String getAccountType() => _box.read(_accountType) ?? "";
  dynamic getAccountInfo() => _box.read(_accountInfo) ?? Null;
  String getLanguageCode() => _box.read(_languageCode) ?? "vi";
  String getNotificationToken() => _box.read(_notificationToken) ?? "";
  String getReferralId() => _box.read(_referralId) ?? "";
  bool getIsFirstBuild() => _box.read(_isFirstBuild) ?? true;
  String getAccountAddress() => _box.read(_accountAdress) ?? "";
  bool isAccountVendor() => _box.read(_accountVendor) ?? true;

  saveUserToken(String token) => _box.write(_tokenKey, token);
  saveUserId(String userId) => _box.write(_userIdKey, userId);
  saveAccoutInfo(dynamic account) => _box.write(_accountInfo, account);
  saveAccountType(String type) => _box.write(_accountType, type);
  saveLanguageCode(String code) => _box.write(_languageCode, code);
  saveNotificationToken(String token) => _box.write(_notificationToken, token);
  saveReferralId(String id) => _box.write(_referralId, id);
  saveIsFirstBuild(bool status) => _box.write(_isFirstBuild, status);
  saveAccountAdress(String address) => _box.write(_accountAdress, address);
  saveAccountVendor(bool status) => _box.write(_accountVendor, status);
}
