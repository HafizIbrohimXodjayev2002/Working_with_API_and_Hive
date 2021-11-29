import 'package:eclips_digital_studio_test/models/photos/photo_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class KPhotoManager {
  final String key;
  Box<PhotoModel>? _boxUser;

  KPhotoManager(this.key);

  init() async {
    registerHive();

    if (_boxUser != null) {
      if (!_boxUser!.isOpen) {
        _boxUser = await Hive.openBox<PhotoModel>('photoCacheBox');
      } 
    }
    else {
        _boxUser = await Hive.openBox<PhotoModel>('photoCacheBox');
      }
  }

  void registerHive();

  Future<void> addItems(List<PhotoModel> items);
  Future<void> putItems(List<PhotoModel> items);
  PhotoModel? getItem(int key);
  Future<void> removeItem(String key);

  // Remove all Items From Photo Cache
  Future<void> removeAllItems() async {
    await _boxUser!.clear();
  }

  List<PhotoModel> getValues();
}


class PhotoManager extends KPhotoManager {
  PhotoManager(String key) : super(key);

  // Add All User To Photo Cache
  @override
  Future<void> addItems(List<PhotoModel> items) async {
    await _boxUser!.addAll(items);
  }

  // Put All Users To Photo Cache
  @override
  Future<void> putItems(List<PhotoModel> items) async {
    await _boxUser!
        .putAll(Map.fromEntries(items.map((e) => MapEntry(e.id, e))));
  }

  // Get Items From Photo Cache
  @override
  PhotoModel? getItem(int key) {
    return _boxUser!.get(key);
  }

  // Remove Item From Photo Cache
  @override
  Future<void> removeItem(String key) async {
    await _boxUser!.delete(key);
  }

  @override
  void registerHive() {
    if (!Hive.isAdapterRegistered(6)){
      Hive.registerAdapter(PhotoModelAdapter());
    }
  }

  @override
  List<PhotoModel> getValues() {
    return _boxUser!.values.toList();
  }
}
