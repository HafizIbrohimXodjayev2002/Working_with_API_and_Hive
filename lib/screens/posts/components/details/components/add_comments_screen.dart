import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:eclips_digital_studio_test/services/comment_service.dart';
import 'package:eclips_digital_studio_test/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class AddCommentsScreen extends StatelessWidget {
  final CommentServices _commentServices = CommentServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: FadeInDown(
          duration: const Duration(seconds: 1),
          child: Text(
            "Add Comments",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: getProportionateScreenWidth(21),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/images/commentsPicture.jpg",
                    fit: BoxFit.cover)),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(120)),
                    FadeInDown(
                      duration: const Duration(seconds: 1),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter something !";
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: "Name...",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                    FadeInDown(
                      duration: Duration(seconds: 1),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter something !";
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email...",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                    FadeInDown(
                      duration: const Duration(seconds: 1),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter something !";
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        controller: commentController,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: "New Comment....",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                    FadeInDown(
                      duration: const Duration(seconds: 1),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(16),
                              horizontal: getProportionateScreenWidth(50)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text(
                          "Add To Comments",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        onPressed: () async {
                          try {
                            if (formKey.currentState!.validate()) {
                              await _commentServices.createComment(
                                email: emailController.text,
                                name: nameController.text,
                                text: commentController.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Successfully Added"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              emailController.clear();
                              nameController.clear();
                              commentController.clear();
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Please Check Your Internet And Try Again"),
                                    duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
