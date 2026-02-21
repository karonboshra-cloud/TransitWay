import 'package:flutter/cupertino.dart';
import 'package:transite_way/feature/login/login.dart';
import 'package:transite_way/feature/onboarding/screen/onboarding_screen.dart';
import '../../feature/splash/splash.dart';

abstract class RoutesManager{
  static const String splash="/splash";
  static const String onboardingScreen="/onboardingScreen";
  static const String login="/login";




  static Map<String,WidgetBuilder> routes={
    splash:(context)=>Splash(),
    onboardingScreen:(context)=>OnboardingScreen(),
    login:(context)=>LoginScreen(),


  };
}