import 'dart:developer';
import 'dart:io';
import 'dart:core';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/controllers/addstudentcontroller.dart';

class AddStudent extends StatelessWidget {
  // AddStudentController ad = Get.put(AddStudentController());
  AddStudentController ad = AddStudentController();

  @override
  Widget build(BuildContext context) {
    // ad.nameControler.clear();
    // ad.ageController.clear();
    // ad.qulificationController.clear();
    // ad.locationController.clear();
    // ad.imagepath = null;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 18),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 77, 139, 136),
        toolbarHeight: 90,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(48.0))),
        title: const Text('Add Your Details'),
      ),
      body: GetBuilder<AddStudentController>(
          init: ad,
          builder: (controller) {
            return Form(
              key: ad.formkey,
              child: ListView(
                children: [
                  if (ad.imagepath != null)
                    ClipRRect(
                      child: Image.file(
                        File(ad.imagepath!),
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 77, 139, 136),
                    ),
                    onPressed: () => ad.getImage(source: ImageSource.gallery),
                    child: const Text('Select New Image'),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 77, 139, 136),
                      ),
                      onPressed: () => ad.getImage(source: ImageSource.camera),
                      child: const Text('Take New Image')),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: ad.nameControler,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        hintText: 'Name',
                        filled: true,
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: ad.ageController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        hintText: 'Age',
                        filled: true,
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Age is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: ad.locationController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        hintText: 'Location',
                        filled: true,
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Location is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: ad.qulificationController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        hintText: 'Qualification',
                        filled: true,
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Qualification is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 77, 139, 136),
                        ),
                        onPressed: () {
                          if (ad.formkey.currentState!.validate()) {
                            ad.addStudent();
                          } else {
                            log('Data Empty');
                          }
                          // validCheck(context);
                        },
                        child: const Text('ADD-STUDENT')),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

OutlineInputBorder myinputborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 255, 255, 255),
        width: 3,
      ));
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 0, 225, 255),
        width: 3,
      ));
}
