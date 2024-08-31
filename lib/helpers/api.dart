class Api {
  Api._();

  // static const String baseUrl = "http://media-pembelajaran-web.test/api";
  // static const String baseUrl = "http://192.168.18.8/mypermitt-web/public/api";
  // static const String docUrl = "http://192.168.18.8/mypermitt-web/public/storage";
  static const String baseUrl = "http://permitapp.tugas-akhir-mi.my.id/public/api";
  static const String docUrl = "http://permitapp.tugas-akhir-mi.my.id/public/storage";
  // static const String baseUrl = "http://192.168.0.247/mypermitt-web/public/api";
  // static const String docUrl = "http://192.168.0.247/mypermitt-web/public/storage";
  // static const String imgUrl = "http://192.168.18.8/media-pembelajaran-web/public/storage";

  static const Duration receiveTimeout = Duration(seconds: 15000);
  static const Duration connectionTimeout = Duration(seconds: 15000);
}