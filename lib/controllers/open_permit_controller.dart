import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/helpers/api.dart';
import 'package:permit_app/models/request_permit_model.dart';

class OpenPermitController extends GetxController {
  final UserController userController = Get.put(UserController());
  Dio dio = Dio();
  RxList<RequestPermit> permitList = RxList<RequestPermit>([]);


  @override
  void onInit() {
    super.onInit();
    getOpenPermit(userController.user.value!.id!, userController.user.value!.role!);
  }

  Future<void> getOpenPermit(int userId, String role) async {
    try {
      var response = await dio.post(
          '${Api.baseUrl}/getOpenPermit',
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

  Future<int> openPermit(String role, int permitId, String value, int userId) async{
    int statusCode;
    try {
      var response = await dio.post(
          '${Api.baseUrl}/openPermit',
          data: {
            'role': role,
            'permit_id': permitId,
            'user_id': userId,
            'value': value,
          }
      );

      if(response.statusCode == 200) {
        statusCode = 200;
        return statusCode;
      } else {
        statusCode = 400;
        return statusCode;
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}