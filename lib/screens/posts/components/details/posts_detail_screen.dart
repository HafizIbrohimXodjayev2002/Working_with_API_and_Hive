import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:eclips_digital_studio_test/cache/comment_model_manager.dart';
import 'package:eclips_digital_studio_test/constants.dart';
import 'package:eclips_digital_studio_test/models/comments/comment_model.dart';
import 'package:eclips_digital_studio_test/screens/posts/components/details/components/add_comments_screen.dart';
import 'package:eclips_digital_studio_test/services/comment_service.dart';
import 'package:eclips_digital_studio_test/size_config.dart';
import 'package:flutter/material.dart';

class PostsDetail extends StatefulWidget {
  PostsDetail({
    Key? key,
    this.name = "Ibrohim",
  }) : super(key: key);

  String name;

  @override
  _PostsDetailState createState() => _PostsDetailState();
}

class _PostsDetailState extends State<PostsDetail> {
  late final KCommentManager _kCommentManager;
  late final CommentServices _commentServices;
  List<CommentModel> usersComment = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kCommentManager = CommentManager('commentCacheBox');
    _commentServices = CommentServices();
    fetchCommentData();
  }

  @override
  Widget build(BuildContext context) {
    return usersComment.isNotEmpty
        ? mainCommentPart(context)
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Scaffold mainCommentPart(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          right: getProportionateScreenWidth(15),
          left: getProportionateScreenWidth(15),
          top: getProportionateScreenHeight(35),
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInLeft(
                    child: Text(
                      "Comments (20)",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: getProportionateScreenWidth(25),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(25)),
                  Column(
                    children: List.generate(
                      20,
                      (index) => ZoomIn(
                        duration: Duration(milliseconds: 750 * index),
                        child: bigCommentsPart(context, index),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              // Add A Comment Part
              child: addAComment(context),
            ),
          ],
        ),
      ),
    );
  }

  addAComment(BuildContext context) {
    return FadeInRight(
      duration: const Duration(seconds: 1),
      child: Container(
        height: getProportionateScreenHeight(50),
        width: getProportionateScreenWidth(170),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(10)),
              child: Text(
                "Add A Comment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(right: getProportionateScreenWidth(5)),
                height: getProportionateScreenHeight(40),
                width: getProportionateScreenWidth(40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  size: 25,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCommentsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Row bigCommentsPart(BuildContext context, index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: const [
            CircleAvatar(
              child: Icon(Icons.person_outline, color: Colors.white, size: 29),
              radius: 22,
              backgroundColor: Colors.indigo,
            ),
          ],
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        // Name, Email And Comment Part
        detailsOfComment(index, context),
      ],
    );
  }

  Column detailsOfComment(index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          //height: getProportionateScreenHeight(25),
          width: getProportionateScreenWidth(270),
          //color: Colors.green,
          child: AutoSizeText(
            "${usersComment[index].name}",
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: getProportionateScreenWidth(17),
            ),
          ),
        ),
        Text(
          "${usersComment[index].email}",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(13),
            color: Colors.black.withOpacity(0.4),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(13)),
        Container(
          //color : Colors.green,
          height: getProportionateScreenHeight(70),
          width: getProportionateScreenWidth(280),
          child: AutoSizeText(
            "${usersComment[index].body}",
            textAlign: TextAlign.left,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        favoriteAndCommentButton(context, index),
        SizedBox(height: getProportionateScreenHeight(20)),
      ],
    );
  }

  Row favoriteAndCommentButton(BuildContext context, index) {
    return Row(
      children: [
        const Icon(
          Icons.forum_outlined,
          color: Colors.black,
          size: 20,
        ),
        SizedBox(width: getProportionateScreenWidth(10)),
        Text(
          "Comments",
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(width: getProportionateScreenWidth(30)),
        IconButton(
          icon: statesComments[index]
              ? const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 20,
                )
              : const Icon(
                  Icons.favorite_outline,
                  color: Colors.red,
                  size: 20,
                ),
          onPressed: () {
            setState(() {
              statesComments[index] = !statesComments[index];
            });
          },
        ),
        Text("Liked", style: Theme.of(context).textTheme.subtitle2),
      ],
    );
  }

  fetchCommentData() async {
    await _kCommentManager.init();

    _kCommentManager.registerHive();

    if (_kCommentManager.getValues().isNotEmpty) {
      usersComment = _kCommentManager.getValues();
      //print("Hive dan malumotlar keldi");
    } else {
      try {
        usersComment = await _commentServices.getAllData();
        await _kCommentManager.addItems(usersComment);
        //print("API ga kirdi");
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please check your internet and try again !!!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
    setState(() {});
  }
}
