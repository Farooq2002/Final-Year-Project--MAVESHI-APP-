import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maveshi/widgets/round_button.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/utils.dart';
import '../../../widgets/textfield_normal.dart';

class BuyerSignUp extends StatefulWidget {
  static const routeName = 'buyer';
  const BuyerSignUp({Key? key}) : super(key: key);

  @override
  State<BuyerSignUp> createState() => _BuyerSignUpState();
}

class _BuyerSignUpState extends State<BuyerSignUp> {
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('buyer');
  bool loading = false;
  void signUpBuyer() {
    var uuid = const Uuid().v1();

    fireStore.doc(uuid).set({
      'fullName': fullNameController.text,
      'address': addressController.text,
      'phone': phoneNumberController.text,
      'buyerID': uuid
    }).then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage('Completed Successfully!');
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('As a Buyer'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: fullNameController,
                labelText: 'Name',
                hintText: 'Full Name',
                icon: Icons.person,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: phoneNumberController,
                labelText: 'Phone',
                hintText: 'Enter phone Number',
                icon: Icons.phone,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: addressController,
                labelText: 'Address',
                hintText: 'Address',
                icon: Icons.location_on,
              ),
              const SizedBox(
                height: 10,
              ),
              RoundButton(title: 'Register', onPress: () {})
            ],
          ),
        ),
      ),
    );
  }
}
