import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/approve_permit_controller.dart';
import 'package:permit_app/helpers/helper.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/approve_permit/approve_permit_screen.dart';
import 'package:permit_app/views/screens/ditolak/ditolak.dart';

class CardApprove extends StatelessWidget {
  CardApprove({super.key, required this.permitNumber, required this.status, required this.workCategory, required this.date, required this.time, required this.projectName, required this.location, required this.workers, required this.name, required this.role, required this.permitId, required this.userId});
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
  final ApprovePermitController approvePermitController = Get.put(ApprovePermitController());



  Future<void> _confirm(String role, int permitId, String value, String message) async {
    int statusCode = await approvePermitController.confirmPermit(role, permitId, value, message, userId);

    if(statusCode == 200) {
      Get.back();
      Get.snackbar('Success', 'Permit berhasil $value !', backgroundColor: kSuccess, colorText: kLight);
    } else {
      Get.snackbar('Failed', 'Permit gagal dikonfirmasi !', backgroundColor: kDanger, colorText: kLight);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              permitNumber,
              style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.bold
              ),
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
                    RoundedButtonSmall(
                        text: 'Tolak',
                        color: kDanger,
                        press: (){
                          Get.defaultDialog(
                              title: "Konfirmasi",
                              middleText: 'Apakah anda yakin untuk menolak permit ini?',
                              actions: [
                                RoundedButtonDialog(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  title: "Tidak",
                                ),
                                RoundedButtonDialog(
                                  onPressed: () {
                                    Get.to(() => DitolakScreen(permit_id: permitId,));
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
                        text: 'Setuju',
                        color: kSuccess,
                        press: (){
                          Get.defaultDialog(
                              title: "Konfirmasi",
                              middleText: 'Apakah anda yakin untuk menyetujui permit ini?',
                              actions: [
                                RoundedButtonDialog(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  title: "Tidak",
                                ),
                                RoundedButtonDialog(
                                  onPressed: () async{
                                    await _confirm(role, permitId, 'Setuju', '');
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
