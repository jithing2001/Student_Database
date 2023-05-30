import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/view/edit.dart';
import 'package:student/view/student_view.dart';
import 'package:student/controllers/searchscreencontroller.dart';
import 'package:student/functions/db_functions.dart';
import 'dart:core';
import 'add_students.dart';

SearchScreenController sc = Get.put(SearchScreenController());

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  Icon myIcon = const Icon(Icons.search);

  Widget myField = const Text('Student Data');

  String searchInput = "";

  @override
  Widget build(BuildContext context) {
    sc.getAllStudentsDetails();
    return Scaffold(
        backgroundColor: const Color.fromARGB(202, 27, 26, 26),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Obx(
              () => AppBar(
                centerTitle: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20.0))),
                elevation: 0,
                backgroundColor: const Color.fromARGB(255, 77, 139, 136),
                shadowColor: const Color.fromARGB(255, 16, 117, 201),
                actions: [
                  sc.isSearching.value
                      ? IconButton(
                          onPressed: () {
                            sc.searchingFieldOpen(false);
                          },
                          icon: const Icon(Icons.close))
                      : IconButton(
                          onPressed: () async {
                            sc.searchingFieldOpen(true);
                            sc.search('');
                          },
                          icon: const Icon(
                            Icons.search,
                          ),
                        )
                ],
                title: sc.isSearching.value
                    ? TextFormField(
                        onChanged: (value) {
                          sc.search(value);
                        },
                        cursorColor: const Color.fromARGB(255, 2, 110, 5),
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 17),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white)),
                          hintText: 'Search here',
                        ),
                      )
                    : const Text('Student List'),
              ),
            )),
        body: SafeArea(child: Obx(() {
          if (sc.studentList.isEmpty) {
            return const Center(
              child: Text('No Student Found'),
            );
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: ListTile(
                  onTap: () => Get.to(StudentView(
                    name: sc.studentList[index].name,
                    age: sc.studentList[index].age,
                    imagePath: sc.studentList[index].imagepath,
                    location: sc.studentList[index].location,
                    qualification: sc.studentList[index].qualificcation,
                  )),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: Text(sc.studentList[index].name),
                  leading: sc.studentList[index].imagepath == null
                      ? CircleAvatar(
                          backgroundColor: Colors.green.shade100,
                          radius: 20,
                        )
                      : InkWell(
                          child: CircleAvatar(
                            child: ClipOval(
                              child: Image.file(
                                File(sc.studentList[index].imagepath),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.dialog(AlertDialog(
                              content: Image.file(
                                  File(sc.studentList[index].imagepath),
                                  fit: BoxFit.cover),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ));
                          },
                        ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(EditStudent(student: sc.studentList[index]));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.dialog(AlertDialog(
                            content: const Text(
                              'Are you sure?',
                              style: TextStyle(fontSize: 22),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('No')),
                              TextButton(
                                  onPressed: () async {
                                    await deleteStudent(
                                        sc.studentList[index].key);
                                    sc.getAllStudentsDetails();
                                    Get.back();
                                  },
                                  child: const Text('Yes'))
                            ],
                          ));
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  tileColor: const Color.fromARGB(255, 202, 200, 181),
                ),
              );
            },
            itemCount: sc.studentList.length,
          );
        })),

        // ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.to(AddStudent());
          },
        ));
  }
}
