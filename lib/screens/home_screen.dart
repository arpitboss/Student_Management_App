import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:student_management_app/screens/student_details_form.dart';

import '../ models/student_model.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/bottom_nav/bottom_nav_bloc.dart';
import '../bloc/bottom_nav/bottom_nav_state.dart';
import '../bloc/student/student_bloc.dart';
import '../services/firestore_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User user =
        (BlocProvider.of<AuthBloc>(context).state as AuthAuthenticated).user;

    return BlocProvider(
      create: (context) =>
          StudentBloc(FirestoreService(), user.uid)..add(LoadStudents()),
      child: BlocBuilder<BottomNavigationBloc, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  const Text(
                    "Student Management",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.school,
                    color: Colors.grey[200],
                  )
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.red[300],
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                    BlocProvider.of<AuthBloc>(context)
                        .add(AuthSignOutRequested());
                  },
                ),
              ],
              backgroundColor: const Color(0xFF398AE5),
              elevation: 0,
            ),
            body: IndexedStack(
              index: selectedIndex,
              children: const [
                StudentList(),
                StudentForm(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Students',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Add Student',
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: const Color(0xFF398AE5),
              onTap: (index) {
                BlocProvider.of<BottomNavigationBloc>(context)
                    .add(BottomNavigationChanged(index));
              },
            ),
          );
        },
      ),
    );
  }
}

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext contexts) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is StudentLoaded) {
          return StreamBuilder<List<Student>>(
            stream: state.students,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final students = snapshot.data!;
              if (students.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.school,
                          size: 100,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'No students data found',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Add some students data',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: Icon(
                        _getGenderIcon(student.gender),
                        size: 40,
                        color: Colors.blue,
                      ),
                      title: Text(
                        student.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: Text(
                        '${DateFormat.yMd().format(student.dob)} - ${student.gender}',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            final nameController =
                                TextEditingController(text: student.name);
                            var selectedGender = student.gender;
                            DateTime selectedDate = student.dob;
                            return AlertDialog(
                              backgroundColor: Colors.white.withOpacity(1.0),
                              title: const Text('Update Student'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 16), // Add some spacing
                                  DropdownButtonFormField<String>(
                                    value: selectedGender,
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        selectedGender = newValue;
                                      }
                                    },
                                    items: <String>['Male', 'Female', 'Other']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      labelText: 'Gender',
                                      border: const OutlineInputBorder(),
                                      filled: false,
                                      fillColor: Colors.grey[100],
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 16), // Add some spacing
                                  TextButton(
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.date_range_rounded,
                                          color: Colors.blueGrey,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Select Date of Birth',
                                          style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return Theme(
                                            data: ThemeData.light().copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                primary: Colors.blue,
                                                onPrimary: Colors.white,
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      ).then((date) {
                                        if (date != null) {
                                          selectedDate = date;
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<StudentBloc>(contexts).add(
                                      UpdateStudent(
                                        student.id,
                                        nameController.text,
                                        selectedDate,
                                        selectedGender, // Use selectedGender instead of genderController.text
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        }
        return const Center(child: Text('No students data found'));
      },
    );
  }

  IconData _getGenderIcon(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return Icons.boy_rounded;
      case 'female':
        return Icons.girl_rounded;
      case 'other':
      default:
        return Icons.person_search_sharp;
    }
  }
}
