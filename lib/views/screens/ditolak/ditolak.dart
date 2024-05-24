import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/approve_permit_controller.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/const/components/rounded_input_field.dart';
import 'package:permit_app/views/screens/approve_permit/approve_permit_screen.dart';

class DitolakScreen extends StatelessWidget {
  DitolakScreen({super.key, required this.permit_id});
  final TextEditingController pesanController = TextEditingController();
  final ApprovePermitController approvePermitController = Get.put(ApprovePermitController());
  final UserController userController = Get.put(UserController());
  final int permit_id;
  RxBool _isloading = false.obs;

  Future<void> _confirm(String message) async {
    int statusCode = await approvePermitController.confirmPermit(userController.user.value!.role!, permit_id, 'Tolak', message, userController.user.value!.id!);

    if(statusCode == 200) {
      Get.off(() => ApprovePermitScreen());
      Get.snackbar('Success', 'Permit berhasil Ditolak !', backgroundColor: kSuccess, colorText: kLight);
    } else {
      Get.snackbar('Failed', 'Permit gagal dikonfirmasi !', backgroundColor: kDanger, colorText: kLight);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLight,
      appBar: AppBar(
        backgroundColor: kLight,
        title: const Text('Alasan ditolak'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Message : ',
                  style: TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold
                  ),
              ),
              SizedBox(height: 10.h,),
              RoundedInputTextArea(
                  hintText: 'Masukkan pesan ... ',
                  maxLines: 3,
                  controller: pesanController,
              ),
              const Spacer(),
              Obx( () {
                return Center(
                  child: RoundedButton(
                      text: _isloading.value ? 'Loading...' : 'Save',
                      press: _isloading.value ? () {} : () async{
                        if(pesanController.text != '') {
                          _isloading.value = true;
                          await _confirm(pesanController.text);
                          _isloading.value = false;
                        } else {
                          Get.snackbar('Warning', 'Pesan harus di isi !', backgroundColor: kWarning, colorText: kLight);
                        }
                      }
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
