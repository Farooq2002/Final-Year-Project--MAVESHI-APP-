import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = 'fav-screen';
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
