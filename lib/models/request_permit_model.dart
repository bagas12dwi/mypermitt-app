import 'package:permit_app/models/control_model.dart';
import 'package:permit_app/models/document_model.dart';
import 'package:permit_app/models/hazard_model.dart';
import 'package:permit_app/models/user_permit_model.dart';
import 'package:permit_app/models/work_preparation_model.dart';

class RequestPermit {
  int id;
  int userId;
  String permittNumber;
  String workCategory;
  String projectName;
  String date;
  String time;
  String typeOfWork;
  String kontrol_pengendalian;
  List<ControlModel> control;
  String organic;
  int workers;
  String description;
  String location;
  String toolsUsed;
  String liftingDistance;
  int gasMeasurements;
  int oksigen;
  int karbonDioksida;
  int hidrogenSulfida;
  int lel;
  int amanMasuk;
  int amanHotwork;
  int isApproveHse;
  int isApproveManager;
  String status;
  String statusPermit;
  String message;
  List<WorkPreparationModel> workPreparation;
  List<HazardModel> hazard;
  UserPermit user;
  DocumentModel document;

  RequestPermit({
    required this.id,
    required this.userId,
    required this.permittNumber,
    required this.workCategory,
    required this.projectName,
    required this.date,
    required this.time,
    required this.typeOfWork,
    required this.control,
    required this.organic,
    required this.workers,
    required this.description,
    required this.location,
    required this.toolsUsed,
    required this.liftingDistance,
    required this.gasMeasurements,
    required this.oksigen,
    required this.karbonDioksida,
    required this.hidrogenSulfida,
    required this.lel,
    required this.amanMasuk,
    required this.amanHotwork,
    required this.isApproveHse,
    required this.isApproveManager,
    required this.status,
    required this.workPreparation,
    required this.hazard,
    required this.user,
    required this.kontrol_pengendalian,
    required this.statusPermit,
    required this.message,
    required this.document
  });

  factory RequestPermit.fromJson(Map<String, dynamic> json) {
    List<dynamic> controlJson = (json['control']??[]) as List;
    List<dynamic> workPreparationJson = (json['work_preparation']??[]) as List;
    List<dynamic> hazardJson = (json['hazard']??[]) as List;
    Map<String, dynamic> userJson = json['user'] ?? {};
    Map<String, dynamic> documentJson = json['document'] ?? {};

    List<ControlModel> control = controlJson.map((conJson) => ControlModel.fromJson(conJson)).toList();
    List<WorkPreparationModel> workPreparation = workPreparationJson.map((workJson) => WorkPreparationModel.fromJson(workJson)).toList();
    List<HazardModel> hazard = hazardJson.map((hazJson) => HazardModel.fromJson(hazJson)).toList();
    UserPermit user = UserPermit.fromJson(userJson);
    DocumentModel document = DocumentModel.fromJson(documentJson);

    return RequestPermit(
        id: (json['id']??0) as int,
        userId: (json['user_id']??0) as int,
        permittNumber: (json['permitt_number']??"") as String,
        workCategory: (json['work_category']??"") as String,
        projectName: (json['project_name']??"") as String,
        date: (json['date']??"") as String,
        time: (json['time']??"") as String,
        typeOfWork: (json['type_of_work']??"") as String,
        control: control,
        organic: (json['organic']??"") as String,
        workers: (json['workers']??0) as int,
        description: (json['description']??"") as String,
        location: (json['location']??"") as String,
        toolsUsed: (json['tools_used']??"") as String,
        liftingDistance: (json['lifting_distance']??"") as String,
        gasMeasurements: (json['gas_measurements']??0) as int,
        oksigen: (json['oksigen']??0) as int,
        karbonDioksida: (json['karbon_dioksida']??0) as int,
        hidrogenSulfida: (json['hidrogen_sulfida']??0) as int,
        lel: (json['lel']??0) as int,
        amanMasuk: (json['aman_masuk']??0) as int,
        amanHotwork: (json['aman_hotwork']??0) as int,
        isApproveHse: (json['is_approve_hse']??0) as int,
        isApproveManager: (json['is_approve_manager']??0) as int,
        status: (json['status']??"") as String,
        workPreparation: workPreparation,
        hazard: hazard,
        user: user,
        kontrol_pengendalian: (json['kontrol_pengendalian']??"") as String,
        statusPermit: (json['status_permit']??"") as String,
        message: (json['message']??"") as String,
        document: document
    );
  }
}