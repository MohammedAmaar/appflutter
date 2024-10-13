import 'package:cloud_firestore/cloud_firestore.dart';


import 'dart:io';

class UserRepository {
  // ...

  Future<void> saveUserData(
      String id,
      String fullname,
      String username,
      String email,
      String address,
      String phoneNumber,
      String birthday,
      File? image,
      ) async {

    List<int> imageData = await image!.readAsBytes();


    await FirebaseFirestore.instance.collection('users').doc(id).set({
      'id':id,
      'fullname': fullname,
      'username': username,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber,
      'birthday': birthday,
      'image': imageData, // Save the image data as a byte array
    });
  }
}