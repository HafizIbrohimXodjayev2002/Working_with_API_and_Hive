import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:eclips_digital_studio_test/cache/photo_model_manager.dart';
import 'package:eclips_digital_studio_test/cache/user_model_manager.dart';
import 'package:eclips_digital_studio_test/models/photos/photo_model.dart';
import 'package:eclips_digital_studio_test/models/users/user_model.dart';
import 'package:eclips_digital_studio_test/screens/albums/components/custom_blur.dart';
import 'package:eclips_digital_studio_test/screens/albums/components/details_of_album.dart/details_screen.dart';
import 'package:eclips_digital_studio_test/screens/mainPage/components/custom_drawer.dart';
import 'package:eclips_digital_studio_test/services/photo_service.dart';
import 'package:eclips_digital_studio_test/services/user_service.dart';
import 'package:eclips_digital_studio_test/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../constants.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  late final KPhotoManager kPhotoManager;
  late final PhotoServices photoServices;
  List<PhotoModel> photoList = [];

  late final UserServices _userServices;
  late final KUserManager _kUserManager;
  List<UserModel> userItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // For Bringing Photo
    photoServices = PhotoServices();
    kPhotoManager = PhotoManager("photoCacheBox");
    fetchPhotDatas();

    // For Users in Cache
    _userServices = UserServices();
    _kUserManager = UserManager('userCacheBox');
    fetchUserDatas();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return photoList.isNotEmpty
        ? photosAndAlbums(context)
        : const Center(child: CircularProgressIndicator());
  }

  Scaffold photosAndAlbums(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: FadeInDown(
          child: Text("Photos and Albums",
              style: Theme.of(context).textTheme.headline6),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 2));
        },
        child: StaggeredGridView.countBuilder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          itemCount: 10,
          addAutomaticKeepAlives: false,
          itemBuilder: (BuildContext context, int index) => FadeInDown(
            duration: Duration(milliseconds: 400 * index),
            child: Container(
              //color: Colors.green,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsOfAlbumsScreen(
                              imageURL: photoList[index].url!,
                              name: userItems[index].name!,
                              title: photoList[index].title!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        //color: Colors.green,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage("${photoList[index].url}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(5),
                              vertical: getProportionateScreenHeight(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Favorite Icon Button
                              Align(
                                alignment: Alignment.topRight,
                                child: favoriteIconButton(index),
                              ),
                              // Blured Container with Name of Creater
                              CustomBlur(userItems: userItems, index: index),
                            ],
                          ),
                        ),
                      ),
                    ),
                    flex: 3,
                  ),
                  Container(
                    //color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(7),
                        vertical: getProportionateScreenHeight(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title:",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(height: getProportionateScreenHeight(3)),
                          Container(
                            height: getProportionateScreenHeight(30),
                            width: MediaQuery.of(context).size.width,
                            //color: Colors.yellow,
                            child: AutoSizeText(
                              "${photoList[index].title}",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(2, index.isEven ? 3 : 4),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }

  OutlinedButton favoriteIconButton(int index) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      ),
      child: IconButton(
        splashRadius: 28,
        icon: Icon(
          states[index] ? Icons.favorite : Icons.favorite_outline,
          color: Colors.red,
          size: 30,
        ),
        onPressed: () {
          setState(() {
            states[index] = !states[index];
          });
        },
      ),
      onPressed: () {},
    );
  }

  fetchPhotDatas() async {
    await kPhotoManager.init();
    kPhotoManager.registerHive();

    if (kPhotoManager.getValues().isNotEmpty) {
      photoList = kPhotoManager.getValues();
      debugPrint("Hive ga kirdi");
    } else {
      try {
        photoList = await photoServices.getAllData();
        await kPhotoManager.addItems(photoList);
        debugPrint("API ga kirdi");
      } catch (e) {
        debugPrint("Xato -------------- $e");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please Check Your Internet And Try Again !!!"),
          duration: Duration(seconds: 2),
        ));
      }
    }
    setState(() {});
  }

  fetchUserDatas() async {
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
