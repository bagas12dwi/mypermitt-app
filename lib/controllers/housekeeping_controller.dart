import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:permit_app/helpers/api.dart';

class HousekeepingController extends GetxController {
  Rx<List> housekeeping = Rx<List>([]);
  Rx<List<Map<String, dynamic>>> housekeepingList = Rx<List<Map<String, dynamic>>> ([
    {
      'pertanyaan': 'Merapikan kabel dan selang gas pada kabel hanger/ ''S'' hook yang tersedia',
      'value': false
    },
    {
      'pertanyaan': 'Mengeluarkan cutting torch dari tangki/kamar mesin',
      'value': false
    },
    {
      'pertanyaan': 'Mematikan travo, blower, panel dan peralatan listrik lainnya',
      'value': false
    },
    {
      'pertanyaan': 'Mencabut selang gas pada manifold dan mematikan kran pada manifold',
      'value': false
    },
    {
      'pertanyaan': 'Membersikan sampah yang berpotensi terjadinya kebakaran',
      'value': false
    },
  ]);
  Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    housekeeping = housekeepingList;
  }

  void updateCheckboxValue(String title, bool newValue) {
    final List<Map<String, dynamic>> updatedList = List.from(housekeeping.value);
    final index = updatedList.indexWhere((item) => item['pertanyaan'] == title);

    if (index != -1) {
      housekeeping.value[index]['value'] = newValue;
      housekeeping.value = updatedList;
    }
  }

  Future<void> storeHousekeeping(Map<String, dynamic> data) async{
    try {
      await dio.post('${Api.baseUrl}/storeHousekeeping', data: data);
      Get.snackbar('Success', 'Housekeeping stored successfully and Your Permit success downloaded check folder download!');
    } catch(e) {
      print(e);
      Get.snackbar('Error', 'Failed to store housekeeping');
    }
  }
}