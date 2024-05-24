import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permit_app/models/hazard_model.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/detail_permit/components/card_data_informasi.dart';

class IdentifikasiView extends StatelessWidget {
  const IdentifikasiView({super.key, required this.hazardModel, required this.onNextPressed, required this.onBackPressed, required this.jenisPekerjaan});
  final List<HazardModel> hazardModel;
  final String jenisPekerjaan;
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Identifikasi Bahaya Pekerjaan',
            style: TextStyle(
                fontSize: 16.h,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10.h,),
          CardDataInformasi(title: 'Jenis Pekerjaan :', value: jenisPekerjaan),
          SizedBox(height: 10.h,),
          Text(
            'Bahaya :',
            style: TextStyle(
                fontSize: 16.h,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10.h,),
          Expanded(
            child: ListView.builder(
              itemCount: hazardModel.length,
              itemBuilder: (context, index) {
                final hazard = hazardModel[index];
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
                        child: Text(hazard.pertanyaan),
                      ),
                      Expanded(
                        flex: 1,
                        child: hazard.value == 1
                            ? const Icon(Icons.check_circle)
                            : const Icon(Icons.circle_outlined),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedButtonTwo(
                  text: "Back",
                  color: kGrey,
                  press: onBackPressed
              ),
              RoundedButtonTwo(
                  text: "Next",
                  press: onNextPressed
              ),
            ],
          )
        ],
      ),
    );
  }
}
