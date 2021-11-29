import 'package:eclips_digital_studio_test/models/posts/post_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class KPostManager {
  final String key;
  Box<PostModel>? _boxUser;

  KPostManager(this.key);

  init() async {
    registerHive();

    if (_boxUser != null) {
      if (!_boxUser!.isOpen) {
        _boxUser = await Hive.openBox<PostModel>('postCacheBox');
      } 
    }
    else {
        _boxUser = await Hive.openBox<PostModel>('postCacheBox');
      }
  }

  void registerHive();

  Future<void> addItems(List<PostModel> items);
  Future<void> putItems(List<PostModel> items);
  PostModel? getItem(int key);
  Future<void> removeItem(String key);

  // Remove all Items From Post Cache
  Future<void> removeAllItems() async {
    await _boxUser!.clear();
  }

  List<PostModel> getValues();
}

class PostManager extends KPostManager {
  PostManager(String key) : super(key);

  // Add All User To Post Cache
  @override
  Future<void> addItems(List<PostModel> items) async {
    await _boxUser!.addAll(items);
  }

  // Put All Users To Post Cache
  @override
  Future<void> putItems(List<PostModel> items) async {
    await _boxUser!
        .putAll(Map.fromEntries(items.map((e) => MapEntry(e.id, e))));
  }

  // Get Items From Post Cache
  @override
  PostModel? getItem(int key) {
    return _boxUser!.get(key);
  }

  // Remove Item From Post Cache
  @override
  Future<void> removeItem(String key) async {
    await _boxUser!.delete(key);
  }

  @override
  void registerHive() {
    if (!Hive.isAdapterRegistered(5)){
      Hive.registerAdapter(PostModelAdapter());
    }
  }

  @override
  List<PostModel> getValues() {
    return _boxUser!.values.toList();
  }
}
