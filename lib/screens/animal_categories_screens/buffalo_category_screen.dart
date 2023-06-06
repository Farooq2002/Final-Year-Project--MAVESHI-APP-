import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maveshi/screens/product_detail_screen.dart';

import './/widgets/animal_list_tile.dart';
import '../../models/livestock_model.dart';

class BuffaloCategoryScreen extends StatefulWidget {
  final String animalType;

  static const routeName = 'buffalo-category';

  const BuffaloCategoryScreen({
    Key? key,
    required this.animalType,
  }) : super(key: key);

  @override
  State<BuffaloCategoryScreen> createState() => _BuffaloCategoryScreenState();
}

class _BuffaloCategoryScreenState extends State<BuffaloCategoryScreen> {
  final CollectionReference livestockCollection =
      FirebaseFirestore.instance.collection('SellYourAnimal');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buffalo'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: livestockCollection
            .where('animalType', isEqualTo: 'buffalo')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Livestock livestock = Livestock.fromSnapshot(document);

              return AnimalListTile(
                name: livestock.sellerName ?? '',
                subTitle: livestock.price ?? '',
                image: livestock.imagePath.toString(),
                description: livestock.description ?? '',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnimalDetailScreen(
                                livestockDetails: livestock,
                              )));
                },
              );
            },
          );
        },
      ),
    );
  }
}
