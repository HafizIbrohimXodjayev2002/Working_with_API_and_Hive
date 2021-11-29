import 'package:eclips_digital_studio_test/cubit/data_cubit.dart';
import 'package:eclips_digital_studio_test/cubit/data_cubit_state.dart';
import 'package:eclips_digital_studio_test/loading/loading_screen.dart';
import 'package:eclips_digital_studio_test/screens/home/home_screen.dart';
import 'package:eclips_digital_studio_test/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubitLogic extends StatelessWidget {
  const AppCubitLogic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DataCubit, DataCubitState>(
        builder: (context, state) {
          if (state is AnimatedSplashState) {
            return const AnimatedSpalsh();
          }
          if (state is LoadingState) {
            return const LoadingScreen();
          }
          if (state is LoadedState) {
            return const HomeScreen();
          } 
          else {
            return const Scaffold(
              body: Center(
                child: Text("Error in Cubit"),
              ),
            );
          }
        },
      ),
    );
  }
}