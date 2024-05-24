class UserPermit {
  int id;
  String name;
  String username;
  String role;

  UserPermit({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
  });

  factory UserPermit.fromJson(Map<String, dynamic> json){
    return UserPermit(
        id: (json['id']??0) as int,
        name: (json['name']??"") as String,
        username: (json['username']??"") as String,
        role: (json['role']??"") as String
    );
  }

}