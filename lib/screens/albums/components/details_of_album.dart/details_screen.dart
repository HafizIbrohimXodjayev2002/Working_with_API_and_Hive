import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:eclips_digital_studio_test/screens/albums/components/custom_blur.dart';
import 'package:eclips_digital_studio_test/screens/posts/components/details/components/add_comments_screen.dart';
import 'package:eclips_digital_studio_test/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class DetailsOfAlbumsScreen extends StatefulWidget {
  final String imageURL;
  final String name;
  final String title;

  DetailsOfAlbumsScreen({
    Key? key,
    required this.name,
    required this.title,
    required this.imageURL,
  }) : super(key: key);

  @override
  State<DetailsOfAlbumsScreen> createState() => _DetailsOfAlbumsScreenState();
}

class _DetailsOfAlbumsScreenState extends State<DetailsOfAlbumsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailsOfMainPicture(context),
                SizedBox(height: getProportionateScreenHeight(20)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15)),
                  child: FadeInLeft(
                    duration: kAnimationDuration,
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: getProportionateScreenWidth(26),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(7)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15)),
                  child: FadeInLeft(duration: kAnimationDuration ,child: descriptionDetails()),
                ),
                SizedBox(height: getProportionateScreenHeight(80)),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            // Add Comments Button Part
            child: FadeInRight(duration: kAnimationDuration, child: addCommentsButton(context)),
          ),
        ],
      ),
    );
  }

  ElevatedButton addCommentsButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(16),
            horizontal: getProportionateScreenWidth(90)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text(
        "Add Comments",
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
      onPressed: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AddCommentsScreen(),
          ),
        );
      },
    );
  }

  AutoSizeText descriptionDetails() {
    return AutoSizeText(
      widget.title +
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words,",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: getProportionateScreenWidth(13),
        color: Colors.black54,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Container detailsOfMainPicture(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(320),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        image: DecorationImage(
          image: NetworkImage(widget.imageURL),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: getProportionateScreenHeight(35),
          left: getProportionateScreenWidth(15),
          right: getProportionateScreenWidth(15),
          bottom: getProportionateScreenHeight(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Favorite Icon Button And back Arrow
            twoButtonsInTop(context),
            // Name Of Creater
            FadeInUp(
                duration: kAnimationDuration,
                child: CustomBlur(customBlurState: true, name: widget.name)),
          ],
        ),
      ),
    );
  }

  Row twoButtonsInTop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: FadeInLeft(
            duration: kAnimationDuration,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: FadeInRight(
              duration: kAnimationDuration, child: favoriteIconButton()),
        ),
      ],
    );
  }

  OutlinedButton favoriteIconButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      ),
      child: IconButton(
        splashRadius: 28,
        icon: Icon(
          state ? Icons.favorite : Icons.favorite_outline,
          color: Colors.red,
          size: 30,
        ),
        onPressed: () {
          setState(() {
            state = !state;
          });
        },
      ),
      onPressed: () {},
    );
  }
}
