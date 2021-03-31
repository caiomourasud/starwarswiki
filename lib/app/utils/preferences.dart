import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  Future<String> getString(String key, {defValue = ''}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? defValue;
  }

  Future<bool> setString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(key, value);
  }

  Future<bool> getBool(String key, {defValue = false}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? defValue;
  }

  Future<bool> setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(key, value);
  }

  delete(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }

  deleteAll() async {
    delete('next_films');
    delete('next_people');
    delete('next_planets');
    delete('next_species');
    delete('next_starships');
    delete('next_vehicles');
    delete('theme_mode');
  }
}
