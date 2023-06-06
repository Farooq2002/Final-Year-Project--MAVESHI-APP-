import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maveshi/screens/auth/different_auth/buchter_signup.dart';
import 'package:maveshi/screens/auth/different_auth/driver_signup.dart';
import 'package:maveshi/screens/auth/different_auth/sell_yr_animal.dart';
import 'package:maveshi/screens/auth/sign_in_screen.dart';
import 'package:maveshi/utils/fonts.dart';

import '../screens//bottom_nav_bar_screens/profile_screen.dart';
import '../screens/auth/sign_up.dart';
import '../screens/favorite_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(right: 20),
        children: [
          DrawerHeader(
            curve: Curves.easeInCubic,
            child: Column(
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                          backgroundColor: Color(0xff2769ab),
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/pictures/sheep.png')),
                      const SizedBox(width: 10),
                      Stack(
                        children: [
                          const Text(
                            'Farooq Ahmad',
                            style: AppFonts.boldText,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: TextButton(
                              child: const Text(
                                'View Profile',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff2769ab)),
                                softWrap: true,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(ProfileScreen.routeName);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(SignUpScreen.routeName);
                      },
                      child: Container(
                        height: 35,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xff2769ab),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      child: Container(
                        height: 35,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xff2769ab),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Nunito'),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(LineIcons.chessKnight),
            title: const Text('Join as Butcher'),
            onTap: () {
              Navigator.of(context).pushNamed(ButcherSignUp.routeName);
            },
          ),
          ListTile(
            leading: const Icon(LineIcons.car),
            title: const Text('Join as Driver'),
            onTap: () {
              Navigator.of(context).pushNamed(DriverSignUp.routeName);
            },
          ),
          ListTile(
            leading: const Icon(LineIcons.cat),
            title: const Text('Sel Your Animal'),
            onTap: () {
              Navigator.of(context).pushNamed(SellYourAnimal.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('Favorite List'),
            onTap: () {
              Navigator.of(context).pushNamed(FavoriteScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            // trailing: RadioMenuButton(
            //     value: 2,
            //     groupValue: 2,
            //     onChanged: (val) {},
            //     child: const Text('')),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Log Out!',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
