import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_read/constants/colours.dart';
import 'package:quick_read/constants/dismiss_keyboard.dart';
import 'package:quick_read/constants/strings.dart';
import 'package:quick_read/screens/login/email_login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = EmailLoginController();
    return Scaffold(
      backgroundColor: kPrimaryWhite,
      body: kUnfocus(
        child: SafeArea(
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
                            await prov.onEmailSignIn(context: context);
                            // log(prov.uid);
                          },
                          style:
                              TextButton.styleFrom(backgroundColor: kIconRed),
                          child: const Text(
                            "Email Sign-in",
                            style: TextStyle(color: kPrimaryWhite),
                          )),
                      SizedBox(width: 20.w),
                      TextButton(
                          onPressed: () {},
                          style:
                              TextButton.styleFrom(backgroundColor: kIconRed),
                          child: const Text(
                            "Google Sign-in",
                            style: TextStyle(color: kPrimaryWhite),
                          )),
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
