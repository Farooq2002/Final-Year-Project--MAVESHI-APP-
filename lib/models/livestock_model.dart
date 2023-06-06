import 'package:cloud_firestore/cloud_firestore.dart';

class Livestock {
  final String? sellerName;
  final String? age;
  final String? phone;
  final String? description;
  final String? price;
  final String? weight;
  final String? imagePath;
  final String? animalType;
  final String? uid;

  Livestock({
    this.sellerName,
    this.age,
    this.phone,
    this.description,
    this.price,
    this.weight,
    this.imagePath,
    this.animalType,
    this.uid,
  });

  factory Livestock.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Livestock(
      sellerName: data['sellerName'],
      age: data['age'],
      phone: data['phone'],
      description: data['description'],
      price: data['price'],
      weight: data['weight'],
      imagePath: data['imagePath'],
      animalType: data['animalType'],
      uid: data['uid'],
    );
  }
}
