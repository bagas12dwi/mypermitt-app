import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permit_app/helpers/api.dart';
import 'package:permit_app/models/control_model.dart';
import 'package:permit_app/models/hazard_model.dart';
import 'package:permit_app/models/work_preparation_model.dart';

class EditPermitController extends GetxController {
  Rx<List<WorkPreparationModel>> workPreparationModel = Rx<List<WorkPreparationModel>>([]);
  var hazardModel = <HazardModel>[].obs;
  var kontrolModel = <ControlModel>[].obs;
  var lainnyaController = TextEditingController();
  var kontrollainnyaController = TextEditingController();
  var amanMasuk = false.obs;
  var amanHotwork = false.obs;
  Rx<Map<String, dynamic>> permitt = Rx<Map<String, dynamic>>({
    'user_id': null,
    'permitt_number': '',
    'work_category': '',
    'project_name': '',
    'date': '',
    'time': '',
    'type_of_work': '',
    'kontrol_pengendalian': '',
    'organic': '',
    'workers': 0,
    'description': '',
    'location': '',
    'tools_used': '',
    'lifting_distance': '',
    'gas_measurements': false,
    'oksigen': 0,
    'karbon_dioksida': 0,
    'hidrogen_sulfida': 0,
    'lel': 0,
    'aman_masuk': false,
    'aman_hotwork': false,
    'worker_name': ''
  });

  final Dio dio = Dio();


  @override
  void onInit() {
    lainnyaController = TextEditingController();
    lainnyaController.addListener(_updateLainnyaText);
    kontrollainnyaController = TextEditingController();
    kontrollainnyaController.addListener(_updateKontrolLainnyaText);
  }


  @override
  void dispose() {
    lainnyaController.removeListener(_updateLainnyaText);
    lainnyaController.dispose();
    kontrollainnyaController.removeListener(_updateKontrolLainnyaText);
    kontrollainnyaController.dispose();
    super.dispose();
  }

  void initializeWorkPreparationModel(List<WorkPreparationModel> initialData) {
    workPreparationModel.value = initialData;
  }

  void initializeBahayaModel(List<HazardModel> initialData) {
    hazardModel.assignAll(initialData);
  }

  void initializeControlModel(List<ControlModel> initialData) {
    kontrolModel.assignAll(initialData);
  }

  void updatedCheckboxBahaya(String screen, String title, bool newValue) {
    if (screen == 'bahaya') {
      final index = hazardModel.indexWhere((item) => item.pertanyaan == title);

      if (index != -1) {
        hazardModel[index].value = newValue ? 1 : 0;
        if (title.startsWith('Lainnya:') && newValue) {
          hazardModel[index].pertanyaan = 'Lainnya: ${lainnyaController.text}';
        } else if (title.startsWith('Lainnya:') && !newValue) {
          hazardModel[index].pertanyaan = 'Lainnya:';
          lainnyaController.clear();
        }
        hazardModel.refresh(); // Notify GetX to update the UI
      }
    } else if (screen == 'kontrol') {
      final index = kontrolModel.indexWhere((item) => item.pertanyaan == title);

      if (index != -1) {
        kontrolModel[index].value = newValue ? 1 : 0;
        if (title.startsWith('Lainnya:') && newValue) {
          kontrolModel[index].pertanyaan = 'Lainnya: ${kontrollainnyaController.text}';
        } else if (title.startsWith('Lainnya:') && !newValue) {
          kontrolModel[index].pertanyaan = 'Lainnya:';
          kontrollainnyaController.clear();
        }
        kontrolModel.refresh(); // Notify GetX to update the UI
      }
    }
  }

  void _updateLainnyaText() {
    final index = hazardModel.indexWhere((item) => item.pertanyaan.startsWith('Lainnya:'));

    if (index != -1) {
      hazardModel[index].pertanyaan = 'Lainnya: ${lainnyaController.text}';
      hazardModel.refresh();
    }
  }

  void _updateKontrolLainnyaText() {
    final index = kontrolModel.indexWhere((item) => item.pertanyaan.startsWith('Lainnya:'));

    if (index != -1) {
      kontrolModel[index].pertanyaan = 'Lainnya: ${kontrollainnyaController.text}';
      kontrolModel.refresh();
    }
  }

  void updateCheckboxValue(String title, bool newValue) {
    final index = workPreparationModel.value.indexWhere((item) => item.pertanyaan == title);
    if (index != -1) {
      workPreparationModel.value[index].value = newValue ? 1 : 0;
      workPreparationModel.refresh(); // Notify GetX to update the UI
    }
  }

  Future<void> updatePermitt(Map<String, dynamic> newData) async {
    newData.forEach((key, value) {
      if (permitt.value.containsKey(key)) {
        permitt.value[key] = value;
      }
    });
  }

  Future<void> updatePermitDatabase(Map<String, dynamic> data) async {

    try {
      const String apiUrl = '${Api.baseUrl}/updatePermitt';
      var response = await dio.post(apiUrl, data: data);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Permit updated successfully');
        print(response.data);
      } else {
        print(response.data['message']);
      }
    } catch (e) {
      // print(e);
      Get.snackbar('Error', 'Failed to update Permit');
    }
  }
}
