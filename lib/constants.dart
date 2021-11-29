import 'package:flutter/material.dart';

var kAnimationDuration = const Duration(seconds: 1);

const String kbaseURL = 'https://jsonplaceholder.typicode.com';

List icons = [
  Icons.person_outline,
  Icons.search_outlined,
  Icons.favorite_outline,
  Icons.turned_in_not_outlined,
  Icons.settings_outlined,
];

List<String> iconsName = ["Users", "Search", "Favorite", "Saved", "Settings"];

// Albums Favorite icons state
bool state = false;
var states = List.generate(11, (index) => false);

// Comments favotite icons state
var statesComments = List.generate(21, (index) => false);

// TextFormField variables in Add Comments Page


TextEditingController commentController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
var formKey = GlobalKey<FormState>();
