import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/approve_permit_controller.dart';
import 'package:permit_app/controllers/open_permit_controller.dart';
import 'package:permit_app/controllers/request_permit_controller.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';
import 'package:permit_app/views/screens/approve_permit/approve_permit_screen.dart';
import 'package:permit_app/views/screens/detail_permit/data_informasi_view.dart';
import 'package:permit_app/views/screens/detail_permit/gas_measurement_view.dart';
import 'package:permit_app/views/screens/detail_permit/identifikasi_view.dart';
import 'package:permit_app/views/screens/detail_permit/kontrol_view.dart';
import 'package:permit_app/views/screens/detail_permit/work_preparation_view.dart';
import 'package:permit_app/views/screens/ditolak/ditolak.dart';
import 'package:permit_app/views/screens/home/home_screen.dart';
import 'package:permit_app/views/screens/open_permit/open_permit.dart';

class DetailPermitScreen extends StatelessWidget {
  DetailPermitScreen({super.key, required this.permit_id, required this.fromScreen});
  final RequestPermitController requestPermitController = Get.put(RequestPermitController());
  final ApprovePermitController approvePermitController = Get.put(ApprovePermitController());
  final OpenPermitController openPermitController = Get.put(OpenPermitController());
  final UserController userController = Get.put(UserController());
  final int permit_id;
  final String fromScreen;
  final PageController pageController = PageController();

  final RxBool _isLoading = false.obs;

  Future<void> _confirm() async {
    int statusCode = await approvePermitController.confirmPermit(userController.user.value!.role!, permit_id, 'Setuju', '', userController.user.value!.id!);

    if(statusCode == 200) {
      // Get.off(() => HomeScreen(userId: userController.user.value!.id!));
      Get.off(() => ApprovePermitScreen());
      Get.snackbar('Success', 'Permit berhasil Disetujui !', backgroundColor: kSuccess, colorText: kLight);
    } else {
      Get.snackbar('Failed', 'Permit gagal dikonfirmasi !', backgroundColor: kDanger, colorText: kLight);
    }
  }

  Future<void> _openPermit(String value) async{
    int statusCode = await openPermitController.openPermit(userController.user.value!.role!, permit_id, value, userController.user.value!.id!);

    if(statusCode == 200) {
      // Get.offAll(() => HomeScreen(userId: userController.user.value!.id!));
      Get.off(() => OpenPermitScreen());
      Get.snackbar('Success', 'Permit berhasil di $value !', backgroundColor: kSuccess, colorText: kLight);
    } else {
      Get.off(() => OpenPermitScreen());
      Get.snackbar('Failed', 'Permit gagal di $value !', backgroundColor: kDanger, colorText: kLight);
    }
  }

  @override
  Widget build(BuildContext context) {
    requestPermitController.getDetailPermit(permit_id);
    return Scaffold(
      backgroundColor: kLight,
      appBar: AppBar(
        backgroundColor: kLight,
        title: const Text('Detail Permit'),
      ),
      body: SafeArea(
        child: Obx(() {
          final workPreparations =
              requestPermitController.permitDetail.value.workPreparation;
          final permitDetail = requestPermitController.permitDetail.value;
          if (permitDetail.id == 0) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('./assets/notfound.png'),
                      ),
                    ),
                  ),
                  Text(
                    "Belum ada history permitt !",
                    style: TextStyle(
                      fontSize: 20.h,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              controller: pageController,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0 :
                    return WorkPreparationView(workPreparationModel: workPreparations, onNextPressed: () => pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),);
                  case 1 :
                    return DataInformasiView(
                        projectName: permitDetail.projectName,
                        tanggal: permitDetail.date,
                        time: permitDetail.time,
                        organik: permitDetail.organic,
                        jumlahPekerja: '${permitDetail.workers}',
                        deskripsi: permitDetail.description,
                        lokasi: permitDetail.location,
                        onNextPressed: () => pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
                        onBackPressed: () => pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
                        workCategory: permitDetail.workCategory,
                        toolsUsed: permitDetail.toolsUsed,
                        liftingDistance: permitDetail.liftingDistance,
                    );
                  case 2 :
                    if(permitDetail.gasMeasurements == 1) {
                      return GasMeasurementView(
                        oksigen: permitDetail.oksigen,
                        karbonDioksida: permitDetail.karbonDioksida,
                        hidrogen: permitDetail.hidrogenSulfida,
                        lel: permitDetail.lel,
                        masuk: permitDetail.amanMasuk,
                        hotwork: permitDetail.amanHotwork,
                        onNextPressed: () => pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
                        onBackPressed: () => pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
                      );
                    } else {
                      pageController.jumpToPage(3);
                    }
                  case 3:
                    return IdentifikasiView(
                      hazardModel: permitDetail.hazard,
                      onNextPressed: () => pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
                      onBackPressed: () {
                        if(permitDetail.gasMeasurements == 1) {
                          pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                        } else {
                          pageController.jumpToPage(1);
                        }
                      },
                      jenisPekerjaan: permitDetail.typeOfWork,
                    );
                  case 4 :
                    return KontrolView(
                      controlModel: permitDetail.control,
                      kontrolPengendalian: permitDetail.kontrol_pengendalian,
                      onNextPressed: () {
                        Get.defaultDialog(
                            title: "Konfirmasi",
                            middleText: fromScreen == 'Open' ? permitDetail.statusPermit == 'Open' ? 'Apakah anda yakin Close / Extends permit ini?' : 'Apakah anda yakin Open / Extends permit ini?' : 'Apakah anda yakin menyetujui permit ini?',
                            actions: [
                              RoundedButtonDialog(
                                onPressed: () async{
                                  if(fromScreen == 'Open') {
                                    if(permitDetail.statusPermit == 'Open') {
                                      await _openPermit('Close');
                                    } else {
                                      await _openPermit('Open');
                                    }
                                  } else {
                                    Get.to(() => DitolakScreen(permit_id: permit_id,));
                                  }
                                },
                                backgroundColor: kDanger,
                                title: fromScreen == 'Open' ? permitDetail.statusPermit == 'Open' ? 'Close' : 'Open' : "Tolak",
                              ),
                              RoundedButtonDialog(
                                onPressed:  () async{
                                  if(fromScreen == 'Open') {
                                    await _openPermit('Extends');
                                  } else {
                                    await _confirm();
                                  }
                                },
                                title: fromScreen == 'Open' ? 'Extends'  : "Ya",
                                backgroundColor: kSuccess,
                              )
                            ]
                        );
                      },
                      onBackPressed: () => pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
                      fromScreen: fromScreen,
                    );
                }
              },
            );
          }
        }),
      ),
    );
  }
}
