import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Utils {
  save(String key, value) async {
    print(value.toString());
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getStringList(key));
    // return json.decode(prefs.getString(key));
  }
}