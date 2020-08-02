import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// pages
import 'package:insta_clone/view/activities/pages/activities_page.dart';
import 'package:insta_clone/view/feed/pages/feed_page.dart';
import 'package:insta_clone/view/post/pages/post_page.dart';
import 'package:insta_clone/view/profile/pages/profile_page.dart';
import 'package:insta_clone/view/search/pages/search_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _pages;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      FeedPage(),
      SearchPage(),
      PostPage(),
      ActivitiesPage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO:
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            title: Text(S.of(context).home),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.search),
            title: Text(S.of(context).search),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.plusSquare),
            title: Text(S.of(context).add),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart),
            title: Text(S.of(context).activities),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            title: Text(S.of(context).user),
          ),
        ],
      ),
    );
  }
}
