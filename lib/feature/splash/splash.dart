import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transite_way/core/resources/color_manager.dart';
import 'package:transite_way/core/routes/routes_manager.dart';

class Splash extends StatefulWidget{
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,

    ));
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, RoutesManager.login);

      });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.green,
      body: Center(
        child: Text('TransitWay',style: GoogleFonts.inter(
          color: ColorManager.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2),),
      )

    );
  }}