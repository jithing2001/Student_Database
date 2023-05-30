import 'package:hive/hive.dart';
import '../model/db_model.dart';


@override
Future<List<StudentModel>> getAllData(String query) async {
  final studentDB = await Hive.openBox<StudentModel>('student');
  List<StudentModel> students = [];
  students.addAll(studentDB.values
      .where((element) =>
          element.name.toLowerCase().contains(query.toLowerCase().trim()))
      .toList());
  return students;
}

Future<void> deleteStudent(id) async {
  final studentDB = await Hive.openBox<StudentModel>('student');
  await studentDB.delete(id);
}
