import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String id;
  final String name;
  final DateTime dob;
  final String gender;

  Student(
      {required this.id,
      required this.name,
      required this.dob,
      required this.gender});

  factory Student.fromFirestore(Map<String, dynamic> data, String id) {
    return Student(
      id: id,
      name: data['name'],
      dob: (data['dob'] as Timestamp).toDate(),
      gender: data['gender'],
    );
  }
}
