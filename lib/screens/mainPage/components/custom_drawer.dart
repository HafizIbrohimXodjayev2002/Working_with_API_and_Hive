import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UserAccountsDrawerHeader(
            onDetailsPressed: () {},
            accountName: FadeInLeft(child: const Text("Eclipse digital studio")),
            accountEmail: FadeInLeft(child: const Text("Eclipsedigitalstudio@gmail.com")),
            currentAccountPictureSize: const Size.square(75.0),
            currentAccountPicture: FadeInLeft(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/eclipse.png',
                    fit: BoxFit.fitWidth),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15),
              vertical: getProportionateScreenHeight(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: index == 4
                        ? EdgeInsets.only(
                            bottom: getProportionateScreenHeight(7))
                        : EdgeInsets.only(
                            bottom: getProportionateScreenHeight(32)),
                    child: FadeInLeft(
                      duration: Duration(milliseconds: 300 * index),
                      child: Row(
                        children: [
                          Icon(icons[index], size: 25),
                          SizedBox(width: getProportionateScreenWidth(13)),
                          Text(iconsName[index],
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Colors.black45),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FadeInLeft(
              duration: const Duration(milliseconds: 1500),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 25),
                  SizedBox(width: getProportionateScreenWidth(13)),
                  Text("About Us",
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}