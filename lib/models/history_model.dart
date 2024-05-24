class HistoryModel {
  int id;
  int permittId;
  String name;
  String action;
  String date;

  HistoryModel({
    required this.id,
    required this.permittId,
    required this.name,
    required this.action,
    required this.date,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
        id: (json['id']??'') as int,
        permittId: (json['permitt_id']??'') as int,
        name: (json['name']??'') as String,
        action: (json['action']??'') as String,
        date: (json['date']??'') as String
    );
  }
}
