import 'package:eclips_digital_studio_test/models/comments/comment_model.dart';
import 'package:eclips_digital_studio_test/models/photos/photo_model.dart';
import 'package:eclips_digital_studio_test/models/posts/post_model.dart';
import 'package:eclips_digital_studio_test/models/users/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class DataCubitState extends Equatable {}

class InitialState extends DataCubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AnimatedSplashState extends DataCubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadingState extends DataCubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadedState extends DataCubitState {
  List<UserModel> userdanKelganMalumotlar;
  List<PhotoModel> photodanKelganMalumotlar;
  List<CommentModel> commentdanKelganMalumotlar;
  List<PostModel> postlardanKelganMalumotlar;

  LoadedState({
    required this.commentdanKelganMalumotlar,
    required this.photodanKelganMalumotlar,
    required this.postlardanKelganMalumotlar,
    required this.userdanKelganMalumotlar,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        userdanKelganMalumotlar,
        photodanKelganMalumotlar,
        commentdanKelganMalumotlar,
        postlardanKelganMalumotlar,
      ];
}
