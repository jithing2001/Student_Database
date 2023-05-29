import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/view/home_screen.dart';
import 'package:student/model/db_model.dart';

class AddStudentController extends GetxController {
  final TextEditingController nameControler = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController qulificationController = TextEditingController();

  XFile? image;

  String? imagepath;
  final formkey = GlobalKey<FormState>();
  var box = Hive.box<StudentModel>('student');

  void addStudent() {
    if (formkey.currentState!.validate()) {
      if (nameControler.text.isEmpty ||
          ageController.text.isEmpty ||
          locationController.text.isEmpty ||
          qulificationController.text.isEmpty ||
          imagepath == null) {
        return;
      } else {
        box.add(StudentModel(
          imagepath: imagepath,
          name: nameControler.text,
          age: ageController.text,
          location: locationController.text,
          qualificcation: qulificationController.text,
        ));
        Get.back();
        sc.getAllStudentsDetails();
      }
    }
  }

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      imagepath = image!.path;
      update();
    }
  }
}
