import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/request_permit_controller.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/helpers/helper.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/const/components/rounded_input_field.dart';
import 'package:permit_app/views/screens/identifikasi_bahaya/identifikasi_bahaya.dart';
import 'package:permit_app/views/screens/kadar_oksigen/kadar_oksigen.dart';

class DataInformasi extends StatelessWidget {
  DataInformasi({super.key, required this.title});
  final String title;
  final UserController userController = Get.put(UserController());
  final DatePickerController datePickerController = Get.put(DatePickerController());
  final RequestPermitController requestPermitController = Get.put(RequestPermitController());
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController organikController = TextEditingController();
  final TextEditingController workersController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController alatController = TextEditingController();
  final TextEditingController jarakController = TextEditingController();

  void _updateData() {
    final Map<String, dynamic> updatedData = {
      'user_id': userController.user.value!.id,
      'permitt_number': Helper.generatePermitNumber(datePickerController.selectedDate.value.toString().split(' ')[0]),
      'work_category': title,
      'project_name': projectNameController.text,
      'date': datePickerController.selectedDate.value.toString().split(' ')[0],
      'time': '${datePickerController.selectedTime.value.hour}:${datePickerController.selectedTime.value.minute}',
      'organic': organikController.text,
      'workers': workersController.text,
      'description': descriptionController.text,
      'location': locationController.text,
      'tools_used': alatController.text,
      'lifting_distance': jarakController.text
    };
    requestPermitController.updatePermitt(updatedData);
  }

  void showSnackbar() {
    Get.snackbar('Failed', 'Data tidak lengkap', backgroundColor: kDanger, colorText: kLight);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLight,
      appBar: AppBar(
        backgroundColor: kLight,
        title: Text(
          title,
          style: TextStyle(
              fontSize: 16.h
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "DATA INFORMASI",
                    style: TextStyle(
                      fontSize: 30.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Text(
                  'Nama Project : ',
                  style: TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5.h,),
                RoundedInputField(hintText: 'Nama Project', controller: projectNameController,),
                SizedBox(height: 10.h,),
                Text(
                  'Tanggal : ',
                  style: TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5.h,),
                DatePicker(),
                SizedBox(height: 10.h,),
                Text(
                  'Jam Dimulai : ',
                  style: TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5.h,),
                TimePicker(),
                SizedBox(height: 10.h,),
                title == "Lifting and Rigging"
                    ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alat yang digunakan : ',
                            style: TextStyle(
                                fontSize: 16.h,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          RoundedInputField(hintText: 'Alat yang digunakan', controller: alatController,),
                          SizedBox(height: 10.h,),
                          Text(
                            'Jarak pengangkatan : ',
                            style: TextStyle(
                                fontSize: 16.h,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          RoundedInputField(hintText: 'Jarak pengangkatan', controller: jarakController,),
                        ],
                      )
                    :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Organik/Subkon : ',
                            style: TextStyle(
                                fontSize: 16.h,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          RoundedInputField(hintText: 'Organik Subkon', controller: organikController,),
                          SizedBox(height: 10.h,),
                          Text(
                            'Jumlah Pekerja : ',
                            style: TextStyle(
                                fontSize: 16.h,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          RoundedInputField(hintText: 'Jumlah Pekerja', keyboardType: TextInputType.number, controller: workersController,),
                          SizedBox(height: 10.h,),
                          Text(
                            'Deskripsi Pekerjaan : ',
                            style: TextStyle(
                                fontSize: 16.h,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          RoundedInputTextArea(hintText: 'Deskripsi Pekerjaan', maxLines: 3, controller: descriptionController,),
                          SizedBox(height: 10.h,),
                          Text(
                            'Lokasi Pekerjaan : ',
                            style: TextStyle(
                                fontSize: 16.h,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          RoundedInputField(hintText: 'Lokasi Pekerjaan', controller: locationController,),
                        ],
                      ),
                SizedBox(height: 10.h,),
                Center(
                  child: RoundedButton(
                      text: "NEXT",
                      press: (){
                        if (projectNameController.text.isEmpty) {
                          showSnackbar();
                        } else if (title == "Lifting and Rigging" && (alatController.text.isEmpty || jarakController.text.isEmpty)) {
                          showSnackbar();
                        } else if ((title != "Lifting and Rigging") && (organikController.text.isEmpty || workersController.text.isEmpty || descriptionController.text.isEmpty || locationController.text.isEmpty)) {
                          showSnackbar();
                        } else {
                          _updateData();
                          Get.defaultDialog(
                              title: 'Attention',
                              middleText: 'Apakah membutuhkan pengukuran kadar gas?',
                              actions: [
                                RoundedButtonDialog(
                                    onPressed: () {
                                      Get.back();
                                      Get.to(() => KadarOksigenScreen(title: title));
                                    },
                                    title: 'Ya'
                                ),
                                RoundedButtonDialog(
                                    onPressed: () {
                                      Get.back();
                                      Get.to(() => IdentifikasiBahayaScreen(title: title));
                                    },
                                    title: 'Tidak'
                                )
                              ]
                          );
                        }
                      }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
