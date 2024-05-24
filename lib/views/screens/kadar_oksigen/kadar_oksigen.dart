import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/request_permit_controller.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/const/components/rounded_input_field.dart';
import 'package:permit_app/views/screens/identifikasi_bahaya/identifikasi_bahaya.dart';

class KadarOksigenScreen extends StatelessWidget {
  KadarOksigenScreen({super.key, required this.title});
  final String title;
  final RequestPermitController requestPermitController = Get.put(RequestPermitController());
  final TextEditingController oksigenController = TextEditingController();
  final TextEditingController karbonController = TextEditingController();
  final TextEditingController hidrogenController = TextEditingController();
  final TextEditingController lelController = TextEditingController();

  void _updateData() {
    final Map<String, dynamic> updatedData = {
      'gas_measurements': true,
      'oksigen': oksigenController.text,
      'karbon_dioksida': karbonController.text,
      'hidrogen_sulfida': hidrogenController.text,
      'lel': lelController.text,
      'aman_masuk': requestPermitController.amanMasuk.value,
      'aman_hotwork': requestPermitController.amanHotwork.value
    };
    requestPermitController.updatePermitt(updatedData);
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                        "Hasil Pengukuran Kadar Gas",
                        style: TextStyle(
                          fontSize: 16.h,
                          fontWeight: FontWeight.bold
                        ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Text(
                    'O2 : ',
                    style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  RoundedInputField(hintText: 'O2', controller: oksigenController,),
                  SizedBox(height: 10.h,),
                  Text(
                    'CO : ',
                    style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  RoundedInputField(hintText: 'CO', controller: karbonController,),
                  SizedBox(height: 10.h,),
                  Text(
                    'H2S : ',
                    style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  RoundedInputField(hintText: 'H2S', controller: hidrogenController,),
                  SizedBox(height: 10.h,),
                  Text(
                    'LEL : ',
                    style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  RoundedInputField(hintText: 'LEL', controller: lelController,),
                  SizedBox(height: 10.h,),
                  Obx(() => CheckboxListTile(
                      title: const Text('Aman Masuk'),
                      value: requestPermitController.amanMasuk.value,
                      onChanged: (value){
                        requestPermitController.amanMasuk.value = value!;
                      }
                  )),
                  Obx(() => CheckboxListTile(
                      title: const Text('Aman Hotwork'),
                      value: requestPermitController.amanHotwork.value,
                      onChanged: (value){
                        requestPermitController.amanHotwork.value = value!;
                      }
                  )),
                  SizedBox(height: 10.h,),
                  Center(
                    child: RoundedButton(
                        text: "NEXT",
                        press: () {
                          if(oksigenController.text == '' && karbonController.text == '' && hidrogenController.text == '' && lelController.text == ''){
                            Get.snackbar('Failed', 'Data tidak lengkap', backgroundColor: kDanger, colorText: kLight);
                          } else {
                            _updateData();
                            Get.to(() => IdentifikasiBahayaScreen(title: title));
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
