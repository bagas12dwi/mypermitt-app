import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/views/const/color.dart';

class CardRequestPermit extends StatelessWidget {
  const CardRequestPermit({
    super.key,
    required this.title,
    required this.imgAsset,
    required this.checkboxIndex, // Add checkboxIndex parameter
    required this.controller,
  });

  final String title;
  final String imgAsset;
  final int checkboxIndex; // Define checkboxIndex
  final CheckboxController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckboxController>(
      init: controller,
      builder: (controller) {
        final RxString titleValue = controller.titleValue; // Declare titleValue here

        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          width: 150.w,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20.h),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.h,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Container(
                height: 80.h,
                width: 70.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imgAsset),
                  ),
                ),
              ),
              Obx(() => Checkbox(
                value: controller.checkboxList[checkboxIndex].value,
                onChanged: (newValue) {
                  controller.checkboxList[checkboxIndex].value = newValue!;
                  // Update selected titles list based on checkbox status
                  final selectedTitles = controller.checkboxList
                      .asMap()
                      .entries
                      .where((entry) => entry.value.value)
                      .map((entry) => [
                    'Hotwork',
                    'Confined Space',
                    'Working at Height',
                    'Lifting and Rigging'
                  ][entry.key])
                      .toList();
                  // Set titleValue to selected titles joined with comma
                  titleValue.value = selectedTitles.join(' & ');
                },
              )),
            ],
          ),
        );
      },
    );
  }
}



class CheckboxController extends GetxController {
  late List<RxBool> checkboxList; // Change to list
  final RxString titleValue = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkboxList = List.generate(4, (_) => false.obs); // Initialize the list
  }
}
