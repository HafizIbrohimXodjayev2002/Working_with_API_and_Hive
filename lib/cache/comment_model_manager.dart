import 'package:eclips_digital_studio_test/models/comments/comment_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class KCommentManager {
  final String key;
  Box<CommentModel>? _boxUser;

  KCommentManager(this.key);

  init() async {
    registerHive();

    if (_boxUser != null) {
      if (!_boxUser!.isOpen) {
        _boxUser = await Hive.openBox<CommentModel>('commentCacheBox');
      } 
    }
    else {
        _boxUser = await Hive.openBox<CommentModel>('commentCacheBox');
      }
  }

  void registerHive();

  Future<void> addItems(List<CommentModel> items);
  Future<void> putItems(List<CommentModel> items);
  CommentModel? getItem(int key);
  Future<void> removeItem(String key);

  // Remove all Items From Comment Cache
  Future<void> removeAllItems() async {
    await _boxUser!.clear();
  }

  List<CommentModel> getValues();
}

class CommentManager extends KCommentManager {
  CommentManager(String key) : super(key);

  // Add All User To Comment Cache
  @override
  Future<void> addItems(List<CommentModel> items) async {
    await _boxUser!.addAll(items);
  }

  // Put All Users To Comment Cache
  @override
  Future<void> putItems(List<CommentModel> items) async {
    await _boxUser!
        .putAll(Map.fromEntries(items.map((e) => MapEntry(e.id, e))));
  }

  // Get Items From Comment Cache
  @override
  CommentModel? getItem(int key) {
    return _boxUser!.get(key);
  }

  // Remove Item From Comment Cache
  @override
  Future<void> removeItem(String key) async {
    await _boxUser!.delete(key);
  }

  @override
  void registerHive() {
    if (!Hive.isAdapterRegistered(7)){
      Hive.registerAdapter(CommentModelAdapter());
    }
  }

  @override
  List<CommentModel> getValues() {
    return _boxUser!.values.toList();
  }
}
