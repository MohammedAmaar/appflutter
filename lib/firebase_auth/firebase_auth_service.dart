


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class FirebaseServise {

  FirebaseAuth _auth = FirebaseAuth.instance;
  String? error;

  Future<User?> signUpEmailAndPass(BuildContext context, String email,
      String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('email is already!'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('no internet!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
      return null;
    }
  }
  Future<User?> signInEmailAndPass(BuildContext context, String email,
      String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
      return credential.user;
    } catch (e) {


      if (e is FirebaseAuthException) {
        print(e.code);
        if (e.code =="network-request-failed"){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('no internet'),
              backgroundColor: Colors.red,
            ),
          );
        }else if (e.code =="too-many-requests"){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Try again later, due to high volume of requests!'),
              backgroundColor: Colors.red,
            ),
          );
        }else if(e.code =="invalid-credential"){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('email or password is valid!'),
              backgroundColor: Colors.red,
            ),
          );
        }else if(e.code =="invalid-email"){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('email  is valid!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }else{
        print(e);
      }
    }
  }
}