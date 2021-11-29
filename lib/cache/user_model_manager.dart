import 'package:eclips_digital_studio_test/models/users/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

abstract class KUserManager {
  final String key;
  Box<UserModel>? _boxUser;

  KUserManager(this.key);

  init() async {
    registerHive();

    if (_boxUser != null) {
      if (!_boxUser!.isOpen) {
        _boxUser = await Hive.openBox<UserModel>('userCacheBox');
      }
    } else {
      _boxUser = await Hive.openBox<UserModel>('userCacheBox');
    }
  }

  void registerHive();

  Future<void> addItems(List<UserModel> items);
  Future<void> putItems(List<UserModel> items);
  UserModel? getItem(int key);
  Future<void> removeItem(String key);

  // Remove all Items From User Cache
  Future<void> removeAllItems() async {
    await _boxUser!.clear();
  }

  List<UserModel> getValues();
}

class UserManager extends KUserManager {
  UserManager(String key) : super(key);

  // Add All User To User Cache
  @override
  Future<void> addItems(List<UserModel> items) async {
    await _boxUser!.addAll(items);
  }

  // Put All Users To User Cache
  @override
  Future<void> putItems(List<UserModel> items) async {
    await _boxUser!
        .putAll(Map.fromEntries(items.map((e) => MapEntry(e.id, e))));
  }

  // Get Items From User Cache
  @override
  UserModel? getItem(int key) {
    return _boxUser!.get(key);
  }

  // Remove Item From User Cache
  @override
  Future<void> removeItem(String key) async {
    await _boxUser!.delete(key);
  }

  @override
  void registerHive() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserModelAdapter());
      Hive.registerAdapter(AddressAdapter());
      Hive.registerAdapter(GeoAdapter());
      Hive.registerAdapter(CompanyAdapter());
    }
  }

  @override
  List<UserModel> getValues() {
    return _boxUser!.values.toList();
  }
}
