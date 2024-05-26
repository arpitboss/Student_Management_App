import 'package:cloud_firestore/cloud_firestore.dart';

import '../ models/student_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addStudent(
      String teacherId, String name, DateTime dob, String gender) {
    return _db
        .collection('teachers')
        .doc(teacherId)
        .collection('students')
        .add({
      'name': name,
      'dob': dob,
      'gender': gender,
    });
  }

  Stream<List<Student>> getStudents(String teacherId) {
    return _db
        .collection('teachers')
        .doc(teacherId)
        .collection('students')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Student.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  Future<void> updateStudent(String teacherId, String studentId, String name,
      DateTime dob, String gender) {
    return _db
        .collection('teachers')
        .doc(teacherId)
        .collection('students')
        .doc(studentId)
        .update({
      'name': name,
      'dob': dob,
      'gender': gender,
    });
  }
}
