import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/model/db_model.dart';

class EditStudentController extends GetxController {
  final box = Hive.box<StudentModel>('student');
  XFile? image;
  String? imagePath;
  

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    imagePath = image!.path;
    update();
  }

  editUpdate({required int key, required StudentModel student}) {
    box.put(key, student);
  }
}
