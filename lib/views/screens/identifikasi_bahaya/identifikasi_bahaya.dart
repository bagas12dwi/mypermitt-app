import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/request_permit_controller.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/const/components/rounded_input_field.dart';
import 'package:permit_app/views/screens/identifikasi_bahaya/components/card_bahaya.dart';
import 'package:permit_app/views/screens/identifikasi_bahaya/control_pengendalian.dart';

class IdentifikasiBahayaScreen extends StatelessWidget {
  IdentifikasiBahayaScreen({super.key, required this.title});
  final String title;
  final RequestPermitController requestPermitController = Get.put(RequestPermitController());
  final TextEditingController jenisPekerjaanController = TextEditingController();

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
          final bahayaList = requestPermitController.bahaya.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  Text(
                    'Step 2 : Identifikasi Bahaya Pekerjaan dan Kontrol Pengendaliaan ',
                    style: TextStyle(
                        fontSize: 12.h,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Text(
                'Jenis Pekerjaan',
                style: TextStyle(
                  fontSize: 14.h,
                  fontWeight: FontWeight.bold
                ),
              ),
              RoundedInputTextArea(hintText: 'Enter your text here ...', maxLines: 3, controller:  jenisPekerjaanController,),
              SizedBox(height: 10.h,),
              Text(
                'Bahaya ',
                style: TextStyle(
                  fontSize: 14.h,
                  fontWeight: FontWeight.bold
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: bahayaList.map((item) {
                      return CardBahaya(
                          title: item['pertanyaan'],
                          value: item['value'],
                          screen: 'bahaya',
                      );
                    }).toList(),
                  ),
                ),
              ),
              Center(
                  child: RoundedButton(
                      textColor: kDark,
                      text: "NEXT",
                      press: (){
                        if(jenisPekerjaanController.text == '') {
                          Get.snackbar('Failed', 'Data tidak lengkap', backgroundColor: kDanger, colorText: kLight);
                        } else{
                          final Map<String, dynamic> updatedData = {
                            'type_of_work': jenisPekerjaanController.text,
                          };
                          requestPermitController.updatePermitt(updatedData);
                          Get.to(() => ControlPengendalianScreen(title: title));
                        }
                      }
                  )
              )
            ],
          );
        }),
      ),
    );
  }
}
