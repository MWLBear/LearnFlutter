import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SpUtils {

  static SpUtils? _singleton;
  static SharedPreferences? _prefs;
  static Lock _lock = Lock();

  static Future<SpUtils> getInstance() async {
    if (_singleton == null) {

      await _lock.synchronized(() async {
        if (_singleton == null) {
          // 保持本地实例直到完全初始化。
          var singleton = SpUtils._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton!;
  }

  SpUtils._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///例举的String型存储及获取
  static String getString(String key) {
    if (_prefs == null) return "";
    var status = _prefs!.getString(key);
    if (status == null) return "";
    return status;
  }

  static Future<bool> putString(String key, String value) {
    if (_prefs == null) return Future.value(false);
    return _prefs!.setString(key, value);
  }

  static bool getBool(String key) {
    if (_prefs == null) return false;
    var status = _prefs!.getBool(key);
    if (status == null) return false;
    return status;
  }

  static Future<bool> setBool(String key, bool value) {
    if (_prefs == null) return Future.value(false);
    return _prefs!.setBool(key, value);
  }

}