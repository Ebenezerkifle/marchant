

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
  final AuthStateService _stateService = locator<AuthStateService>();
  final NavigationService _navigation = locator<NavigationService>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _phoneNum => _stateService.phoneNum;
  String _verificationId = '';

  OtpViewModel() {
    _init();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_stateService];

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  bool verificationError = false;
  bool otpVerified = false;
  String _errorMsg = '';
  String get errorMsg => _errorMsg;
  bool _codeSent = false;
  bool get codeSent => _codeSent;
  bool get hasError => verificationError || _errorMsg.isNotEmpty;

  String _otp = '';
  String get otp => _otp;

  Timer? countdown;
  Duration myDuration = const Duration(minutes: 1);

  String get title => 'phone_verification'.tr();
  String get instruction => 'enter_otp_msg'.tr();

  void _init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendOtp();
    });
    _startTimer();
  }

  void setOtp(String value) {
    _otp = value;
    onVerify();
  }

  void onVerify() {
    if (_otp.length == 6) {
      _otpVerification();
    }
  }

  void _sendOtp() async {
    await _stateService.authenticateWithPhoneNumber(
      _phoneNum,
      (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        _pushToChangePassPage();
      },
      (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          _errorMsg = "Invalid Phone Number";
        } else {
          _errorMsg = "something_went_wrong".tr();
        }
        verificationError = true;
        setBusy(false);
        notifyListeners();
      },
      (String verificationId, int? resendToken) {
        _errorMsg = '';
        _verificationId = verificationId;
        verificationError = false;
        _codeSent = true;
        setBusy(false);
        notifyListeners();
      },
      (String verificationId) {
        verificationError = true;
        _verificationId = verificationId;
        _errorMsg = 'time_out'.tr();
        setBusy(false);
        notifyListeners();
      },
    );
  }

  void _otpVerification() async {
    setBusy(true);
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otp,
      );
      var user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        otpVerified = true;
        setBusy(false);
        _pushToChangePassPage();
      }
    } catch (e) {
      verificationError = true;
      _errorMsg = 'Invalid Code!';
      setBusy(false);
      notifyListeners();
    }
  }

  void _startTimer() {
    countdown =
        Timer.periodic(const Duration(seconds: 1), (_) => _setCountDown());
  }

  void _setCountDown() {
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
    _sendOtp();
    _startTimer();
    notifyListeners();
  }

  void resendOtp() {
    if (!_codeSent) return;
    resetTimer();
  }

  void _pushToChangePassPage() {
    _navigation.navigateToChangePasswordView(forget: true);
  }

  @override
  void dispose() {
    countdown?.cancel();
    super.dispose();
  }
}
