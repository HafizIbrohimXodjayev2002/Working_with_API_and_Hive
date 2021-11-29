import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class InfoAboutUsers extends StatelessWidget {
  const InfoAboutUsers({
    Key? key,
    required this.typeInfo,
    required this.info,
  }) : super(key: key);

  final String? info;
  final String? typeInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: getProportionateScreenHeight(30),
          width: getProportionateScreenWidth(120),
          //color: Colors.grey,
          child: AutoSizeText(
            "$typeInfo:",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(17),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: getProportionateScreenHeight(30),
          width: getProportionateScreenWidth(120),
          child: AutoSizeText(
            "$info",
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: getProportionateScreenWidth(14)),
          ),
        ),
      ],
    );
  }
}
