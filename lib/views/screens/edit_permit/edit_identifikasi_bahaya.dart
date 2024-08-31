import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/edit_permit_controller.dart';
import 'package:permit_app/models/hazard_model.dart';
import 'package:permit_app/models/request_permit_model.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/const/components/rounded_input_field.dart';
import 'package:permit_app/views/screens/edit_permit/components/card_bahaya.dart';
import 'package:permit_app/views/screens/edit_permit/edit_kontrol_pengendalian.dart';
import 'package:permit_app/views/screens/identifikasi_bahaya/control_pengendalian.dart';

class EditIdentifikasiBahayaScreen extends StatelessWidget {
  EditIdentifikasiBahayaScreen({super.key, required this.title, required this.hazardModel, required this.permit})
  : jenisPekerjaanController = TextEditingController(text: permit.typeOfWork);
  final String title;
  final RequestPermit permit;
  final EditPermitController editPermitController = Get.put(EditPermitController());
  final TextEditingController jenisPekerjaanController;
  final List<HazardModel> hazardModel;

  @override
  Widget build(BuildContext context) {
    editPermitController.initializeBahayaModel(hazardModel);
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
                'Detail Proses Pekerjaan',
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
                    children: editPermitController.hazardModel.map((item) {
                      RxBool newValue = false.obs;
                      if(item.value == 1){
                        newValue = true.obs;
                      } else {
                        newValue = false.obs;
                      }
                      return CardBahaya(
                        title: item.pertanyaan,
                        value: newValue.value,
                        screen: 'bahaya',
                        textController: editPermitController.lainnyaController,
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
                          editPermitController.updatePermitt(updatedData);
                          Get.to(() => EditKontrolPengendalian(title: title, kontrolModel: permit.control, permit: permit,));
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
