import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/services/firebase_cloud_messaging_service.dart';
import 'package:permit_app/services/firebase_service.dart';
import 'package:permit_app/views/wrapper.dart';
import 'package:intl/date_symbol_data_local.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // FIREBASE INITIALIZATION
  await FirebaseService.initializeApp();
  await FirebaseCloudMessagingService.listenFirebaseMessaging();
  print(await FirebaseCloudMessagingService.getFcmToken());
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => const GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}


