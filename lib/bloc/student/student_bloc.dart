import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../ models/student_model.dart';
import '../../services/firestore_service.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final FirestoreService _firestoreService;
  final String teacherId;

  StudentBloc(this._firestoreService, this.teacherId)
      : super(StudentInitial()) {
    on<LoadStudents>((event, emit) async {
      emit(StudentLoading());
      try {
        final students = _firestoreService.getStudents(teacherId);
        emit(StudentLoaded(students));
      } catch (e) {
        emit(StudentError('Failed to load students'));
      }
    });

    on<AddStudent>((event, emit) async {
      try {
        await _firestoreService.addStudent(
            teacherId, event.name, event.dob, event.gender);
        add(LoadStudents());
      } catch (e) {
        emit(StudentError('Failed to add student'));
      }
    });

    on<UpdateStudent>((event, emit) async {
      try {
        await _firestoreService.updateStudent(
            teacherId, event.id, event.name, event.dob, event.gender);
        add(LoadStudents());
      } catch (e) {
        emit(StudentError('Failed to update student'));
      }
    });
  }
}
