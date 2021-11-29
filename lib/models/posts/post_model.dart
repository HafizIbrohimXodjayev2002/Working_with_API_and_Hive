import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'post_model.g.dart';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());


@HiveType(typeId: 5)
class PostModel {
    PostModel({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    @HiveField(0)
    int? userId;
    @HiveField(1)
    int? id;
    @HiveField(2)
    String? title;
    @HiveField(3)
    String? body;

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
