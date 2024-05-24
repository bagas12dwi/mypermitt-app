import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/approve_permit_controller.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/screens/approve_permit/components/card_approve.dart';
import 'package:permit_app/views/screens/detail_permit/detail_permit.dart';
import 'package:permit_app/views/screens/home/home_screen.dart';

class ApprovePermitScreen extends StatelessWidget {
  ApprovePermitScreen({super.key});
  final ApprovePermitController approvePermitController = Get.put(ApprovePermitController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLight,
      appBar: AppBar(
        title: const Text('Approve Permit'),
        backgroundColor: kLight,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.off(() => HomeScreen(userId: userController.user.value!.id!));
          },
        ),
      ),
      body: Obx(() {
        final permitList = approvePermitController.permitList;
        if(permitList.isEmpty) {
          return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150.h,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('./assets/notfound.png')
                        )
                    ),
                  ),
                  Text(
                    "Belum ada data permit !",
                    style: TextStyle(
                        fontSize: 20.h
                    ),
                  ),
                ],
              )
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async{
              await approvePermitController.getPermit(userController.user.value!.role!);
            } ,
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: ListView.builder(
                  itemCount: permitList.length,
                  itemBuilder: (context, index) {
                    final permit = permitList[index];
                    return GestureDetector(
                      onTap: () => Get.to(() => DetailPermitScreen(permit_id: permit.id, fromScreen: 'Approve',)),
                      child: CardApprove(
                          permitNumber: permit.permittNumber,
                          status: permit.status,
                          workCategory: permit.workCategory,
                          date: permit.date,
                          time: permit.time,
                          projectName: permit.projectName,
                          location: permit.location,
                          workers: permit.workers,
                          name: permit.user.name,
                          role: userController.user.value!.role!,
                          permitId: permit.id,
                          userId: userController.user.value!.id!,
                      ),
                    );
                  }
              ),
            ),
          );
        }
      }),
    );
  }
}
