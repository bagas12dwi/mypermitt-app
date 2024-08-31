class WorkPreparationModel {
  int id;
  int permittId;
  String pertanyaan;
  int value;

  WorkPreparationModel({
    required this.id,
    required this.permittId,
    required this.pertanyaan,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'pertanyaan': pertanyaan,
      'value': value,
    };
  }

  factory WorkPreparationModel.fromJson(Map<String, dynamic> json) {
    return WorkPreparationModel(
        id: (json['id']??"") as int,
        permittId: (json['permitt_id']??"") as int,
        pertanyaan: (json['pertanyaan']??"") as String,
        value: (json['value']??"") as int
    );
  }
}