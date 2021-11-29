import 'package:animate_do/animate_do.dart';
import 'package:eclips_digital_studio_test/cache/user_model_manager.dart';
import 'package:eclips_digital_studio_test/models/users/user_model.dart';
import 'package:eclips_digital_studio_test/screens/mainPage/components/custom_card.dart';
import 'package:eclips_digital_studio_test/screens/mainPage/components/search_button.dart';
import 'package:eclips_digital_studio_test/services/user_service.dart';
import 'package:eclips_digital_studio_test/size_config.dart';
import 'package:flutter/material.dart';

import 'components/custom_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final UserServices _userServices;
  late final KUserManager _kUserManager;
  List<UserModel> userItems = [];

  @override
  void initState() {
    super.initState();
    _userServices = UserServices();
    _kUserManager = UserManager('userCacheBox');
    fetchDatas();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return userItems.isNotEmpty
        ? datasFromHiveAndAPI(context)
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Scaffold datasFromHiveAndAPI(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title:
            FadeInLeft(child: Text("Persons Data", style: Theme.of(context).textTheme.headline6)),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: userItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(13),
                vertical: getProportionateScreenHeight(10)),
            child: CustomCard(userItems: userItems, index: index),
          );
        },
      ),
      floatingActionButton: FadeInRight(child: searchButton(context, userItems)),
    );
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
