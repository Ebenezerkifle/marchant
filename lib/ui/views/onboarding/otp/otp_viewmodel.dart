import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/services/state_service/auth_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import 'package:otp_text_field/otp_field.dart';

class OtpViewModel extends ReactiveViewModel {
  OtpFieldController otpbox = OtpFieldController();
  TextEditingController otpController = TextEditingController();
  final AuthStateService _stateService = locator<AuthStateService>();
  final NavigationService _navigation = locator<NavigationService>();
  String get _phoneNum => _stateService.phoneNum;
  String _verificationId = '';

OtpViewModel() {
    _init();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_stateService];

  void _init() {
    setBusy(true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendOtp();
    });
    _startTimer();
  }

  bool verificationError = false;
  bool otpVerified = false;
  String _errorMsg = '';
  String get errorMsg => _errorMsg;
  bool _codeSent = false;
  bool get codeSent => _codeSent;

  String _otp = '';


  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  Timer? countdown;
  Duration myDuration = const Duration(minutes: 1);


  String get title => 'phone_verification'.tr();
  String get instruction => 'enter_otp_msg'.tr();

  void setOtp(String value) {
    _otp = value;
    onVerify();
  }

  void onVerify() {
    if (_otp.length == 6) {
      _otpVerification();
    }
  }

  _sendOtp() async {
    Future.delayed(Duration.zero, () async {
      phoneVerification();
    });
  }


  void _startTimer() {
    countdown =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final seconds = myDuration.inSeconds - 1;
    if (seconds < 0) {
      countdown!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
    notifyListeners();
  }

  void stopTimer() {
    countdown?.cancel();
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    myDuration = const Duration(minutes: 1);
    notifyListeners();
  }

  @override
  void dispose() {
    countdown?.cancel();
    super.dispose();
  }

  void phoneVerification() async {
    await _stateService.authenticateWithPhoneNumber(
      _phoneNum,
       //verificationCompleted
      (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        // todo
        notifyListeners();
        return false;
      },
       //verificationFailed
      (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          _errorMsg = "Invalid Phone Number";
          verificationError = true;
          setBusy(false);
          setError(true);
          notifyListeners();
          return false;
        } else {
          verificationError = true;
          _errorMsg = "something_went_wrong".tr();
          setBusy(false);
          setError(true);
          notifyListeners();
          return false;
        }
      },
      //codeSent
      (String verificationId, int? resendToken) {
        _errorMsg = '';
        _verificationId = verificationId;
        verificationError = false;
        _codeSent = true;
        // _pushToOtpPage();
        setError(false);
        setBusy(false);
        notifyListeners();
        return true;
      },
      //codeAutoRetrievalTimeout
      (String verificationId) {
        verificationError = true;
        _verificationId = verificationId;
        _errorMsg = 'time_out'.tr();
        setError(true);
        setBusy(false);
        notifyListeners();
        return false;
      },
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  
  _otpVerification() async {
    setBusy(true);
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: _otp);
      var user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        otpVerified = true;
        setBusy(false);
        setError(false);
        // navigate to the change password page.
        _pushToChangePassPage();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      verificationError = true;
      setError(true);
      _errorMsg = 'Invalid Code!';
      setBusy(false);
      notifyListeners();
    }
    return false;
  }



  void _pushToChangePassPage() {
    _navigation.navigateToChangePasswordView(forget: true);
  }

  
}
