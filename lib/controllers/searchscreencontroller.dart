import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:student/functions/db_functions.dart';

class SearchScreenController extends GetxController {
  
  RxBool isSearching = false.obs;
  RxString query = ''.obs;
  RxList studentList = [].obs;

   getAllStudentsDetails() async {
    studentList.clear();
    studentList.addAll(await getAllData(query.value));
  }

  void searchingFieldOpen(bool isOpen) {
    isSearching.value = isOpen;
  }

  void search(String searchQuery) {
    query.value = searchQuery;
    getAllStudentsDetails();
  }
}
