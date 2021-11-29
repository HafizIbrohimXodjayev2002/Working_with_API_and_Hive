import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eclips_digital_studio_test/models/users/user_model.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class CustomBlur extends StatelessWidget {
  const CustomBlur({
    Key? key,
    this.customBlurState = false,
    this.name,
    this.index,
    this.userItems,
  }) : super(key: key);

  final List<UserModel>? userItems;
  final int? index;
  final String? name;
  final bool customBlurState;

  @override
  Widget build(BuildContext context) {
    return customBlurState
        ? backdropfilterStateTrue(context)
        : backdropfilterStateFalse(context);
  }

  ClipRRect backdropfilterStateFalse(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: getProportionateScreenHeight(50),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(7),
              horizontal: getProportionateScreenWidth(10)),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: AutoSizeText(
              "Created By: ${userItems![index!].name}",
              style: Theme.of(context).textTheme.subtitle2),
        ),
      ),
    );
  }

  ClipRRect backdropfilterStateTrue(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          alignment: Alignment.centerLeft,
          height: getProportionateScreenHeight(50),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(7),
              horizontal: getProportionateScreenWidth(10)),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: AutoSizeText(
            "Created By: $name",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: getProportionateScreenWidth(22),
            ),
          ),
        ),
      ),
    );
  }
}
