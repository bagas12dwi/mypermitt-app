import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/helpers/api.dart';
import 'package:permit_app/models/history_model.dart';
import 'package:permit_app/models/request_permit_model.dart';

class HistoryController extends GetxController {
  final UserController userController = Get.put(UserController());
  Dio dio = Dio();
  RxList<RequestPermit> permitList = RxList<RequestPermit>([]);
  RxList<HistoryModel> historyList = RxList<HistoryModel>([]);
  RxList<RequestPermit> filteredPermitList = <RequestPermit>[].obs;


  @override
  void onInit() {
    super.onInit();
    getPermittByUser(userController.user.value!.id!, userController.user.value!.role!);
  }

  RxList<RequestPermit> searchResults = <RequestPermit>[].obs;

  // Function to filter permits by work category
  void filterPermitsByWorkCategory(String query) {
    // Clear previous search results
    searchResults.clear();
    // Filter permits based on work category
    searchResults.addAll(
      permitList.where((permit) =>
          permit.workCategory.toLowerCase().contains(query.toLowerCase())),
    );
  }

  Future<void> getPermittByUser(int userId, String role) async {
    try {
      var response = await dio.post(
        '${Api.baseUrl}/getPermittByUser',
        data: {
          'user_id': userId,
          'role': role
        }
      );

    if(response.statusCode == 200){
      Map<String, dynamic> responseData = response.data;
      List<dynamic> data = responseData['data'];
      permitList.value = data.map((json) => RequestPermit.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }

    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<void> getHistory(int permitId) async {
    try {
      var response = await dio.post(
        '${Api.baseUrl}/getHistory',
        data: {
          'permit_id': permitId
        }
      );

      if(response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        List<dynamic> data = responseData['data'];
        historyList.value = data.map((json) => HistoryModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}