import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static final StorageHelper _singleton = StorageHelper._internal();

  factory StorageHelper() {
    return _singleton;
  }

  StorageHelper._internal();

  late SharedPreferences _sp;

  Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
  }

  void setUserBearerToken(String value) {
    _sp.setString('UserBearerToken', value);
  }

  void clearData() {
    _sp.clear();
  }

  String getUserBearerToken() {
    return _sp.getString("UserBearerToken")?? "";
  }

  // void setUserProfile(String url) {
  //   _sp.setString('user_profile_url', url);
  // }

  // String getUserProfile() {
  //   return _sp.getString('user_profile_url')?? "";
  // }
}