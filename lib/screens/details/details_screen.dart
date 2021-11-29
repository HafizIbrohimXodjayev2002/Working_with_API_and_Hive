import 'package:animate_do/animate_do.dart';
import 'package:eclips_digital_studio_test/constants.dart';
import 'package:eclips_digital_studio_test/screens/details/components/info_about_user.dart';
import 'package:eclips_digital_studio_test/size_config.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  String? name;
  String? email;
  String? username;
  String? phone;
  String? website;
  String? workingCompanyName;
  String? bs;
  String? catchPhrase;
  String? street;
  String? suite;
  String? city;
  String? zipcode;

  DetailsScreen(
      {Key? key,
      this.name,
      this.street,
      this.suite,
      this.zipcode,
      this.city,
      this.email,
      this.phone,
      this.username,
      this.bs,
      this.catchPhrase,
      this.website,
      this.workingCompanyName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: FadeInDown(
            child: Text("$username",
                style: Theme.of(context).textTheme.headline6)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(12),
            vertical: getProportionateScreenHeight(12)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: InfoAboutUsers(
                  info: name,
                  typeInfo: 'Name',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              FadeInDown(
                child: InfoAboutUsers(
                  info: email,
                  typeInfo: 'Email',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              FadeInDown(
                child: InfoAboutUsers(
                  info: phone,
                  typeInfo: 'Phone',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              FadeInDown(
                child: InfoAboutUsers(
                  info: website,
                  typeInfo: 'Website',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              FadeInDown(
                child: InfoAboutUsers(
                  info: workingCompanyName,
                  typeInfo: 'Company Name',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              FadeInDown(
                child: InfoAboutUsers(
                  info: bs,
                  typeInfo: 'Bs',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              FadeInDown(
                child: InfoAboutUsers(
                  info: catchPhrase,
                  typeInfo: 'Catch Phrase',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              FadeInDown(
                child: InfoAboutUsers(
                  info: street,
                  typeInfo: 'Street',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              FadeInDown(
                child: InfoAboutUsers(
                  info: city,
                  typeInfo: 'City',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              FadeInDown(
                child: InfoAboutUsers(
                  info: zipcode,
                  typeInfo: 'Zipcode',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              FadeInDown(
                child: InfoAboutUsers(
                  info: suite,
                  typeInfo: 'Suite',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
