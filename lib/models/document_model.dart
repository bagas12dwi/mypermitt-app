class DocumentModel {
  int userId;
  int permitId;
  String documentPath;
  int day;

  DocumentModel({
    required this.userId,
    required this.permitId,
    required this.documentPath,
    required this.day
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json){
    return DocumentModel(
        userId: (json['user_id']??0) as int,
        permitId: (json['permitt_id']??0) as int,
        documentPath: (json['document_path']??'') as String,
        day: (json['day']??0) as int
    );
  }
}
