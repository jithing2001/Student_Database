import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/view/home_screen.dart';
import 'package:student/controllers/editstudentcontroller.dart';
import 'package:student/model/db_model.dart';
import 'dart:core';

class EditStudent extends StatelessWidget {
  final box = Hive.box<StudentModel>('student');

  EditStudentController ed = EditStudentController();
  // final formKey = GlobalKey<FormState>();
  final StudentModel student;
  EditStudent({
    Key? key,
    required this.student,
  }) : super(key: key);

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController placeController = TextEditingController();

  TextEditingController qualificationController = TextEditingController();

  int? newKey;

  XFile? image;

  void details(
      {required name,
      required age,
      required location,
      required imagePath,
      required qualification}) {
    nameController.text = name;
    ageController.text = age;
    placeController.text = location;
    imagePath = imagePath;
    qualificationController.text = qualification;
  }

  // @override
  @override
  Widget build(BuildContext context) {
    details(
        name: student.name,
        age: student.age,
        location: student.location,
        imagePath: student.imagepath,
        qualification: student.qualificcation);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 34, 32, 32),
        appBar: AppBar(
          title: const Text('Edit Student'),
          toolbarHeight: 90,
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(48.0))),
          backgroundColor: const Color.fromARGB(255, 77, 139, 136),
          elevation: 10,
          centerTitle: true,
        ),
        body: GetBuilder<EditStudentController>(
            init: ed,
            builder: (controller) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          child: Image.file(
                            File(ed.imagePath ?? student.imagepath),
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.yellow),
                            labelText: "Name",
                            prefixIcon: const Icon(
                              Icons.man,
                              color: Colors.blue,
                            ),
                            border: myinputborder(),
                            enabledBorder: myinputborder(),
                            focusedBorder: myfocusborder(),
                          ),
                          controller: nameController,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.yellow),
                            labelText: "Age",
                            prefixIcon: const Icon(
                              Icons.date_range,
                              color: Colors.blue,
                            ),
                            border: myinputborder(),
                            enabledBorder: myinputborder(),
                            focusedBorder: myfocusborder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: placeController,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.yellow),
                            labelText: "Location",
                            prefixIcon: const Icon(
                              Icons.location_city,
                              color: Colors.blue,
                            ),
                            border: myinputborder(),
                            enabledBorder: myinputborder(),
                            focusedBorder: myfocusborder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: qualificationController,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.yellow),
                            labelText: "Qualification",
                            prefixIcon: const Icon(
                              Icons.turned_in_not_outlined,
                              color: Colors.blue,
                            ),
                            border: myinputborder(),
                            enabledBorder: myinputborder(),
                            focusedBorder: myfocusborder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () =>
                                    ed.getImage(source: ImageSource.gallery),
                                child: const Text('Select New Image')),
                            ElevatedButton(
                                onPressed: () =>
                                    ed.getImage(source: ImageSource.camera),
                                child: const Text('Take New Image')),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              // box.put(
                              //     student.key,

                              ed.editUpdate(
                                  key: student.key,
                                  student: StudentModel(
                                      imagepath:
                                          ed.imagePath ?? student.imagepath,
                                      name: nameController.text,
                                      age: ageController.text,
                                      location: placeController.text,
                                      qualificcation:
                                          qualificationController.text));

                              sc.getAllStudentsDetails();
                              Get.back();
                            },
                            child: const Text('Submit changes'))
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

OutlineInputBorder myinputborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 58, 176, 255),
        width: 3,
      ));
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.greenAccent,
        width: 3,
      ));
}
