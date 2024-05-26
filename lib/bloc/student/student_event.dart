part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();
  @override
  List<Object> get props => [];
}

class LoadStudents extends StudentEvent {}

class AddStudent extends StudentEvent {
  final String name;
  final DateTime dob;
  final String gender;

  const AddStudent(this.name, this.dob, this.gender);

  @override
  List<Object> get props => [name, dob, gender];
}

class UpdateStudent extends StudentEvent {
  final String id;
  final String name;
  final DateTime dob;
  final String gender;

  const UpdateStudent(this.id, this.name, this.dob, this.gender);

  @override
  List<Object> get props => [id, name, dob, gender];
}
