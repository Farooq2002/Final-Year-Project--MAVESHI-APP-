import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './/widgets/animal_list_tile.dart';
import '../../models/livestock_model.dart';
import '../product_detail_screen.dart';

class SheepCategoryScreen extends StatefulWidget {
  final String animalType;
  static const routeName = 'sheep-category';

  const SheepCategoryScreen({Key? key, required this.animalType})
      : super(key: key);

  @override
  State<SheepCategoryScreen> createState() => _SheepCategoryScreenState();
}

class _SheepCategoryScreenState extends State<SheepCategoryScreen> {
  final CollectionReference livestockCollection =
      FirebaseFirestore.instance.collection('SellYourAnimal');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sheep'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: livestockCollection
            .where('animalType', isEqualTo: 'sheep')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
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
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnimalDetailScreen(
                                  livestockDetails: livestock,
                                )));
                  },
                  name: livestock.sellerName ?? '',
                  subTitle: livestock.price ?? '',
                  image: livestock.imagePath ?? '',
                  description: livestock.description ?? '');
            },
          );
        },
      ),
    );
  }
}
