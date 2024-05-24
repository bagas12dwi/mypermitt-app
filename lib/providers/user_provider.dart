import 'package:dio/dio.dart';
import 'package:permit_app/helpers/api.dart';
import 'package:permit_app/models/user_model.dart';

class UserProvider {
  Future<User> getDetailUser(int id) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
        '${Api.baseUrl}/getDetail',
        data: {'id': id},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData != null) {
          return User.fromJson(responseData['data']);
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Request failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}