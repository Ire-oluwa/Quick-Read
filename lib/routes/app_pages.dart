import 'package:get/get_navigation/get_navigation.dart';
import 'package:quick_read/routes/route_names.dart';
import 'package:quick_read/screens/login/login_screen.dart';
import 'package:quick_read/screens/onboarding/onboarding_screen.dart';
import 'package:quick_read/screens/pdf/view_pdf.dart';
import 'package:quick_read/screens/registration/registration_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: RouteName.registration, page: ()=> const RegistrationScreen()),
    GetPage(name: RouteName.pdfListScreen, page: ()=> PdfView()),
    GetPage(name: RouteName.onboardingScreen, page: ()=> const OnboardingScreen()),
    GetPage(name: RouteName.login, page: ()=> const LoginScreen()),
  ];
}