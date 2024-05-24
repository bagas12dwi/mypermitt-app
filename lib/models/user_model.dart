class User {
  int? id;
  String? name;
  String username;
  String? role;
  String password;


  User({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.password
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: (json['id']??"") as int,
        name: (json['name']??"") as String,
        username: (json['username']??"") as String,
        role: (json['role']??"") as String,
        password: (json['password']??"") as String
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name': name,
      'username': username,
      'password' : password
    };
  }

}
