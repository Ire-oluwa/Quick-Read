import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_read/routes/route_names.dart';
import 'package:quick_read/services/google_signin.dart';

/// NOT USEFUL
//TODO: DELETE
class GoogleLoginController extends GetxController {
  Future<void> googleSignIn({required context}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignInService signInService = GoogleSignInService();
    // try {
    //   final signInResult = await signInService.signInWithGoogle();
    //   if (auth.currentUser != null) {
    //     Get.toNamed(RouteName.pdfListScreen);
    //   }
    // } catch (e) {
    //   final error = e.toString();
    //   log("Google Sign In Error: $error");
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text(error, style: const TextStyle(color: kPrimaryBlack),),
    //     ),
    //   );
    // }
    signInService.signInWithGoogle()
        .catchError((error) {
      log("Google Sign In Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
      return error;
    }).then((signInResult) {
      if (auth.currentUser != null) {
        Get.toNamed(RouteName.pdfListScreen);
      }
    });
  }

}
