import 'dart:convert';
import 'dart:io';

class Adoption {
  final int? id;
  final int userId;
  final String name;
  final String healthStatus;
  final String breed;
  final String age;
  final String size;
  final File? imagePath;

  Adoption({
    required this.id,
    required this.userId,
    required this.name,
    required this.healthStatus,
    required this.breed,
    required this.age,
    required this.size,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'healthStatus': healthStatus,
      'breed': breed,
      'age': age,
      'size': size,
      'imagePath': imagePath,
    };
  }

  factory Adoption.fromMap(Map<String, dynamic> map) {
    return Adoption(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['userId'],
      name: map['name'],
      healthStatus: map['healthStatus'],
      breed: map['breed'],
      age: map['age'],
      size: map['size'],
      imagePath: map['imagePath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Adoption.fromJson(String source) =>
      Adoption.fromMap(json.decode(source) as Map<String, dynamic>);
}
