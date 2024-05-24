import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/helpers/api.dart';
import 'package:permit_app/helpers/helper.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/housekeeping/housekeeping.dart';
import 'package:path/path.dart' as path;

class CardHistory extends StatelessWidget {
  CardHistory({super.key, required this.permitNumber, required this.status, required this.workCategory, required this.date, required this.time, required this.projectName, required this.location, required this.workers, required this.message, required this.user_name, required this.status_permit, required this.document_path, required this.permitid, required this.docDay});
  final String permitNumber;
  final String status;
  final String status_permit;
  final String workCategory;
  final String date;
  final String time;
  final String projectName;
  final String location;
  final String message;
  final String user_name;
  final String document_path;
  final int permitid;
  final int workers;
  final int docDay;
  final UserController userController = Get.put(UserController());

  Future<bool> _requestPermission(Permission permission) async {
    // await Permission.manageExternalStorage.request();

    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  Future<void> _downloadFile(String url, String fileName) async {
    try {
      // Open file picker to select download directory
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory == null) {
        // User canceled the picker
        Get.snackbar('Cancelled', 'Folder selection was cancelled.', backgroundColor: kDanger, colorText: kLight);
        return;
      }

      // Ensure the directory exists
      Directory directory = Directory(selectedDirectory);
      // Directory directory = await getTemporaryDirectory();


      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      File saveFile = File(path.join(directory.path, fileName));
      print(directory.path);

      // Download the file
      Dio dio = Dio();
      await dio.download(url, saveFile.path);

      Get.snackbar('Success', 'Berhasil Download Dokumen silahkan cek folder download!', backgroundColor: kSuccess, colorText: kLight);
    } catch (e) {
      print(e);
      Get.snackbar('Failed', 'Gagal download dokumen! $e', backgroundColor: kDanger, colorText: kLight);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color status_color;
    Color status_permit_color;

    String permitDateTime = date + ' ' + time;

      DateTime permitDate = DateFormat('yyyy-MM-dd HH:mm').parse(permitDateTime);

      DateTime now = DateTime.now().toUtc().add(const Duration(hours: 7));

      int diff = now.difference(permitDate).inDays;
      int dayDiff = diff + 1;

    if(status == 'Aktif') {
      status_color = kSuccess;
    } else if(status == 'Menunggu') {
      status_color = kWarning;
    } else if(status == 'Ditolak') {
      status_color = kDanger;
    } else{
      status_color = kGrey;
    }

    if(status_permit == 'Open') {
      status_permit_color = kTeal;
    } else if(status_permit == 'Extends') {
      status_permit_color = kInfo;
    } else if(status_permit == 'Close') {
      status_permit_color = kDanger;
    } else{
      status_permit_color = kGrey;
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                    ),
                    SizedBox(height: 5.h,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h),
                          color: status_permit_color
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical:3.h, horizontal: 10.h),
                        child: Text(
                          status_permit,
                          style: const TextStyle(
                              color: kLight
                          ),
                        ),
                      ),
                    )
                  ],
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
                    Text('${Helper.convertToDate(date)} ${time}')
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Jumlah Pekerja : $workers'),
                    status == 'Aktif' && dayDiff <= 7 ? RoundedButtonSmall(
                        text: docDay != dayDiff ? "Isi Housekeeping" : "Download Dokumen",
                        color: docDay != dayDiff ? kWarning : kDark,
                        press: () async {
                          // Request storage permissions
                          if(docDay != dayDiff) {
                            Get.to(() => HousekeepingScreen(permitId: permitid,));
                          } else {
                            if (await _requestPermission(Permission.storage)) {
                              if(await _requestPermission(Permission.manageExternalStorage)){
                                await _downloadFile('${Api.docUrl}/$document_path', "$permitNumber.pdf");
                              } else {
                                // Handle permission denied
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Permission denied'))
                                );
                              }
                              // Download the file
                            } else {
                              // Handle permission denied
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Permission denied'))
                              );
                            }
                          }
                        }
                    ) : Container()
                  ],
                ),
                status == 'Aktif' && dayDiff <= 7
                    ? Text('Sisa Hari Permit $dayDiff dari 7 hari', style: const TextStyle(fontStyle: FontStyle.italic,))
                    : Container(),
                userController.user.value!.role! != 'Supervisi'
                    ?  Text('Oleh : $user_name', style: TextStyle(fontWeight: FontWeight.bold),)
                    : Container(),
                SizedBox(height: 5.h,),
                status != 'Ditolak' ? Container()
                    : Text(
                  'Alasan ditolak : $message',
                  style: const TextStyle(
                    color: kDanger,
                    fontStyle: FontStyle.italic
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
