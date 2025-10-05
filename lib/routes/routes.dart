import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:healnixd/screens/auth/bindings/auth_binding.dart';
import 'package:healnixd/screens/auth/forget_password_screen.dart';
import 'package:healnixd/screens/auth/login_screen.dart';
import 'package:healnixd/screens/auth/otp_screen.dart';
import 'package:healnixd/screens/auth/register_screen.dart';
import 'package:healnixd/screens/auth/reset_password_screen.dart';
import 'package:healnixd/screens/auth/splash_screen.dart';
import 'package:healnixd/screens/bottom_bar/bindings/bottom_nav_binding.dart';
import 'package:healnixd/screens/bottom_bar/bottom_navigation_menu.dart';
import 'package:healnixd/screens/home/bindings/home_bindings.dart';
import 'package:healnixd/screens/home/home_screen.dart';
import 'package:healnixd/screens/medicines/bindings/medicines_stock_binding.dart';
import 'package:healnixd/screens/medicines/medicines_stock_screen.dart';
import 'package:healnixd/screens/onboarding/onboarding_slider_screen.dart';
import 'package:healnixd/screens/profile/bindings/profile_binding.dart';
import 'package:healnixd/screens/profile/profile_screen.dart';

class ApplicationRoutes {
  static const String splashScreen = '/';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String forgetPasswordScreen = '/forget-password';
  static const String resetPasswordScreen = '/reset-password';
  static const String otpVerificationScreen = '/otp-verification';
  static const String onboardingScreen = '/onboarding';
  static const String bottomNavigationMenu = '/bottom-navigation-menu';
  static const String homeScreen = '/home';
  static const String medicinesStockScreen = '/medicines';
  static const String profileScreen = '/profile';
  static const String premiumPlanScreen = '/premium-plan';

  static List<GetPage>? getApplicationPages() => [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(name: otpVerificationScreen, page: () => OtpScreen()),
    GetPage(
      name: resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: registerScreen,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(name: onboardingScreen, page: () => const OnboardingSliderScreen()),
    GetPage(
      name: bottomNavigationMenu,
      page: () => BottomNavigationMenu(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: medicinesStockScreen,
      page: () => MedicinesStockScreen(),
      binding: MedicinesStockBinding(),
    ),
    GetPage(
      name: profileScreen,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];
}
