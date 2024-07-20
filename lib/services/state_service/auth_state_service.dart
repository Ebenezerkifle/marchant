import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class AuthStateService with ListenableServiceMixin {
  AuthStateService() {
    listenToReactiveValues([_phoneNum]);
  }

  final _phoneNum = ReactiveValue<String>('');
  String get phoneNum => _phoneNum.value;


  setPhoneNum(String phone) {
    _phoneNum.value = phone;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _setFirebaseLanguageCode() {
    _auth.setLanguageCode('en');
  }

// Authenticate with phone number
  authenticateWithPhoneNumber(
      String phoneNumber,
      Function(PhoneAuthCredential credential) verificationCompleted,
      Function(FirebaseAuthException e) verificationFailed,
      Function(String verificationId, int? resendToken) codeSent,
      Function(String verificationId) codeAutoRetrievalTimeout) async {
    _setFirebaseLanguageCode(); // Set the language code before authentication

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      verificationFailed: verificationFailed,
    );
  }
}
