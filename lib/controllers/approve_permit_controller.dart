import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/helpers/api.dart';
import 'package:permit_app/models/request_permit_model.dart';

class ApprovePermitController extends GetxController {
  final UserController userController = Get.put(UserController());
  Dio dio = Dio();
  RxList<RequestPermit> permitList = RxList<RequestPermit>([]);


  @override
  void onInit() {
    super.onInit();
    getPermit(userController.user.value!.role!);
  }

  Future<void> getPermit(String role) async {
    try {
      var response = await dio.post(
          '${Api.baseUrl}/getApprovePermit',
          data: {
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

  Future<int> confirmPermit(String role, int permitId, String value, String message, int userId) async{
    int statusCode;
    try {
      var response = await dio.post(
          '${Api.baseUrl}/confirmPermit',
          data: {
            'role': role,
            'user_id': userId,
            'permit_id': permitId,
            'value': value,
            'message': message
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