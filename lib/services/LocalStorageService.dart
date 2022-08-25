import 'package:localstorage/localstorage.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();
  final LocalStorage storage = LocalStorage('notifications');

  Future<void> setItem(String key, dynamic value) async {
    return await storage.setItem(key, value);
  }

  Future<dynamic> getItem(String key) async {
    return await storage.getItem(key);
  }

  Future<void> removeItem(String key) async {
    return await storage.deleteItem(key);
  }

  Future<void> clear() async {
    return await storage.clear();
  }
}
