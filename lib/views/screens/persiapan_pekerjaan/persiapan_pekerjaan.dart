import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/request_permit_controller.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/data_informasi/data_informasi.dart';
import 'package:permit_app/views/screens/persiapan_pekerjaan/components/card_persiapan_pekerjaan.dart';

class PersiapanPekerjaanScreen extends StatelessWidget {
  PersiapanPekerjaanScreen({super.key, required this.title});
  final String title;
  final RequestPermitController requestPermitController = Get.put(RequestPermitController());

  @override
  Widget build(BuildContext context) {
    requestPermitController.getPersiapan(title);
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
          final kategoriPekerjaan = requestPermitController.kategoriPekerjaan.value;
          return Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Text(
                    'Step 1 : Persiapan Pekerjaan',
                    style: TextStyle(
                        fontSize: 12.h,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: kategoriPekerjaan.map((item) {
                      return CardPersiapanPekerjaan(
                          title: item['pertanyaan'],
                          value: item['value']
                      );
                    }).toList(),
                  ),
                ),
              ),
              Center(
                  child: RoundedButton(
                      textColor: kDark,
                      text: "NEXT",
                      press: () {
                        Get.to(() => DataInformasi(title: title,));
                      })
              )
            ],
          );
        }),
      ),
    );
  }
}
