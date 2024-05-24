import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/request_permit_controller.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/persiapan_pekerjaan/persiapan_pekerjaan.dart';
import 'package:permit_app/views/screens/request_permit/components/card_request_permit.dart';

class RequestPermitScreen extends StatelessWidget {
  RequestPermitScreen({super.key});
  final CheckboxController checkboxController = Get.put(CheckboxController());
  final RequestPermitController requestPermitController = Get.put(RequestPermitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50.h),
                        bottomRight: Radius.circular(50.h)
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.all(14.h),
                  child: Text(
                    "Kategori Pekerjaan",
                    style: TextStyle(
                        fontSize: 20.h,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CardRequestPermit(
                      title: 'Hotwork',
                      imgAsset: 'assets/hotwork.png',
                      controller: CheckboxController(),
                      checkboxIndex: 0
                    ),
                    CardRequestPermit(
                      title: 'Confined Space',
                      imgAsset: 'assets/confinedspace.png',
                      controller: CheckboxController(),
                      checkboxIndex: 1
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CardRequestPermit(
                      title: 'Working at Height',
                      imgAsset: 'assets/height.png',
                      controller: CheckboxController(),
                      checkboxIndex: 2
                    ),
                    CardRequestPermit(
                      title: 'Lifting and Rigging',
                      imgAsset: 'assets/lifting.png',
                      controller: CheckboxController(),
                      checkboxIndex: 3
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Center(
                  child: RoundedButton(
                      textColor: kDark,
                      text: "NEXT",
                      press: (){
                        String title = checkboxController.titleValue.value;
                        requestPermitController.getPersiapan(title);
                        if(requestPermitController.is_empty.value) {
                          Get.snackbar('Gagal', 'Data yang anda pilih tidak ada!', backgroundColor: kDanger, colorText: kWhite);
                          requestPermitController.is_empty.value = false;
                        } else {
                          Get.to(() => PersiapanPekerjaanScreen(title: title));
                          requestPermitController.is_empty.value = false;
                        }
                      })
              )
            ],
          ),
        ),
      ),
    );
  }
}
