import 'package:bloc/bloc.dart';
import 'package:eclips_digital_studio_test/cubit/data_cubit_state.dart';
import 'package:eclips_digital_studio_test/services/comment_service.dart';
import 'package:eclips_digital_studio_test/services/photo_service.dart';
import 'package:eclips_digital_studio_test/services/post_service.dart';
import 'package:eclips_digital_studio_test/services/user_service.dart';

class DataCubit extends Cubit<DataCubitState> {
  // Variables in type of Services
  final CommentServices commentServices;
  final PhotoServices photoServices;
  final UserServices userServices;
  final PostServices postServices;

  // Named Constructor for Services
  DataCubit({
    required this.commentServices,
    required this.photoServices,
    required this.postServices,
    required this.userServices,
  }) : super(InitialState()) {
    emit(AnimatedSplashState());
  }

  // Income Data From API
  late final commentsIncomeData;
  late final photosIncomeData;
  late final usersIncomeData;
  late final postsIncomeData;

  // For Data From All API
  void getDataFromUsers() async {
    try {
      emit(LoadingState());
      usersIncomeData = await userServices.getAllData();
      photosIncomeData = await photoServices.getAllData();
      commentsIncomeData = await commentServices.getAllData();
      postsIncomeData = postServices.getAllData();
      emit(LoadedState(
        commentdanKelganMalumotlar: commentsIncomeData,
        photodanKelganMalumotlar: photosIncomeData,
        userdanKelganMalumotlar: usersIncomeData,
        postlardanKelganMalumotlar: postsIncomeData,
      ));
    } catch (e) {
      throw Exception("Error in get Data from API");
    }
  }
}
