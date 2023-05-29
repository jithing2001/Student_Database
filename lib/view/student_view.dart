import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student/model/db_model.dart';

class StudentView extends StatelessWidget {
  final String name;
  final String age;
  final String location;
  final String qualification;
  final String? imagePath;

  StudentView(
      {Key? key,
      required this.name,
      required this.age,
      required this.location,
      required this.qualification,
      required this.imagePath})
      : super(key: key);

  final box = Hive.box<StudentModel>('student');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(179, 39, 37, 37),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 77, 139, 136),
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(48.0))),
        title: const Text('Student Details'),
        centerTitle: true,
        elevation: 10,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 100,
                  backgroundColor: const Color.fromARGB(255, 233, 235, 233),
                  child: imagePath == null
                      ? null
                      : ClipOval(
                          child: Image.file(
                            File(imagePath!),
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        )),
              const SizedBox(height: 10),
              Text(
                'Name : $name',
                style: const TextStyle(
                    color: Color.fromARGB(255, 17, 191, 221), fontSize: 35),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Place : $location',
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                ('Age : $age'),
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                ('Qualification : $qualification'),
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
