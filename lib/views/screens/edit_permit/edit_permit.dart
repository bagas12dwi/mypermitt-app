import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/request_permit_controller.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/screens/edit_permit/edit_work_preparation.dart';

class EditPermitScreen extends StatelessWidget {
  EditPermitScreen({super.key, required this.permitId});
  final RequestPermitController requestPermitController = Get.put(RequestPermitController());
  final int permitId;
  final PageController pageController = PageController();



  @override
  Widget build(BuildContext context) {
    requestPermitController.getDetailPermit(permitId);
    return Scaffold(
      backgroundColor: kLight,
      appBar: AppBar(
        backgroundColor: kLight,
        title: const Text('Edit Permit'),
      ),
      body: SafeArea(
        child: Obx(() {
          final workPreparations =
              requestPermitController.permitDetail.value.workPreparation;
          final permitDetail = requestPermitController.permitDetail.value;
          if (permitDetail.id == 0) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('./assets/notfound.png'),
                      ),
                    ),
                  ),
                  Text(
                    "Belum Ada Data Permit !",
                    style: TextStyle(
                      fontSize: 20.h,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              controller: pageController,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0 :
                    return Container();
                  case 1 :
                    return Container();
                  case 2 :
                    return Container();
                  case 3:
                    return Container();
                  case 4 :
                    return Container();
                }
              },
            );
          }
        }),
      ),
    );
  }
}
