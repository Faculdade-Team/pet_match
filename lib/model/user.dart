import 'dart:convert';

class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String cellphone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.cellphone,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'cellphone': cellphone,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'],
      email: map['email'],
      cellphone: map['cellphone'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
