import 'package:eclips_digital_studio_test/models/users/user_model.dart';
import 'package:eclips_digital_studio_test/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';

import '../../../size_config.dart';

FloatingActionButton searchButton(BuildContext context, userItems) {
    return FloatingActionButton(
      tooltip: 'Search people',
      onPressed: () => showSearch(
        context: context,
        delegate: SearchPage<UserModel>(
          barTheme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.indigo),
            textTheme: const TextTheme(
              headline6: TextStyle(color: Colors.white),
            ),
            inputDecorationTheme: const InputDecorationTheme(
                hintStyle: TextStyle(color: Colors.white)),
          ),
          items: userItems,
          searchLabel: 'Search users',
          suggestion: const Center(
            child: Text('Filter people by name, username'),
          ),
          failure: const Center(
            child: Text('No users found :('),
          ),
          filter: (person) => [
            person.name,
            person.username,
          ],
          builder: (person) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(13),
              vertical: getProportionateScreenHeight(10),
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: ListTile(
                title: Text(person.name!),
                subtitle: Text(person.username!),
                leading: const CircleAvatar(
                  child:
                      Icon(Icons.person_outline, color: Colors.white, size: 32),
                  radius: 25,
                  backgroundColor: Colors.indigo,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_sharp),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          username: person.username,
                          name: person.name,
                          email: person.email,
                          phone: person.phone,
                          website: person.website,
                          workingCompanyName: person.company!.name,
                          bs: person.company!.bs,
                          catchPhrase: person.company!.catchPhrase,
                          street: person.address!.street,
                          city: person.address!.city,
                          suite: person.address!.suite,
                          zipcode: person.address!.zipcode,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      child: const Icon(Icons.search),
    );
}