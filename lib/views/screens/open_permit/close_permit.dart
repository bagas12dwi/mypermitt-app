import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/open_permit_controller.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';


class ClosePermitScreen extends StatelessWidget {
  ClosePermitScreen({super.key, required this.role, required this.permitId, required this.userId});
  final String role;
  final int permitId;
  final int userId;
  final OpenPermitController openPermitController = Get.put(OpenPermitController());

  Future<void> _openPermit(String value) async{
    int statusCode = await openPermitController.openPermit(role, permitId, value, userId, workDone: workDone.value, needPermit: needPermit.value);

    if(statusCode == 200) {
      Get.back();
      Get.snackbar('Success', 'Permit berhasil di $value !', backgroundColor: kSuccess, colorText: kLight);
    } else {
      Get.snackbar('Failed', 'Permit gagal di $value !', backgroundColor: kDanger, colorText: kLight);
    }
  }

  var workDone = false.obs;
  var needPermit = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLight,
      appBar: AppBar(
        backgroundColor: kLight,
        title: const Text('Close Permit'),
      ),
      body: Column(
        children: [
          Obx(() => CheckboxListTile(
              title: const Text('Pekerjaan Selesai'),
              value: workDone.value,
              onChanged: (value){
                workDone.value = value!;
              }
          )),
          Obx(() => CheckboxListTile(
              title: const Text('Butuh Permit Baru'),
              value: needPermit.value,
              onChanged: (value){
                needPermit.value = value!;
              }
          )),
          const Spacer(),
          RoundedButton(
              text: "SIMPAN",
              press: () async{
                await _openPermit('Close');
              }
          )
        ],
      ),
    );
  }
}
