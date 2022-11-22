import 'package:shared_preferences/shared_preferences.dart';

class DataCacher{
  DataCacher._singleton();
  static DataCacher get _instance => DataCacher._singleton();
  static late final SharedPreferences _sharedPreferences;
  static DataCacher get instance => _instance;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  set token(String? token){
    _sharedPreferences.setString("accesstoken", token!);
  }
  String? get token => _sharedPreferences.getString('accesstoken');

    set pages(String? pages){
    _sharedPreferences.setString("pages", pages!);
  }
  String? get pages => _sharedPreferences.getString('pages');

  set uid(String? uid){
    _sharedPreferences.setString("uid", uid!);
  }
  String? get uid => _sharedPreferences.getString('uid');

  Future<void> deleteToken() async {
    await _sharedPreferences.remove('accesstoken');
    await _sharedPreferences.remove('pages');
    await _sharedPreferences.remove('uid');
  }
}