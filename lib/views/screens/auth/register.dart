import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/jabatan_controller.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/models/jabatan.dart';
import 'package:permit_app/models/user_model.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/const/components/rounded_input_field.dart';
import 'package:permit_app/views/screens/home/home_screen.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final UserController userController = Get.put(UserController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final JabatanController jabatanController = Get.put(JabatanController());
  RxBool _isLoading = false.obs;

  Future<void> _register() async{
    try{
      await userController.register(
          usernameController.text,
          passwordController.text,
          nameController.text,
          jabatanController.selectedItem.value!.name
      );

      User? loggedInUser = userController.user.value;

      if(loggedInUser != null){
        Get.off(() => HomeScreen(userId: loggedInUser.id!,));
      }else {
        Get.snackbar('Login Failed', 'Invalid credentials');
      }
    } catch (e){
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
                    "Create Account",
                    style: TextStyle(
                        fontSize: 30.h,
                        color: kDark,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    child: DropdownButton<Jabatan>(
                      isExpanded: true,
                      icon: const Icon(Icons.work),
                      hint: Text('Jabatan'),
                      value: jabatanController.selectedItem.value,
                      onChanged: (Jabatan? newValue) {
                        jabatanController.selectItem(newValue);
                      },
                      items: jabatanController.items.map((Jabatan item) {
                        return DropdownMenuItem<Jabatan>(
                          value: item,
                          child: Text(item.name),
                        );
                      }).toList(),
                    ),
                  ),
                  RoundedInputFieldAuth(
                    hintText: "Nama Lengkap",
                    icon: Icons.person,
                    controller: nameController,
                  ),
                  RoundedInputFieldAuth(
                    hintText: "Username",
                    controller: usernameController,
                  ),
                  RoundedInputPassword(controller: passwordController, title: 'Password',),
                  RoundedInputPassword(controller: confirmPasswordController, title: 'Confirm Password',),
                  SizedBox(height: 20.h,),
                  RoundedButton(
                      text: _isLoading.value ? 'Loading ...' : "Sign Up",
                      color: _isLoading.value ? kGrey : kPrimaryColor,
                      textColor: kDark,
                      press: _isLoading.value ? (){} : () async{
                        if( nameController.text != '' && usernameController.text != '' && passwordController.text != '' && confirmPasswordController.text != ''){
                          if(passwordController.text == confirmPasswordController.text){
                            if(passwordController.text.length >= 6){
                              _isLoading.value = true;
                              await _register();
                              _isLoading.value = false;
                            } else {
                              Get.snackbar('Error', 'Password harus lebih dari 6 karakter!', backgroundColor: kDanger, colorText: kLight);
                            }
                          } else {
                            Get.snackbar('Error', 'Password dan Confirm Password tidak sesuai!', backgroundColor: kDanger, colorText: kLight);
                          }
                        } else {
                          Get.snackbar('Error', 'Data harus diisi semua!', backgroundColor: kDanger, colorText: kLight);
                        }
                      }
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
