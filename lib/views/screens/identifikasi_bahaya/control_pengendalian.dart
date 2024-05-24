import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/request_permit_controller.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/const/components/rounded_input_field.dart';
import 'package:permit_app/views/screens/home/home_screen.dart';
import 'package:permit_app/views/screens/identifikasi_bahaya/components/card_bahaya.dart';

class ControlPengendalianScreen extends StatelessWidget {
  ControlPengendalianScreen({super.key, required this.title});
  final String title;
  final RequestPermitController requestPermitController = Get.put(RequestPermitController());
  final UserController userController = Get.put(UserController());
  final TextEditingController pengendalianController = TextEditingController();

  Future<void> _storeData() async{
    final permittData = requestPermitController.permitt.value;
    final requestData = {
      'user_id': permittData['user_id'] as int,
      'permitt_number': permittData['permitt_number'],
      'work_category': permittData['work_category'],
      'project_name': permittData['project_name'],
      'date': permittData['date'],
      'time': permittData['time'],
      'type_of_work': permittData['type_of_work'],
      'kontrol_pengendalian': permittData['kontrol_pengendalian'],
      'organic': permittData['organic'],
      'workers': permittData['workers'],
      'description': permittData['description'],
      'location': permittData['location'],
      'tools_used': permittData['tools_used'],
      'lifting_distance': permittData['lifting_distance'],
      'gas_measurements': permittData['gas_measurements'],
      'oksigen': permittData['oksigen'],
      'karbon_dioksida': permittData['karbon_dioksida'],
      'hidrogen_sulfida': permittData['hidrogen_sulfida'],
      'lel': permittData['lel'],
      'aman_masuk': permittData['aman_masuk'],
      'aman_hotwork': permittData['aman_hotwork'],
      'working': requestPermitController.kategoriPekerjaan.value,
      'bahaya': requestPermitController.bahaya.value,
      'kontrol': requestPermitController.kontrol.value
    };
    await requestPermitController.storePermitt(requestData);
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Obx(() {
          final kontrolList = requestPermitController.kontrol.value;
          RxBool isLoading = false.obs;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  Text(
                    'Step 2 : Identifikasi Bahaya Pekerjaan dan Kontrol Pengendalian ',
                    style: TextStyle(
                        fontSize: 12.h,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Text(
                'Kontrol Pengendalian',
                style: TextStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.bold
                ),
              ),
              RoundedInputTextArea(hintText: 'Enter your text here ...', maxLines: 3, controller: pengendalianController,),
              SizedBox(height: 10.h,),
              Text(
                'Alat Pelindung Diri yang Digunakan',
                style: TextStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.bold
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: kontrolList.map((item) {
                      return CardBahaya(
                          title: item['pertanyaan'],
                          value: item['value'],
                          screen: 'kontrol',
                      );
                    }).toList(),
                  ),
                ),
              ),
              Center(
                  child: Obx(() => RoundedButton(
                      textColor: kDark,
                      text: isLoading.value ? 'Sedang Diproses ...' : "REQUEST PERMIT",
                      press: () async {
                        if (!isLoading.value) {
                          isLoading.value = true;
                          if (pengendalianController.text.isEmpty) {
                            Get.snackbar('Failed', 'Data tidak lengkap', backgroundColor: kDanger, colorText: kLight);
                            isLoading.value = false; // Reset isLoading if data is incomplete
                          } else {
                            final Map<String, dynamic> updatedData = {
                              'kontrol_pengendalian': pengendalianController.text
                            };
                            try {
                              await requestPermitController.updatePermitt(updatedData);
                              await _storeData();
                              Get.offAll(() => HomeScreen(userId: userController.user.value!.id!,));
                            } finally {
                              isLoading.value = false; // Reset isLoading after request completion
                            }
                          }
                        }
                      }
                  ))
              )
            ],
          );
        }),
      ),
    );
  }
}
