import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/edit_permit_controller.dart';
import 'package:permit_app/controllers/request_permit_controller.dart';
import 'package:permit_app/models/request_permit_model.dart';
import 'package:permit_app/models/work_preparation_model.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/data_informasi/data_informasi.dart';
import 'package:permit_app/views/screens/edit_permit/components/card_work_preparation.dart';
import 'package:permit_app/views/screens/edit_permit/edit_data_informasi.dart';

class EditWorkPreparationScreen extends StatelessWidget {
  EditWorkPreparationScreen({super.key, required this.title, required this.workPreparationModel, required this.permit});
  final EditPermitController editPermitController = Get.put(EditPermitController());
  final List<WorkPreparationModel> workPreparationModel;
  final String title;
  final RequestPermit permit;

  @override
  Widget build(BuildContext context) {
    editPermitController.initializeWorkPreparationModel(workPreparationModel);
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
                    children: editPermitController.workPreparationModel.value.map((item) {
                      RxBool newValue = false.obs;
                      if(item.value == 1){
                        newValue = true.obs;
                      } else {
                        newValue = false.obs;
                      }
                      return CardWorkPreparation(
                          title: item.pertanyaan,
                          value: newValue.value
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
                        Get.to(() => EditDataInformasiScreen(title: title, permit: permit,));
                      })
              )
            ],
          );
        }),
      ),
    );
  }
}
