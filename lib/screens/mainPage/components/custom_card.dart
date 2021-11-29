import 'package:animate_do/animate_do.dart';
import 'package:eclips_digital_studio_test/models/posts/post_model.dart';
import 'package:eclips_digital_studio_test/models/users/user_model.dart';
import 'package:eclips_digital_studio_test/screens/details/details_screen.dart';
import 'package:eclips_digital_studio_test/screens/posts/components/details/posts_detail_screen.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    this.postsUsers,
    this.postsOrUsers = false,
    required this.index,
    required this.userItems,
  }) : super(key: key);

  final List<UserModel> userItems;
  final List<PostModel>? postsUsers;
  final int index;
  final bool postsOrUsers;

  @override
  Widget build(BuildContext context) {
    return postsOrUsers ? usersPostsCard(context) : usersCard(context);
  }

  usersCard(BuildContext context) {
    return FadeInLeft(
      duration: Duration(milliseconds: 250 * index),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          leading: const CircleAvatar(
            child: Icon(Icons.person_outline, color: Colors.white, size: 32),
            radius: 25,
            backgroundColor: Colors.blue,
          ),
          title: Text("${userItems[index].name}"),
          subtitle: Text("${userItems[index].username}"),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    username: userItems[index].username,
                    name: userItems[index].name,
                    email: userItems[index].email,
                    phone: userItems[index].phone,
                    website: userItems[index].website,
                    workingCompanyName: userItems[index].company!.name,
                    bs: userItems[index].company!.bs,
                    catchPhrase: userItems[index].company!.catchPhrase,
                    street: userItems[index].address!.street,
                    city: userItems[index].address!.city,
                    suite: userItems[index].address!.suite,
                    zipcode: userItems[index].address!.zipcode,
                  ),
                ),
              );
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  username: userItems[index].username,
                  name: userItems[index].name,
                  email: userItems[index].email,
                  phone: userItems[index].phone,
                  website: userItems[index].website,
                  workingCompanyName: userItems[index].company!.name,
                  bs: userItems[index].company!.bs,
                  catchPhrase: userItems[index].company!.catchPhrase,
                  street: userItems[index].address!.street,
                  city: userItems[index].address!.city,
                  suite: userItems[index].address!.suite,
                  zipcode: userItems[index].address!.zipcode,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

   usersPostsCard(BuildContext context) {
    return FadeInLeft(
      duration: Duration(milliseconds: 250 * index),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          leading: const CircleAvatar(
            child: Icon(Icons.local_post_office_outlined,
                color: Colors.white, size: 32),
            radius: 25,
            backgroundColor: Colors.grey,
          ),
          title: Text(
            "${userItems[index].name}",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text("${postsUsers![index].title}"),
          trailing: TextButton(
            child: const Text(
              "See all",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostsDetail(),
                ),
              );
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostsDetail(),
              ),
            );
          },
        ),
      ),
    );
  }
}
