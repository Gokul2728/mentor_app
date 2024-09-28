import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Save String data ---------
  Future<void> saveStringData(
      {required String key, required String data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  // Retrieve String data ------------
  Future<String?> getStringData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Save int data ---------
  Future<void> saveIntData({required String key, required int data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, data);
  }

  // Retrieve int data ------------
  Future<int?> getIntData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  // Save bool data ---------
  Future<void> saveBoolData({required String key, required bool data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, data);
  }

  // Retrieve bool data ------------
  Future<bool?> getBoolData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  // Remove data ------------
  Future<void> removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Save Json data ---------
  // Future<void> saveJsonData<T>(String key, T data) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String dataJson = jsonEncode((data as dynamic).toJson());
  //   await prefs.setString(key, dataJson);
  // }

  // // Retrive json data ------------
  // Future<T?> getJsonData<T>(
  //     String key, T Function(Map<String, dynamic>) fromJson) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? dataJson = prefs.getString(key);

  //   if (dataJson != null) {
  //     Map<String, dynamic> dataJsonMap = jsonDecode(dataJson);
  //     return fromJson(dataJsonMap);
  //   }
  //   return null;
  // }
  //
  Future<void> saveJsonData<T>(String key, List<T> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        data.map((item) => jsonEncode((item as dynamic).toJson())).toList();
    await prefs.setStringList(key, jsonList);
  }

  //
  Future<List<T>?> getJsonData<T>(
      String key, T Function(Map<String, dynamic>) fromJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(key);

    if (jsonList != null) {
      return jsonList.map((jsonString) {
        Map<String, dynamic> dataJsonMap = jsonDecode(jsonString);
        return fromJson(dataJsonMap);
      }).toList();
    }
    return null;
  }
}
