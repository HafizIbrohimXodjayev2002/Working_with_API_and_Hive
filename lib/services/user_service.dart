import 'dart:convert';
import 'package:eclips_digital_studio_test/models/users/user_model.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class UserServices {

  Future<List<UserModel>> getAllData() async {
    String apiURL = '/users';
    http.Response res = await http.get(Uri.parse(kbaseURL+apiURL));
    try {
      if (res.statusCode == 200){
        List<dynamic> list = jsonDecode(res.body);
        //debugPrint(list.toString());
        return list.map((e) => UserModel.fromJson(e)).toList();
      }
      else {
        //debugPrint("TRY ning else dan kelgan Xato ----------------- User");
        return <UserModel> [];
      }
    } catch (e) {
      //debugPrint("XATO User: -----------$e");
      return <UserModel> [];
    }
  }
}