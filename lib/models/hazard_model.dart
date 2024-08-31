class HazardModel {
  int id;
  int permittId;
  String pertanyaan;
  int value;

  HazardModel({
    required this.id,
    required this.permittId,
    required this.pertanyaan,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pertanyaan': pertanyaan,
      'value': value,
    };
  }


  factory HazardModel.fromJson(Map<String, dynamic> json) {
    return HazardModel(
        id: (json['id']??"") as int,
        permittId: (json['permitt_id']??"") as int,
        pertanyaan: (json['pertanyaan']??"") as String,
        value: (json['value']??"") as int
    );
  }
}