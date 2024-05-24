import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permit_app/services/local_notification_service.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/screens/auth/login.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.requestPermissionAndroid13();
    return AnimatedSplashScreen(
        duration: 3000,
        splash: Container(
          height: 100.h,
          width: 75.h,
          decoration: BoxDecoration(
            color: kGrey,
            borderRadius: BorderRadius.circular(100.h)
          ),
          child: Center(
            child: Text(
              "Loading",
              style: TextStyle(
                fontSize: 16.h,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            ),
          ),
        ),
        nextScreen: LoginScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: kPrimaryColor
    );
  }
}
