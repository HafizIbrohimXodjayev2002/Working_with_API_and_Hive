import 'package:eclips_digital_studio_test/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../../size_config.dart';

class AnimatedSpalsh extends StatelessWidget {
  const AnimatedSpalsh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SplashScreenView(
      navigateRoute: const HomeScreen(),
      duration: 3500,
      imageSize: 210,
      imageSrc: "assets/images/eclipse.png",
      backgroundColor: Colors.white,
      pageRouteTransition: PageRouteTransition.SlideTransition,
    );
  }
}
