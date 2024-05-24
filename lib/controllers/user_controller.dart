import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permit_app/helpers/api.dart';
import 'package:permit_app/helpers/shared_pref.dart';
import 'package:permit_app/models/user_model.dart';
import 'package:permit_app/providers/user_provider.dart';
import 'package:permit_app/services/firebase_cloud_messaging_service.dart';
import 'package:permit_app/views/screens/home/home_screen.dart';
import 'package:permit_app/views/screens/splash/splash.dart';

class UserController extends GetxController {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController namaController;
  late TextEditingController roleController;
  late TextEditingController confirmPasswordController;
  var user = Rxn<User>();
  Dio dio = Dio();


  @override
  void onInit() async{
    super.onInit();
    usernameController = TextEditingController();
    namaController = TextEditingController();
    passwordController = TextEditingController();
    roleController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void setUser(User newUser) {
    user.value = newUser;
  }

  checkUser() async{
    var users = await SharedPref().getUser();
    if(users != null){
      // Get.off(() => Home(id: json.decode(users)['id']));
      Get.off(() => HomeScreen(userId: json.decode(users)['id'],));
    } else {
      Get.off(() => const Splash());
    }
  }

  Future<void> login(String username, String password) async {
    try {
      final fcm_token = await FirebaseCloudMessagingService.getFcmToken();
      var response = await dio.post(
        '${Api.baseUrl}/login',
        data: {
          'username': username,
          'password': password,
          'fcm_token': fcm_token
        },
      );

      if (response.statusCode == 200) {
        var userData = response.data['data'];
        User loggedInUser = User.fromJson(userData);
        setUser(loggedInUser);
        await SharedPref().storeUser(json.encode(loggedInUser));
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(String username, String password, String name, String role) async{
    try{
      final fcmToken = await FirebaseMessaging.instance.getToken();
      var response = await dio.post(
          '${Api.baseUrl}/register',
          data: {
            'username': username,
            'password': password,
            'name': name,
            'role': role,
            'fcm_token': fcmToken
          }
      );

      if (response.statusCode == 200){
        var userData = response.data['data'];
        User registeredUser = User.fromJson(userData);
        setUser(registeredUser);
        await SharedPref().storeUser(json.encode(registeredUser));
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e){
      rethrow;
    }
  }

  Future<void> getDetail(int id) async {
    try {
      var userData = await UserProvider().getDetailUser(id);
      user.value = userData;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> logout() async{
    await SharedPref().removeUser();
    Get.offAll(()=> const Splash());
  }
}