import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_read/constants/colours.dart';
import 'package:quick_read/constants/strings.dart';
import 'package:quick_read/routes/route_names.dart';
import 'package:quick_read/services/email_authentication.dart';

class EmailLoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
  void onChanged(String value) {
    log(value);
    update();
  }

  final AuthService authService = AuthService();

  Future<void> onEmailSignIn({required context}) async {
    final UserCredential signInResult;
    try {
      signInResult = await authService.emailSignIn(
          email: email.text, password: password.text);
      if (signInResult.user!.emailVerified) {
        // userID = signInResult.user!.uid;
      }
      const ScaffoldMessenger(
        child: Text(
          Strings.loginSuccessful,
          style: TextStyle(color: kPrimaryBlack),
        ),
      );
      Get.toNamed(RouteName.pdfListScreen);
      update();
      log(signInResult.user.toString());
    } catch (e) {
      final error = e.toString();
      log("Email Signup error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kGrey,
          content: Text(
            "Error: $error",
            style: const TextStyle(color: kPrimaryBlack),
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

}