import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maveshi/screens/auth/sign_in_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'Profile-screen';

  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";
  String email = "";
  String location = "";
  dynamic sinceYear = '';
  final currentUser = FirebaseAuth.instance.currentUser;
  getUserNameAndEmail() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = snap['UserName'];
      email = snap['UserEmail'];
      sinceYear = snap['TimeCreation'];
      location = snap['location'];
    });
  }

  @override
  void initState() {
    getUserNameAndEmail();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return currentUser == null
        ? Center(
            child: AlertDialog(
                title: const Text("Attention!"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: const Text('Sign In'))
                ],
                content: const Text('Sign In Please')),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              backgroundColor: const Color.fromRGBO(39, 105, 171, 1),
              title: const Text(
                "Profile",
                style: TextStyle(fontFamily: 'Nunito'),
              ),
              centerTitle: true,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.done))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color.fromRGBO(39, 105, 171, 1),
                            borderRadius: BorderRadius.circular(3)),
                        child: const Center(
                          child: Icon(
                            LineIcons.userAlt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      title: Text(username),
                      subtitle: Text('SWAT \n'
                          'Member Since, $sinceYear'),
                      trailing: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.edit)),
                    ),
                    const Divider(),
                     ProfileListTile(
                      icon: Icons.location_on,
                      title: 'Location',
                      subTitle: location,
                      trailingIcon: Icons.expand_more,
                    ),
                    const Divider(),
                    ProfileListTile(
                      icon: Icons.mail,
                      title: "Email",
                      subTitle: email,
                      trailingIcon: Icons.expand_more,
                    ),
                    const Divider(),
                    const ProfileListTile(
                      icon: Icons.location_on,
                      title: 'Date Of Birth',
                      subTitle: '07/03/2002',
                      trailingIcon: Icons.expand_more,
                    ),
                    const Divider(),
                    const ProfileListTile(
                      icon: Icons.boy,
                      title: 'Gender',
                      subTitle: 'Male',
                      trailingIcon: Icons.expand_more,
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
          );
  }
}

class ProfileListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData trailingIcon;
  final IconData icon;
  const ProfileListTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.trailingIcon,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(trailingIcon),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: const Color.fromRGBO(39, 105, 171, 1),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontFamily: 'Nunito', fontSize: 14),
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
