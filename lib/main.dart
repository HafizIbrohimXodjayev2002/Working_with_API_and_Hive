import 'package:eclips_digital_studio_test/cubit/app_cubit_logic.dart';
import 'package:eclips_digital_studio_test/cubit/data_cubit.dart';
import 'package:eclips_digital_studio_test/services/comment_service.dart';
import 'package:eclips_digital_studio_test/services/photo_service.dart';
import 'package:eclips_digital_studio_test/services/post_service.dart';
import 'package:eclips_digital_studio_test/services/user_service.dart';
import 'package:eclips_digital_studio_test/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eclipse Digital Company Test',
      theme: customThemeData(),
      home: BlocProvider<DataCubit>(
        create: (context) => DataCubit(
          commentServices: CommentServices(),
          photoServices: PhotoServices(),
          postServices: PostServices(),
          userServices: UserServices(),
        ),
        child: const AppCubitLogic(),
      ),
    );
  }
}
