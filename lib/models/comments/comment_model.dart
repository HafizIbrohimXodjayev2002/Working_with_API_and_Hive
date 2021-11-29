import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'comment_model.g.dart';


CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

@HiveType(typeId: 7)
class CommentModel {
    CommentModel({
        this.postId,
        this.id,
        this.name,
        this.email,
        this.body,
    });

    @HiveField(0)
    int? postId;
    @HiveField(1)
    int? id;
    @HiveField(2)
    String? name;
    @HiveField(3)
    String? email;
    @HiveField(4)
    String? body;

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
    };
}
