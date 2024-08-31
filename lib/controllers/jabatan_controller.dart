
import 'package:get/get.dart';
import 'package:permit_app/models/jabatan.dart';

class JabatanController extends GetxController {
  var selectedItem = Rx<Jabatan?>(null);
  var items = <Jabatan>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Contoh data item
    items.addAll([
      Jabatan(id: 1, name: 'Supervisi'),
      Jabatan(id: 2, name: 'Manager'),
      Jabatan(id: 3, name: 'HSE'),
      Jabatan(id: 3, name: 'Pelaksana Kerja'),
    ]);
  }

  void selectItem(Jabatan? item) {
    selectedItem.value = item;
  }
}