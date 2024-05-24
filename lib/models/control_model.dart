class ControlModel{
  int id;
  int permittId;
  String pertanyaan;
  int value;

  ControlModel({
    required this.id,
    required this.permittId,
    required this.pertanyaan,
    required this.value,
  });

  factory ControlModel.fromJson(Map<String, dynamic> json) {
    return ControlModel(
        id: (json['id']??"") as int,
        permittId: (json['permitt_id']??"") as int,
        pertanyaan: (json['pertanyaan']??"") as String,
        value: (json['value']??"") as int
    );
  }
}