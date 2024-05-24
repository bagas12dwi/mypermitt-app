import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/approve_permit_controller.dart';
import 'package:permit_app/controllers/open_permit_controller.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/screens/detail_permit/detail_permit.dart';
import 'package:permit_app/views/screens/home/home_screen.dart';
import 'package:permit_app/views/screens/open_permit/components/card_open_permit.dart';

class OpenPermitScreen extends StatelessWidget {
  OpenPermitScreen({super.key});
  final OpenPermitController openPermitController = Get.put(OpenPermitController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLight,
      appBar: AppBar(
        backgroundColor: kLight,
        title: const Text('Open Permit'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.off(() => HomeScreen(userId: userController.user.value!.id!));
          },
        ),
      ),
      body: Obx(() {
        final permitList = openPermitController.permitList;
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
              await openPermitController.getOpenPermit(userController.user.value!.id!, userController.user.value!.role!);
            } ,
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: ListView.builder(
                  itemCount: permitList.length,
                  itemBuilder: (context, index) {
                    final permit = permitList[index];
                    return GestureDetector(
                      onTap: () => Get.to(() => DetailPermitScreen(permit_id: permit.id, fromScreen: 'Open',)),
                      child: CardOpenPermit(
                        permitNumber: permit.permittNumber,
                        status: permit.statusPermit,
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
