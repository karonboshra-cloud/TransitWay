import 'package:flutter/material.dart';
import 'package:transite_way/feature/login/login.dart';
import 'package:transite_way/feature/onboarding/screen/onboarding_screen.dart';
import 'package:transite_way/feature/splash/splash.dart';
import 'package:transite_way/feature/forget_password/presentation/screens/recovery_screen.dart';
import 'package:transite_way/feature/home/presentation/screens/home_screen.dart';

import '../../feature/home/presentation/screens/bus_tracking_screen.dart';
import '../../feature/home/presentation/widgets/main_wrapper.dart';

abstract class RoutesManager {
  static const String splash = "/splash";
  static const String onboardingScreen = "/onboardingScreen";
  static const String login = "/login";
  static const String forgetPassword = "/forgetPassword";
  static const String mainWrapper = "/mainWrapper";
  static const String home = "/home";
  static const String busTracking = "/busTracking";

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const Splash(),
    onboardingScreen: (context) => const OnboardingScreen(),
    login: (context) => const LoginScreen(),
    forgetPassword: (context) => const PasswordRecoveryScreen(),
    mainWrapper: (context) => const MainWrapper(),
    home: (context) => const HomeScreen(),
    busTracking: (context) => const BusTrackingScreen(),
  };
}