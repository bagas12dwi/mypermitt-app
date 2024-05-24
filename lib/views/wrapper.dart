import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/views/screens/splash/splash.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final UserController userController = Get.put(UserController());

  Future<void> checkUser() async {
    await userController.checkUser();
  }


  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, builer) => OrientationBuilder(
            builder: (context, Orientation orientation) {
              return const Splash();
            }
        )
    );
  }
}
