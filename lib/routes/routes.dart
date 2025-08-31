import 'package:get/get_navigation/src/routes/get_route.dart';

class ApplicationRoutes {
  static const String splashScreen = '/';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String onboardingScreen = '/onboarding';
  static const String homeScreen = '/home';
  static const String medicinesScreen = '/medicines';
  static const String profileScreen = '/profile';

  static List<GetPage>? getApplicationPages() => [
    // GetPage(name: '', page: () => const Placeholder()),
  ];
}