import 'dart:convert';
import 'package:eclips_digital_studio_test/models/posts/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class PostServices {

  Future<List<PostModel>> getAllData() async {
    String apiURL = '/posts';
    http.Response res = await http.get(Uri.parse(kbaseURL+apiURL));
    try {
      if (res.statusCode == 200){
        List<dynamic> list = jsonDecode(res.body);
        debugPrint(list.toString());
        return list.map((e) => PostModel.fromJson(e)).toList();
      }
      else {
        debugPrint("TRY ning else dan kelgan Xato -------------- Posts");
        return <PostModel> [];
      }
    } catch (e) {
      debugPrint("XATO Posts: -----------$e");
      return <PostModel> [];
    }
  }
}