// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'UserModule.dart';
// import 'Repository.dart';
//
//
// class SignUpController extends GetxController {
//   static SignUpController get instance => Get.find();
//
//   //TextField Controllers to get data from TextFields
//   final email = TextEditingController();
//   final password = TextEditingController();
//   final fullName = TextEditingController();
//   final phoneNo = TextEditingController()
//   final address = TextEditingController();
//
//   final userRepo = Get.put(UserRepository());
//
//   //Call these Functions from Design & they will do the logic
//   void registerUser(String email, String password) {
//     String? error = AuthenticationRepository.instance;
//         .createUserWithEmailAndPassword(email, password) as String?;
//     if (error != null) {
//       Get.showSnackbar(GetSnackBar(message: error.toString()));
//     }
//   }
//
//   //Get phoneNo from user and pass it to Auth Repository for Firebase Authentication
//   Future<void> createUser(UserModel user) async {
//     await userRepo.createUser(user);
//     phoneAuthentication(user.phone);
//     Get.to(() => const OTPScreen());
//   }
//
//   void phoneAuthentication(String phoneNo) {
//     AuthenticationRepository.instance.phoneAuthentication(phoneNo);
//   }
// }
