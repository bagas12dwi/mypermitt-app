import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/history_controller.dart';
import 'package:permit_app/helpers/helper.dart';
import 'package:permit_app/views/const/color.dart';

class DetailHistorySceen extends StatelessWidget {
  DetailHistorySceen({super.key, required this.permitId, required this.permitNumber, required this.lokasi, required this.workCategory, required this.date, required this.status, required this.status_permit, required this.user_name, required this.jumlah_pekerja});
  final int permitId;
  final String permitNumber;
  final String lokasi;
  final String workCategory;
  final String date;
  final String status;
  final String status_permit;
  final String user_name;
  final String jumlah_pekerja;
  final HistoryController historyController = Get.put(HistoryController());
  final RxBool _isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    historyController.getHistory(permitId);
    return FutureBuilder(
        future: historyController.getHistory(permitId),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Scaffold(
              backgroundColor: kLight,
              body: Center(child: CircularProgressIndicator()),
            );
          } else if(snapshot.hasError){
            return Scaffold(
              backgroundColor: kLight,
              body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 150.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('./assets/notfound.png')
                            )
                        ),
                      ),
                      Text(
                        "Belum ada data permit !",
                        style: TextStyle(
                            fontSize: 20.h
                        ),
                      ),
                    ],
                  )
              ),
            );
          } else {
            Color status_color;
            Color status_permit_color;

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
            return Scaffold(
              backgroundColor: kLight,
              appBar: AppBar(
                backgroundColor: kLight,
                title: const Text('Detail History Permit'),
              ),
              body: Padding(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.h),
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(20.h)
                      ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(workCategory),
                              Text(date)
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                  Icons.location_on
                              ),
                              SizedBox(width: 2.w,),
                              Text(lokasi),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.person),
                              SizedBox(width: 2.w,),
                              Text(user_name),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.person_add_alt_1_sharp),
                              SizedBox(width: 2.h,),
                              Text(jumlah_pekerja)
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'History',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.h
                            ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            _isLoading.value = true;
                            await historyController.getHistory(permitId);
                            _isLoading.value = false;
                          },
                          child: const Icon(
                              Icons.refresh
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Obx(()  {
                      final historyList = historyController.historyList;
                      if(_isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: historyList.length,
                              itemBuilder: (context, index) {
                                final history = historyList[index];
                                return Container(
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    padding: EdgeInsets.all(10.h),
                                    decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(20.h)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          history.action,
                                          style: TextStyle(
                                              fontSize: 14.h,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(height: 5.h,),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 6,
                                                child: Text(history.name)
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: Text(Helper.convertDateToString(history.date))
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                );
                              }
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            );
          }
        }
    );
  }
}
