import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ... other methods for authentication

  Future<void> phoneAuthentication(String phoneNo) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Handle automatic verification completion
          // ...
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          // ...
        },
        codeSent: (String verificationId, int? resendToken) {
          // Handle code sent
          // ...
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle auto-retrieval timeout
          // ...
        },
      );
    } catch (e) {
      // Handle unexpected errors
      // ...
    }
  }
}