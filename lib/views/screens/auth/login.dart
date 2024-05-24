import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/models/user_model.dart';
import 'package:permit_app/services/firebase_cloud_messaging_service.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/const/components/rounded_input_field.dart';
import 'package:permit_app/views/screens/auth/register.dart';
import 'package:permit_app/views/screens/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final UserController userController = Get.put(UserController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool _isLoading = false.obs;

  Future<void> _login() async {
    try {
      await userController.login(usernameController.text, passwordController.text);
      User? loggedInUser = userController.user.value;

      if (loggedInUser != null) {
        // Get.off(() => Home(id: loggedInUser.id!)); // Navigate to home screen
        Get.off(() => HomeScreen(userId: loggedInUser.id!,)); // Navigate to home screen
      } else {
        Get.snackbar('Login Failed', 'Gagal Login');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during login: $e');
      }
      Get.snackbar('Error', 'An error occurred while logging in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("./assets/bg.png"),
                  fit: BoxFit.fill
              )
            ),
            child: SafeArea(
              child: Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "MyPermit",
                      style: TextStyle(
                          fontSize: 36.h,
                          color: kDark,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.none
                      ),
                    ),
                    RoundedInputFieldAuth(
                      hintText: "Username",
                      controller: usernameController,
                    ),
                    RoundedInputPassword(controller: passwordController,),
                    SizedBox(height: 20.h,),
                    RoundedButton(
                        text: _isLoading.value ? "Loading..." : "Sign In",
                        color: _isLoading.value ? kGrey : kPrimaryColor,
                        textColor: kDark,
                        press: _isLoading.value ? (){} : () async{
                          if(usernameController.text != '' && passwordController.text != ''){
                            _isLoading.value = true;
                            await _login();
                            _isLoading.value = false;
                          } else {
                            Get.snackbar('Error', 'username / password tidak boleh kosong !', backgroundColor: kDanger, colorText: kLight);
                          }
                        }
                    ),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                              fontSize: 14.h,
                              fontStyle: FontStyle.italic
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(() => Register()),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 14.h,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              })
            ),
        ),
      ),
    );
  }
}
