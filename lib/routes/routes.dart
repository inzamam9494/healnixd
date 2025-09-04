import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:healnixd/screens/auth/forget_password_screen.dart';
import 'package:healnixd/screens/auth/login_screen.dart';
import 'package:healnixd/screens/auth/otp_screen.dart';
import 'package:healnixd/screens/auth/register_screen.dart';
import 'package:healnixd/screens/auth/reset_password_screen.dart';
import 'package:healnixd/screens/auth/splash_screen.dart';
import 'package:healnixd/screens/home/home_screen.dart';

class ApplicationRoutes {
  static const String splashScreen = '/';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String forgetPasswordScreen = '/forget-password';
  static const String resetPasswordScreen = '/reset-password';
  static const String otpVerificationScreen = '/otp-verification';
  static const String onboardingScreen = '/onboarding';
  static const String homeScreen = '/home';
  static const String medicinesScreen = '/medicines';
  static const String profileScreen = '/profile';

  static List<GetPage>? getApplicationPages() => [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: forgetPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: otpVerificationScreen, page: () => const OtpScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: registerScreen, page: () => const RegisterScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),

  ];
}
