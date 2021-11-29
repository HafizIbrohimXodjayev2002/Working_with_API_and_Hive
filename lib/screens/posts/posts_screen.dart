import 'package:animate_do/animate_do.dart';
import 'package:eclips_digital_studio_test/cache/post_model_manager.dart';
import 'package:eclips_digital_studio_test/cache/user_model_manager.dart';
import 'package:eclips_digital_studio_test/models/posts/post_model.dart';
import 'package:eclips_digital_studio_test/models/users/user_model.dart';
import 'package:eclips_digital_studio_test/screens/mainPage/components/custom_card.dart';
import 'package:eclips_digital_studio_test/screens/mainPage/components/custom_drawer.dart';
import 'package:eclips_digital_studio_test/services/post_service.dart';
import 'package:eclips_digital_studio_test/services/user_service.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late final KUserManager _kUserManager;
  late final UserServices _userServices;
  List<UserModel> userItems = [];

  late final KPostManager _kPostManager;
  late final PostServices _postServices;
  List<PostModel> usersPosts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // For Taking Users Data
    _userServices = UserServices();
    _kUserManager = UserManager('userCacheBox');
    fetchDatas();

    // For Taking Users Posts
    _kPostManager = PostManager('postCacheBox');
    _postServices = PostServices();
    fetchUsersPosts();
  }

  @override
  Widget build(BuildContext context) {
    return usersPosts.isNotEmpty
        ? usersPostAndNames(context)
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Scaffold usersPostAndNames(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title:
            FadeInLeft(child: Text("Users Posts", style: Theme.of(context).textTheme.headline6)),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(13),
                vertical: getProportionateScreenHeight(10)),
            child: CustomCard(
              postsUsers: usersPosts,
              postsOrUsers: true,
              index: index,
              userItems: userItems,
            ),
          );
        },
      ),
    );
  }

  fetchUsersPosts() async {
    await _kPostManager.init();
    _kPostManager.registerHive();

    if (_kPostManager.getValues().isNotEmpty) {
      usersPosts = _kPostManager.getValues();
      debugPrint("Hive ga kirdi");
    } else {
      try {
        usersPosts = await _postServices.getAllData();
        await _kPostManager.addItems(usersPosts);
        debugPrint("API ga kirdi");
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please Check Your Internet And Try Again !!!"),
          duration: Duration(seconds: 2),
        ));
      }
    }
    setState(() {});
  }

  fetchDatas() async {
    await _kUserManager.init();
    _kUserManager.registerHive();

    if (_kUserManager.getValues().isNotEmpty) {
      userItems = _kUserManager.getValues();
      debugPrint("Hive ga kirdi");
    } else {
      try {
        userItems = await _userServices.getAllData();
        await _kUserManager.addItems(userItems);
        debugPrint("API ga kirdi");
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please Check Your Internet And Try Again !!!"),
          duration: Duration(seconds: 2),
        ));
      }
    }
    setState(() {});
  }
}
