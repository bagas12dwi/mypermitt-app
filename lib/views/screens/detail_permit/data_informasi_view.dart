import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/detail_permit/components/card_data_informasi.dart';

class DataInformasiView extends StatelessWidget {
  const DataInformasiView({super.key, required this.projectName, required this.tanggal, required this.time, required this.organik, required this.jumlahPekerja, required this.deskripsi, required this.lokasi, required this.onNextPressed, required this.onBackPressed, required this.workCategory, required this.toolsUsed, required this.liftingDistance});
  final String projectName;
  final String tanggal;
  final String time;
  final String organik;
  final String jumlahPekerja;
  final String deskripsi;
  final String lokasi;
  final String workCategory;
  final String toolsUsed;
  final String liftingDistance;
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;

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
              'Data Informasi',
              style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10.h,),
            CardDataInformasi(
                title: 'Project Name :',
                value: projectName
            ),
            SizedBox(height: 10.h,),
            CardDataInformasi(
                title: 'Tanggal :',
                value: tanggal
            ),
            SizedBox(height: 10.h,),
            CardDataInformasi(
                title: 'Jam Mulai :',
                value: time
            ),
            SizedBox(height: 10.h,),
            workCategory == 'Lifting and Rigging'
                ? Column(
                  children: [
                    CardDataInformasi(
                      title: 'Alat yang digunakan :',
                      value: toolsUsed
                    ),
                    SizedBox(height: 10.h,),
                    CardDataInformasi(
                        title: 'Jarak Pengangkatan :',
                        value: liftingDistance
                    ),
                  ],
                )
                : Column(
                    children: [
                      CardDataInformasi(
                          title: 'Organik/Subkon:',
                          value: organik
                      ),
                      SizedBox(height: 10.h,),
                      CardDataInformasi(
                          title: 'Jumlah Pekerja :',
                          value: jumlahPekerja
                      ),
                      SizedBox(height: 10.h,),
                      CardDataInformasi(
                          title: 'Deskripsi Pekerjaan :',
                          value: deskripsi
                      ),
                      SizedBox(height: 10.h,),
                      CardDataInformasi(
                          title: 'Lokasi :',
                          value: lokasi
                      ),
                    ]),

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
