import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_read/constants/colours.dart';
import 'package:quick_read/constants/strings.dart';
import 'package:quick_read/routes/route_names.dart';
import 'package:quick_read/services/email_authentication.dart';

class EmailRegistrationController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  late String userID;

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

  Future<void> onEmailSignUp({required context}) async {
    final UserCredential signUpResult;
    try {
      signUpResult = await authService.emailSignUp(
          email: email.text, password: password.text);
      if (signUpResult.user!.emailVerified) {
        userID = signUpResult.user!.uid;
      }
      const ScaffoldMessenger(
        child: Text(
          Strings.registrationSuccessful,
          style: TextStyle(color: kPrimaryBlack),
        ),
      );
      Get.toNamed(RouteName.pdfPreview);
      update();
      log(signUpResult.user.toString());
    } catch (e) {
      final error = e.toString();
      log("Email Signup error: $error");
      // ScaffoldMessenger(child: Text("Error: $error", style: const TextStyle(color: kPrimaryBlack),),);
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
