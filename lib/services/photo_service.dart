import 'dart:convert';
import 'package:eclips_digital_studio_test/models/photos/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class PhotoServices {

  Future<List<PhotoModel>> getAllData() async {
    String apiURL = '/photos';
    http.Response res = await http.get(Uri.parse(kbaseURL+apiURL));
    try {
      if (res.statusCode == 200){
        List<dynamic> list = jsonDecode(res.body);
        debugPrint(list.toString());
        return list.map((e) => PhotoModel.fromJson(e)).toList();
      }
      else {
        debugPrint("TRY ning else dan kelgan Xato -------------- Photo");
        return <PhotoModel> [];
      }
    } catch (e) {
      debugPrint("XATO Photo: -----------$e");
      return <PhotoModel> [];
    }
  }
}