import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maveshi/screens/bottom_nav_bar_screens/profile_screen.dart';
import 'package:maveshi/screens/bottom_nav_bar_screens/search_screen.dart';

import '../screens/bottom_nav_bar_screens/chat_list_screen.dart';
import '../screens/bottom_nav_bar_screens/home_page.dart';

class CustomNavigationBar extends StatefulWidget {
  static const routeName = 'main Screen';

  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  CustomNavigationBarState createState() => CustomNavigationBarState();
}

class CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _pages = [
    HomeScreen(),
    ChatListScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  backgroundColor: Color.fromRGBO(39, 105, 171, 1),
                ),
                GButton(
                  icon: LineIcons.rocketChat,
                  backgroundColor: Color.fromRGBO(39, 105, 171, 1),
                  text: 'Chat',
                ),
                GButton(
                  icon: LineIcons.search,
                  backgroundColor: Color.fromRGBO(39, 105, 171, 1),
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.user,
                  backgroundColor: Color.fromRGBO(39, 105, 171, 1),
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
