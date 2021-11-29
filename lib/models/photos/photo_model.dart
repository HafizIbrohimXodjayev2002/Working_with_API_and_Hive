import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'photo_model.g.dart';

PhotoModel photModelFromJson(String str) => PhotoModel.fromJson(json.decode(str));

String photModelToJson(PhotoModel data) => json.encode(data.toJson());


@HiveType(typeId: 6)
class PhotoModel {
    PhotoModel({
        this.albumId,
        this.id,
        this.title,
        this.url,
        this.thumbnailUrl,
    });
    
    @HiveField(0)
    int? albumId;
    @HiveField(1)
    int? id;
    @HiveField(2)
    String? title;
    @HiveField(3)
    String? url;
    @HiveField(4)
    String? thumbnailUrl;

    factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
    );

    Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
    };
}
