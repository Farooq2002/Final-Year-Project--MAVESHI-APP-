import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maveshi/screens/auth/sign_in_screen.dart';
import 'package:maveshi/screens/bottom_nav_bar_screens/profile_screen.dart';
import 'package:maveshi/utils/fonts.dart';
import 'package:maveshi/widgets/round_button.dart';

import '../../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'signup';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userNameController = TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;
  final fireStore = FirebaseFirestore.instance.collection('user');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _currentMessage = "";

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark currentPlace = placeMarks[0];

    setState(() {
      _currentMessage =
          '${currentPlace.subLocality}  ${currentPlace.locality} , ${currentPlace.administrativeArea} ';
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  //=====================sign up==============================
  void signUp() {
    setState(() {
      loading = true;
    });
    var fullName = userNameController.text.trim();
    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((error) {
      //var userId = const Uuid().v1();
      final currentUser = FirebaseAuth.instance.currentUser?.uid;

      fireStore
          .doc(currentUser)
          .set({
            'UserName': fullName,
            'UserEmail': email,
            'TimeCreation': DateTime.now().year,
            "location": _currentMessage,
            'UserId': currentUser,
          })
          .then((value) => {
                setState(() {
                  loading = false;
                }),
                Utils().toastMessage('Profile Completed!'),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()))
              })
          .onError((error, stackTrace) {
            setState(() {
              loading = false;
            });
            return Utils().toastMessage(error.toString());
          });
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  child: Column(
                    children: [
                      Text(
                        "Getting Started",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Seem your are new here!",
                        style: AppFonts.normalText,
                      ),
                      Text(
                        "Let's setup your profile",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: userNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: "Name",
                            prefixIcon: const Icon(Icons.person)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter your Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            prefixIcon: const Icon(Icons.alternate_email)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter your email!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: _currentMessage,
                            hintText: _currentMessage,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            prefixIcon: const Icon(Icons.location_on)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter your email!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_open)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter your password!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: 'Confirm password',
                            prefixIcon: const Icon(Icons.lock_open)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter your password!';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              const SizedBox(
                height: 40,
              ),
              RoundButton(
                  loading: loading,
                  title: 'Sign Up',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      signUp();
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text('Login'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
