import 'dart:html';

import 'package:flutter/material.dart';

class UserModel{
  final String? id;
  final String Fullname;
  final String email;
  final String username;
  final String address;
  final String phone;
  final String brith;
  final File? image;

  const UserModel({
    this.id,
    required this.Fullname,
    required this.email,
    required this.username,
    required this.address,
    required this.phone,
    required this.brith,
    this.image
  });
  toJson(){
    return {
      "Fullname":Fullname,
      "email":email,
      "password":username,
      "address":address,
      "phone":phone,
      "brith":brith,
      "image":image
    };


  }

}