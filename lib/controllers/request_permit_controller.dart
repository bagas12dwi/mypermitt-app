import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permit_app/helpers/api.dart';
import 'package:permit_app/models/document_model.dart';
import 'package:permit_app/models/request_permit_model.dart';
import 'package:permit_app/models/user_permit_model.dart';
import 'package:permit_app/views/const/color.dart';

class RequestPermitController extends GetxController {
  Rx<List> kategoriPekerjaan = Rx<List>([]);

  Rx<List<Map<String, dynamic>>> hotwork = Rx<List<Map<String, dynamic>>>([
    {
      'pertanyaan': 'Memastikan material mudah terbakar sudah dipindahkan',
      'value': false,
    },
    {
      'pertanyaan': 'Menyiapkan blower',
      'value': false,
    },
    {
      'pertanyaan': 'Menyediakan fire blanket',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan APAR/Hydrant sudah tersedia',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan kabel las/listrik tidak ada kerusakan',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan baricade sudah terpasang',
      'value': false,
    },
    {
      'pertanyaan': 'Menyediakan penerangan (dalam tangki)',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan kadar gas sudah dilakukan pengecekan oleh HSE',
      'value': false,
    },
    {
      'pertanyaan': 'Memeriksa selang gas tidak ada kebocoran',
      'value': false,
    },
    {
      'pertanyaan': 'Memeriksa kebocoran arus menggunakan tespen ',
      'value': false,
    },
    {
      'pertanyaan': 'Standby penjaga api',
      'value': false,
    },
  ]);
  Rx<List<Map<String, dynamic>>> confined = Rx<List<Map<String, dynamic>>>([
    {
      'pertanyaan': 'Menyiapkan blower',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan kabel las/listrik tidak ada kerusakan',
      'value': false,
    },
    {
      'pertanyaan': 'Menyediakan penerangan (dalam tangki) ',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan kadar gas sudah dilakukan pengecekan oleh HSE ',
      'value': false,
    },
    {
      'pertanyaan': 'Memeriksa kebocoran arus menggunakan tespen ',
      'value': false,
    },
  ]);
  Rx<List<Map<String, dynamic>>> confinedWorking = Rx<List<Map<String, dynamic>>>([
    {
      'pertanyaan': 'Menyiapkan blower',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan kabel las/listrik tidak ada kerusakan',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan baricade sudah terpasang',
      'value': false,
    },
    {
      'pertanyaan': 'Menyediakan penerangan (dalam tangki)',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan kadar gas sudah dilakukan pengecekan oleh HSE',
      'value': false,
    },
    {
      'pertanyaan': 'Memeriksa kebocoran arus menggunakan tespen',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan akses naik kerja ketinggian aman',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan tagging scaffolding warna hijau',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan pekerja menggunakan Full Body Harness',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan pagar pengaman diketinggian sudah dipasang',
      'value': false,
    },
  ]);
  Rx<List<Map<String, dynamic>>> working = Rx<List<Map<String, dynamic>>>([
      {
        'pertanyaan': 'Memastikan kabel las/listrik tidak ada kerusakan ',
        'value': false,
      },
      {
        'pertanyaan': 'Memastikan baricade sudah terpasang',
        'value': false,
      },
      {
        'pertanyaan': 'Menyediakan penerangan (dalam tangki) ',
        'value': false,
      },
      {
        'pertanyaan': 'Memeriksa kebocoran arus menggunakan tespen',
        'value': false,
      },
      {
        'pertanyaan': 'Memastikan akses naik kerja ketinggian aman',
        'value': false,
      },
      {
        'pertanyaan': 'Memastikan tagging scaffolding warna hijau',
        'value': false,
      },
      {
        'pertanyaan': 'Memastikan pekerja menggunakan Full Body Harness ',
        'value': false,
      },
      {
        'pertanyaan': 'Memastikan pagar pengaman diketinggian sudah dipasang ',
        'value': false,
      },
    ]);
  Rx<List<Map<String, dynamic>>> hotworkConfined = Rx<List<Map<String, dynamic>>>([
      {
        'pertanyaan': 'Memastikan material mudah terbakar sudah dipindahkan',
        'value': false,
      },
      {
        'pertanyaan': 'Menyiapkan blower',
        'value': false,
      },
      {
        'pertanyaan': 'Menyediakan fire blanket',
        'value': false,
      },
      {
        'pertanyaan': 'Memastikan APAR/Hydrant sudah tersedia',
        'value': false,
      },
      {
        'pertanyaan': 'Memastikan kabel las/listrik tidak ada kerusakan',
        'value': false,
      },
      {
        'pertanyaan': 'Memastikan baricade sudah terpasang',
        'value': false,
      },
      {
        'pertanyaan': 'Menyediakan penerangan (dalam tangki)',
        'value': false,
      },
      {
        'pertanyaan': 'Memastikan kadar gas sudah dilakukan pengecekan oleh HSE',
        'value': false,
      },
      {
        'pertanyaan': 'Memeriksa selang gas tidak ada kebocoran',
        'value': false,
      },
      {
        'pertanyaan': 'Memeriksa kebocoran arus menggunakan tespen ',
        'value': false,
      },
      {
        'pertanyaan': 'Standby penjaga api',
        'value': false,
      },
    ]);
  Rx<List<Map<String, dynamic>>> hotworkConfinedWorking = Rx<List<Map<String, dynamic>>>([
    {
      'pertanyaan': 'Memastikan material mudah terbakar sudah dipindahkan',
      'value': false,
    },
    {
      'pertanyaan': 'Menyiapkan blower',
      'value': false,
    },
    {
      'pertanyaan': 'Menyediakan fire blanket',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan APAR/Hydrant sudah tersedia',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan kabel las/listrik tidak ada kerusakan',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan baricade sudah terpasang',
      'value': false,
    },
    {
      'pertanyaan': 'Menyediakan penerangan (dalam tangki)',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan kadar gas sudah dilakukan pengecekan oleh HSE',
      'value': false,
    },
    {
      'pertanyaan': 'Memeriksa selang gas tidak ada kebocoran',
      'value': false,
    },
    {
      'pertanyaan': 'Memeriksa kebocoran arus menggunakan tespen ',
      'value': false,
    },
    {
      'pertanyaan': 'Standby penjaga api',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan akses naik kerja ketinggian aman',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan tagging scaffolding warna hijau',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan pekerja menggunakan Full Body Harness',
      'value': false,
    },
    {
      'pertanyaan': 'Memastikan pagar pengaman diketinggian sudah dipasang',
      'value': false,
    },
  ]);
  Rx<List<Map<String, dynamic>>> hotworkWorking = Rx<List<Map<String, dynamic>>>([
        {
          'pertanyaan': 'Memastikan material mudah terbakar sudah dipindahkan',
          'value': false,
        },
        {
          'pertanyaan': 'Menyiapkan blower',
          'value': false,
        },
        {
          'pertanyaan': 'Menyediakan fire blanket',
          'value': false,
        },
        {
          'pertanyaan': 'Memastikan APAR/Hydrant sudah tersedia',
          'value': false,
        },
        {
          'pertanyaan': 'Memastikan kabel las/listrik tidak ada kerusakan',
          'value': false,
        },
        {
          'pertanyaan': 'Memastikan baricade sudah terpasang',
          'value': false,
        },
        {
          'pertanyaan': 'Menyediakan penerangan (dalam tangki)',
          'value': false,
        },
        {
          'pertanyaan': 'Memastikan kadar gas sudah dilakukan pengecekan oleh HSE',
          'value': false,
        },
        {
          'pertanyaan': 'Memeriksa selang gas tidak ada kebocoran',
          'value': false,
        },
        {
          'pertanyaan': 'Memeriksa kebocoran arus menggunakan tespen ',
          'value': false,
        },
        {
          'pertanyaan': 'Standby penjaga api',
          'value': false,
        },
        {
          'pertanyaan': 'Memastikan akses naik kerja ketinggian aman ',
          'value': false,
        },
        {
          'pertanyaan': 'Memastikan tagging scaffolding warna hijau',
          'value': false,
        },
        {
          'pertanyaan': 'Memastikan pekerja menggunakan Full Body Harness ',
          'value': false,
        },
        {
          'pertanyaan': 'Memastikan pagar pengaman diketinggian sudah dipasang ',
          'value': false,
        },
      ]);
  Rx<List<Map<String, dynamic>>> lifting = Rx<List<Map<String, dynamic>>>([
              {
                'pertanyaan': 'Material/beban telah di check dan diikat dengan aman sebelum pengangkatan',
                'value': false,
              },
              {
                'pertanyaan': 'Memastikan sekitar lokasi pengangkatan telah di barikade',
                'value': false,
              },
              {
                'pertanyaan': 'Memastikan tali pandu telah disiapkan untuk pengangkatan',
                'value': false,
              },
              {
                'pertanyaan': 'Memastikan lokasi sekitar pengangkatan tidak ada pekerja lain yang berada di bawah beban ',
                'value': false,
              },
              {
                'pertanyaan': 'Memastikan pengangkatan tidak melebihi kapasitas maksimum yang diperbolehkan',
                'value': false,
              },
              {
                'pertanyaan': 'Memastikan pengangkatan dilakukan oleh 2 orang/lebih atau menggunakan alat bantu angkat angkut yang layak ',
                'value': false,
              },
              {
                'pertanyaan': 'Memastikan kecepatan angin tidak melebihi 20 knots saat pengangkatan',
                'value': false,
              },
      ]);
  Rx<List<Map<String, dynamic>>> bahaya = Rx<List<Map<String, dynamic>>>([
    {
      'pertanyaan': 'Jatuh dari ketinggian ',
      'value': false,
    },
    {
      'pertanyaan': 'Kebakaran ',
      'value': false,
    },
    {
      'pertanyaan': 'Ledakan ',
      'value': false,
    },
    {
      'pertanyaan': 'Terjepit ',
      'value': false,
    },
    {
      'pertanyaan': 'Tertabrak alat berat',
      'value': false,
    },
    {
      'pertanyaan': 'Asap/Debu Pengelasan',
      'value': false,
    },
    {
      'pertanyaan': 'Tersetrum',
      'value': false,
    },
    {
      'pertanyaan': 'Tertimpa material',
      'value': false,
    },
    {
      'pertanyaan': 'Sinar las ',
      'value': false,
    },
    {
      'pertanyaan': 'Kebisingan',
      'value': false,
    },
    {
      'pertanyaan': 'Cidera otot',
      'value': false,
    },
    {
      'pertanyaan': 'Kekurangan oksigen',
      'value': false,
    },
    {
      'pertanyaan': 'Lainnya:',
      'value': false,
    },
  ]);
  Rx<List<Map<String, dynamic>>> kontrol = Rx<List<Map<String, dynamic>>>([
    {
      'pertanyaan': 'Helm',
      'value': false,
    },
    {
      'pertanyaan': 'Sepatu Safety',
      'value': false,
    },
    {
      'pertanyaan': 'Sarung Tangan Katun ',
      'value': false,
    },
    {
      'pertanyaan': 'Kap Las',
      'value': false,
    },
    {
      'pertanyaan': 'Earmuff',
      'value': false,
    },
    {
      'pertanyaan': 'Earplug',
      'value': false,
    },
    {
      'pertanyaan': 'Sarung Tangan Latex',
      'value': false,
    },
    {
      'pertanyaan': 'Masker Catridge',
      'value': false,
    },
    {
      'pertanyaan': 'Kacamata',
      'value': false,
    },
    {
      'pertanyaan': 'Sarung Tangan Kulit',
      'value': false,
    },
    {
      'pertanyaan': 'Apron',
      'value': false,
    },
    {
      'pertanyaan': 'Full Body Harness',
      'value': false,
    },
    {
      'pertanyaan': 'Lainnya:',
      'value': false,
    },
  ]);
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
    'aman_hotwork': false
  });

  RxBool is_empty = false.obs;
  var amanMasuk = false.obs;
  var amanHotwork = false.obs;
  final Dio dio = Dio();
  final permitDetail = RequestPermit(
      id: 0,
      userId: 0,
      permittNumber: '',
      workCategory: '',
      projectName: '',
      date: '',
      time: '',
      typeOfWork: '',
      control: [],
      organic: '',
      workers: 0,
      description: '',
      location: '',
      toolsUsed: '',
      liftingDistance: '',
      gasMeasurements: 0,
      oksigen: 0,
      karbonDioksida: 0, hidrogenSulfida: 0, lel: 0, amanMasuk: 0, amanHotwork: 0, isApproveHse: 0, isApproveManager: 0,
      status: '',
      workPreparation: [],
      hazard: [],
      user:  UserPermit(id: 0, name: '', username: '', role: ''),
      kontrol_pengendalian: '',
      statusPermit: '',
      message: '',
      document: DocumentModel(userId: 0, permitId: 0, documentPath: '', day: 0)
  ).obs;

  var pageController = PageController();

  var lainnyaController = TextEditingController();
  var kontrolLainnyaController = TextEditingController();



  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    lainnyaController = TextEditingController();
    lainnyaController.addListener(_updateLainnyaText);
    kontrolLainnyaController = TextEditingController();
    kontrolLainnyaController.addListener(_updateKontrolLainnyaText);
  }

  Map<String, dynamic> get getPermitt => permitt.value;

  Future<void> updatePermitt(Map<String, dynamic> newData) async {
    // Update each field individually
    newData.forEach((key, value) {
      if (permitt.value.containsKey(key)) {
       permitt.value[key] = value;
      }
    });
  }

  void _updateLainnyaText() {
    final List<Map<String, dynamic>> updatedList = List.from(bahaya.value);
    final index = updatedList.indexWhere((item) => item['pertanyaan'].startsWith('Lainnya:'));

    if (index != -1) {
      updatedList[index]['pertanyaan'] = 'Lainnya: ${lainnyaController.text}';
      bahaya.value = updatedList;
    }
  }
  void _updateKontrolLainnyaText() {
    final List<Map<String, dynamic>> updatedList = List.from(kontrol.value);
    final index = updatedList.indexWhere((item) => item['pertanyaan'].startsWith('Lainnya:'));

    if (index != -1) {
      updatedList[index]['pertanyaan'] = 'Lainnya: ${kontrolLainnyaController.text}';
      kontrol.value = updatedList;
    }
  }


  @override
  void dispose() {
    lainnyaController.removeListener(_updateLainnyaText);
    lainnyaController.dispose();
    kontrolLainnyaController.removeListener(_updateKontrolLainnyaText);
    kontrolLainnyaController.dispose();
    super.dispose();
  }

  void updatedCheckboxBahaya(String screen, String title, bool newValue) {
    if(screen == 'bahaya') {
      final List<Map<String, dynamic>> updatedList = List.from(bahaya.value);
      final index = updatedList.indexWhere((item) => item['pertanyaan'] == title);

      if (index != -1) {
        bahaya.value[index]['value'] = newValue;
        if (title.startsWith('Lainnya:') && newValue) {
          updatedList[index]['pertanyaan'] = 'Lainnya: ${lainnyaController.text}';
        } else if (title.startsWith('Lainnya:') && !newValue) {
          // Kembalikan ke default 'Lainnya:' jika checkbox di-uncheck
          updatedList[index]['pertanyaan'] = 'Lainnya:';
          lainnyaController.clear();
        }
        bahaya.value = updatedList;
      }
    } else if(screen == 'kontrol') {
      final List<Map<String, dynamic>> updatedList = List.from(kontrol.value);
      final index = updatedList.indexWhere((item) => item['pertanyaan'] == title);

      if (index != -1) {
        kontrol.value[index]['value'] = newValue;
        if (title.startsWith('Lainnya:') && newValue) {
          updatedList[index]['pertanyaan'] = 'Lainnya: ${kontrolLainnyaController.text}';
        } else if (title.startsWith('Lainnya:') && !newValue) {
          // Kembalikan ke default 'Lainnya:' jika checkbox di-uncheck
          updatedList[index]['pertanyaan'] = 'Lainnya:';
          kontrolLainnyaController.clear();
        }
        kontrol.value = updatedList;
      }
    }
  }

  Future<void> getPersiapan(String title) async {
    if(title == 'Hotwork') {
      kategoriPekerjaan = hotwork;
    } else if(title == 'Confined Space') {
      kategoriPekerjaan = confined;
    }else if(title == 'Working at Height') {
      kategoriPekerjaan = working;
    }else if(title == 'Lifting and Rigging') {
      kategoriPekerjaan = lifting;
    }else if(title == 'Hotwork & Confined Space') {
      kategoriPekerjaan = hotworkConfined;
    }else if(title == 'Hotwork & Working at Height') {
      kategoriPekerjaan = hotworkWorking;
    }else if(title == 'Hotwork & Confined Space & Working at Height'){
      kategoriPekerjaan = hotworkConfinedWorking;
    }else if(title == 'Confined Space & Working at Height'){
      kategoriPekerjaan = confinedWorking;
    }else{
      is_empty.value = true;
      Get.snackbar('Gagal', 'Data yang anda pilih tidak ada!', backgroundColor: kDanger, colorText: kWhite);
      Get.back();
    }
  }

  void updateCheckboxValue(String title, bool newValue) {
    final List<Map<String, dynamic>> updatedList = List.from(kategoriPekerjaan.value);
    final index = updatedList.indexWhere((item) => item['pertanyaan'] == title);

    if (index != -1) {
      kategoriPekerjaan.value[index]['value'] = newValue;
      kategoriPekerjaan.value = updatedList;
    }
  }

  Future<void> storePermitt(Map<String, dynamic> data) async {
    try {
      const String apiUrl = '${Api.baseUrl}/storePermitt';

      await dio.post(apiUrl, data: data);

      // Show success message if needed
      Get.snackbar('Success', 'Work preparations stored successfully');
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to store work preparations');
    }
  }

  Future<void> getDetailPermit(int permit_id) async {
    try {
      var response = await dio.post(
        '${Api.baseUrl}/getDetailPermit',
        data: {
          'permit_id': permit_id
        }
      );

      if(response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'];
        permitDetail(RequestPermit.fromJson(data));
      } else {
        Get.snackbar('Error', 'Data permit tidak ada');
      }
    } catch(e) {
      print(e);
      Get.snackbar('Error', 'Failed to load permit');
    }
  }

  void nextScreen() {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

}