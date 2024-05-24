import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class FileController extends GetxController {
  var filePath = ''.obs;

  Future<void> downloadFile(String url) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        final filePath = '${directory.path}/example.pdf';
        final file = File(filePath);
        await file.writeAsBytes(response.data);
        this.filePath.value = filePath;
        print(filePath);
      } else {
        // Handle the error of not being able to access the directory
        throw Exception("Unable to access the external storage directory");
      }
    } catch (e) {
      // Handle the error
      print('Error downloading file: $e');
    }
  }

  Future<void> openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      filePath.value = result.files.single.path ?? '';
    }
  }
}