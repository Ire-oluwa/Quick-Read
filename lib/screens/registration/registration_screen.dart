import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quick_read/constants/colours.dart';
import 'package:quick_read/constants/dismiss_keyboard.dart';
import 'package:quick_read/constants/strings.dart';
import 'package:quick_read/routes/route_names.dart';
import 'package:quick_read/screens/registration/email_registration.dart';
import 'package:quick_read/services/email_authentication.dart';
import 'package:quick_read/services/google_signin.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = EmailRegistrationController();
    // final googleProv = GoogleLoginController();
    final googleProv = GoogleSignInService();
    return kUnfocus(
      child: Scaffold(
        backgroundColor: kPrimaryWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  TextField(
                    controller: prov.email,
                    decoration: const InputDecoration(hintText: Strings.email),
                    onChanged: (value) => prov.onChanged(value),
                  ),
                  TextField(
                    controller: prov.password,
                    decoration:
                        const InputDecoration(hintText: Strings.password),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () async {
                            await prov.onEmailSignUp(context: context);
                          },
                          style:
                              TextButton.styleFrom(backgroundColor: kIconRed),
                          child: const Text(
                            "Email Signup",
                            style: TextStyle(color: kPrimaryWhite),
                          )),
                      SizedBox(width: 20.w),
                      TextButton(
                        onPressed: () async {
                          await googleProv.signInWithGoogle();
                        },
                        style: TextButton.styleFrom(backgroundColor: kIconRed),
                        child: const Text(
                          Strings.googleLogin,
                          style: TextStyle(color: kPrimaryWhite),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      TextButton(
                        onPressed: () async {
                          await AuthService().signOut();
                        },
                        style: TextButton.styleFrom(backgroundColor: kIconRed),
                        child: const Text(
                          Strings.googleLogout,
                          style: TextStyle(color: kPrimaryWhite),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.alreadyAMember,
                        style: TextStyle(fontSize: 16.sp, color: kPrimaryBlack),
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(RouteName.login),
                        child: Text(
                          Strings.login,
                          style: TextStyle(fontSize: 16.sp, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
