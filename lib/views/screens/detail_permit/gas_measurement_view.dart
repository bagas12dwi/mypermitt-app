import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/detail_permit/components/card_data_informasi.dart';

class GasMeasurementView extends StatelessWidget {
  const GasMeasurementView({super.key, required this.oksigen, required this.karbonDioksida, required this.hidrogen, required this.lel, required this.masuk, required this.hotwork, required this.onBackPressed, required this.onNextPressed});
  final double oksigen;
  final double karbonDioksida;
  final double hidrogen;
  final double lel;
  final int masuk;
  final int hotwork;
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hasil Pengukuran Kadar Gas',
              style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10.h,),
            CardDataInformasi(
                title: 'O2 :',
                value: '${oksigen} %'
            ),
            SizedBox(height: 10.h,),
            CardDataInformasi(
                title: 'CO2 :',
                value: '${karbonDioksida} ppm'
            ),
            SizedBox(height: 10.h,),
            CardDataInformasi(
                title: 'H2S :',
                value: '${hidrogen} ppm'
            ),
            SizedBox(height: 10.h,),
            CardDataInformasi(
                title: 'LEL :',
                value: '${lel} %'
            ),
            SizedBox(height: 10.h,),
            Container(
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
                  const Expanded(
                    flex: 9,
                    child: Text("Aman Hotwork"),
                  ),
                  Expanded(
                    flex: 1,
                    child: masuk == 1
                        ? const Icon(Icons.check_circle)
                        : const Icon(Icons.circle_outlined),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            SizedBox(height: 10.h,),
            Container(
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
                  const Expanded(
                    flex: 9,
                    child: Text("Aman Hotwork"),
                  ),
                  Expanded(
                    flex: 1,
                    child: hotwork == 1
                        ? const Icon(Icons.check_circle)
                        : const Icon(Icons.circle_outlined),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h,),
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
      ),
    );
  }
}
