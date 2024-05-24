import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/approve_permit_controller.dart';
import 'package:permit_app/models/control_model.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/approve_permit/approve_permit_screen.dart';
import 'package:permit_app/views/screens/detail_permit/components/card_data_informasi.dart';
import 'package:permit_app/views/screens/detail_permit/detail_permit.dart';

class KontrolView extends StatelessWidget {
  KontrolView({super.key, required this.controlModel, required this.kontrolPengendalian, required this.onNextPressed, required this.onBackPressed, required this.fromScreen});
  final List<ControlModel> controlModel;
  final String kontrolPengendalian;
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  final String fromScreen;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kontrol Pengendalian',
            style: TextStyle(
                fontSize: 16.h,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10.h,),
          CardDataInformasi(title: 'Kontrol Pengendalian :', value: kontrolPengendalian),
          SizedBox(height: 10.h,),
          Text(
            'Alat pelindung diri yang digunakan :',
            style: TextStyle(
                fontSize: 16.h,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10.h,),
          Expanded(
            child: ListView.builder(
              itemCount: controlModel.length,
              itemBuilder: (context, index) {
                final kontrol = controlModel[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.h,
                    vertical: 20.h,
                  ),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Text(kontrol.pertanyaan),
                      ),
                      Expanded(
                        flex: 1,
                        child: kontrol.value == 1
                            ? const Icon(Icons.check_circle)
                            : const Icon(Icons.circle_outlined),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          fromScreen != 'History'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedButtonTwo(
                        text: "Back",
                        color: kGrey,
                        press: onBackPressed
                    ),
                    RoundedButtonTwo(
                        text: "Confirm",
                        press: onNextPressed
                    ),
                  ])
              : Center(child: RoundedButton(text: "Back", press: onBackPressed))
        ],
      ),
    );
  }
}
