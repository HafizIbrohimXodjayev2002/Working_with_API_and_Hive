import 'package:eclips_digital_studio_test/screens/albums/albums_screen.dart';
import 'package:eclips_digital_studio_test/screens/mainPage/main_scree.dart';
import 'package:eclips_digital_studio_test/screens/posts/posts_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> pages = [
    const MainScreen(),
    const PostsScreen(),
    const AlbumsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: bottomBar(),

    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey.withOpacity(0.5),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_sharp)),
        BottomNavigationBarItem(
            label: 'Posts', icon: Icon(Icons.question_answer_sharp)),
        BottomNavigationBarItem(
            label: 'Albums', icon: Icon(Icons.photo_album_sharp)),
      ],
    );
  }
}
