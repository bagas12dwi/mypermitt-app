import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/helpers/helper.dart';
import 'package:permit_app/models/user_model.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/approve_permit/approve_permit_screen.dart';
import 'package:permit_app/views/screens/history/history_screen.dart';
import 'package:permit_app/views/screens/home/components/card_home_screen.dart';
import 'package:permit_app/views/screens/open_permit/open_permit.dart';
import 'package:permit_app/views/screens/request_permit/request_permit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.userId});
  final int userId;
  final UserController userController = Get.put(UserController());

  Future<void> _loadData() async{
    await userController.getDetail(userId);
  }

  Future<void> _logout() async{
    await userController.logout();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadData(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if(snapshot.hasError){
          return const Center(child: Text('Error Loading Data'),);
        } else {
          return Scaffold(
            backgroundColor: kLight,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kLight,
              title: Obx(() {
                var user = userController.user.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Welcome, ",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      Helper.getFirstText(user?.name ?? ''),
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                );
              })
            ),
            body: Obx(() {
              var user = userController.user.value;
              return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Menu",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.h
                            ),
                          ),
                          SizedBox(height: 30.h,),
                          user!.role != 'HSE' ?
                          CardHomeScreen(
                            text: 'REQUEST PERMIT',
                            onTap: () => Get.to(() => RequestPermitScreen()),
                          ) : Container(),
                          SizedBox(height: 10.h,),
                          CardHomeScreen(
                            text: 'APROVE PERMIT',
                            onTap: () => Get.to(() => ApprovePermitScreen()),
                          ),
                          SizedBox(height: 10.h,),
                          CardHomeScreen(
                            text: 'OPEN PERMIT',
                            onTap: () => Get.to(() => OpenPermitScreen()),
                          ),
                          SizedBox(height: 10.h,),
                          CardHomeScreen(
                            text: 'HISTORY',
                            onTap: () => Get.to(() => HistoryScreen()),
                          ),
                          SizedBox(height: 10.h,),
                          CardHomeScreen(
                            text: 'LOGOUT',
                            onTap: () {
                              Get.defaultDialog(
                                  title: "Konfirmasi",
                                  middleText: 'Apakah anda yakin untuk log out?',
                                  actions: [
                                    RoundedButtonDialog(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      title: "Tidak",
                                    ),
                                    RoundedButtonDialog(
                                      onPressed: () async{
                                        await _logout();
                                      },
                                      title: "Ya",
                                      backgroundColor: kLight,
                                      textColor: kDark,
                                    )
                                  ]
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
              );
            })
          );
        }
      }
    );
  }
}
