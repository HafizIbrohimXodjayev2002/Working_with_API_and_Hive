import 'dart:convert';
import 'package:eclips_digital_studio_test/models/comments/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

// В последный момент узнал что в jsonplaceholder можно работаь с Nested Routes
// С Nested Routes тоже могу работать

class CommentServices {

  Future<List<CommentModel>> getAllData() async {
    String apiURL = '/comments';
    http.Response res = await http.get(Uri.parse(kbaseURL+apiURL));
    try {
      if (res.statusCode == 200){
        List<dynamic> list = jsonDecode(res.body);
        debugPrint(list.toString());
        return list.map((e) => CommentModel.fromJson(e)).toList();
      }
      else {
        debugPrint("TRY ning else dan kelgan Xato --------------- Comments");
        return <CommentModel> [];
      }
    } catch (e) {
      debugPrint("XATO Comments: -----------$e ");
      return <CommentModel> [];
    }
  }

  Future<CommentModel> createComment({String? name, String? email, String? text}) async {
  String apiURL = '/comments';
  http.Response response = await http.post(
    Uri.parse(kbaseURL+apiURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name!,
      'email' : email!,
      'body' : text!,
    }),
  );

  if (response.statusCode == 201) {
    debugPrint(response.body);
    return CommentModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create Comments.');
  }
}
}