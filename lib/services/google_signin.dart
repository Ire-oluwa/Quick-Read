import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quick_read/routes/route_names.dart';

class GoogleSignInService extends GetxController{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuth =
        await googleSignInAccount?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuth?.accessToken,
      idToken: googleSignInAuth?.idToken,
    );
    if (auth.currentUser != null){
      Get.toNamed(RouteName.pdfPreview);
    }
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> googleLogOut() async {
    if (!kIsWeb){
      await _googleSignIn.signOut();
    }
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
