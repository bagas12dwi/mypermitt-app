import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/housekeeping_controller.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/history/history_screen.dart';
import 'package:permit_app/views/screens/housekeeping/components/card_housekeeping.dart';

class HousekeepingScreen extends StatelessWidget {
  HousekeepingScreen({super.key, required this.permitId});
  final int permitId;
  final HousekeepingController housekeepingController = Get.put(HousekeepingController());

  Future<void> _storeHousekeeping() async{
    final requestData = {
      'permit_id': permitId,
      'housekeeping': housekeepingController.housekeeping.value
    };
    housekeepingController.storeHousekeeping(requestData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLight,
      appBar: AppBar(
        backgroundColor: kLight,
        title: const Text('Housekeeping'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Obx(() {
          final housekeeping = housekeepingController.housekeeping.value;
          return Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: housekeeping.map((item) {
                        return CardHousekeeping(title: item['pertanyaan'], value: item['value']);
                      }
                      ).toList(),
                    ),
                  )
              ),
              RoundedButton(
                  text: 'Simpan',
                  press: () async{
                    await _storeHousekeeping();
                    Get.offAll(() => HistoryScreen());
                  }
              )
            ],
          );
        }),
      ),
    );
  }
}
