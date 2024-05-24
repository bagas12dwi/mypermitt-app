import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/open_permit_controller.dart';
import 'package:permit_app/helpers/helper.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/ditolak/ditolak.dart';

class CardOpenPermit extends StatelessWidget {
  CardOpenPermit({super.key, required this.permitNumber, required this.status, required this.workCategory, required this.date, required this.time, required this.projectName, required this.location, required this.workers, required this.name, required this.role, required this.permitId, required this.userId});

  final String permitNumber;
  final String status;
  final String workCategory;
  final String date;
  final String time;
  final String projectName;
  final String location;
  final int workers;
  final String name;
  final String role;
  final int permitId;
  final int userId;
  final OpenPermitController openPermitController = Get.put(OpenPermitController());

  Future<void> _openPermit(String value) async{
    int statusCode = await openPermitController.openPermit(role, permitId, value, userId);

    if(statusCode == 200) {
      Get.back();
      Get.snackbar('Success', 'Permit berhasil di $value !', backgroundColor: kSuccess, colorText: kLight);
    } else {
      Get.snackbar('Failed', 'Permit gagal di $value !', backgroundColor: kDanger, colorText: kLight);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color status_color;

    if(status == 'Open') {
      status_color = kTeal;
    } else if(status == 'Extends') {
      status_color = kInfo;
    } else if(status == 'Close') {
      status_color = kDanger;
    } else{
      status_color = kGrey;
    }
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kGrey,
              blurRadius: 5.h,
              spreadRadius: 1.h,
            )
          ],
          color: kWhite,
          borderRadius: BorderRadius.circular(20.h)
      ),
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  permitNumber,
                  style: TextStyle(
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.h),
                      color: status_color
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical:3.h, horizontal: 10.h),
                    child: Text(
                      status,
                      style: const TextStyle(
                          color: kLight
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(workCategory),
                    Text('${Helper.convertToDate(date)} $time')
                  ],
                ),
                Text(projectName),
                Row(
                  children: [
                    const Icon(
                        Icons.location_on
                    ),
                    SizedBox(width: 2.w,),
                    Text(location),
                  ],
                ),
                Text('Jumlah Pekerja : $workers'),
                Text(
                  'Oleh : $name',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    status == 'Close'
                    ? RoundedButtonSmall(
                        color: kTeal,
                        text: 'Open',
                        press: () {
                          Get.defaultDialog(
                              title: "Konfirmasi",
                              middleText: 'Apakah anda yakin untuk Open permit ini?',
                              actions: [
                                RoundedButtonDialog(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  title: "Tidak",
                                ),
                                RoundedButtonDialog(
                                  onPressed: () async{
                                    await _openPermit('Open');
                                  },
                                  title: "Ya",
                                  backgroundColor: kLight,
                                  textColor: kDark,
                                )
                              ]
                          );
                        }
                      )
                    : RoundedButtonSmall(
                        text: 'Close',
                        color: kDanger,
                        press: (){
                          Get.defaultDialog(
                              title: "Konfirmasi",
                              middleText: 'Apakah anda yakin untuk Close permit ini?',
                              actions: [
                                RoundedButtonDialog(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  title: "Tidak",
                                ),
                                RoundedButtonDialog(
                                  onPressed: () async{
                                    await _openPermit('Close');
                                  },
                                  title: "Ya",
                                  backgroundColor: kLight,
                                  textColor: kDark,
                                )
                              ]
                          );
                        }
                    ),
                    SizedBox(width: 5.w,),
                    RoundedButtonSmall(
                        text: 'Extends',
                        color: kInfo,
                        press: (){
                          Get.defaultDialog(
                              title: "Konfirmasi",
                              middleText: 'Apakah anda yakin untuk Extends permit ini?',
                              actions: [
                                RoundedButtonDialog(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  title: "Tidak",
                                ),
                                RoundedButtonDialog(
                                  onPressed: () async{
                                    await _openPermit('Extends');
                                  },
                                  title: "Ya",
                                  backgroundColor: kLight,
                                  textColor: kDark,
                                )
                              ]
                          );
                        }
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
