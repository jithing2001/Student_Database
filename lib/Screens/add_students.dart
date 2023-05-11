import 'dart:io';
import 'dart:core';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/model/db_model.dart';

class AddStudent extends StatefulWidget {
  AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final TextEditingController _nameControler = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _qulificationController = TextEditingController();

  XFile? image;

  String? imagepath;

  var box = Hive.box<StudentModel>('student');
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 18, 18),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 77, 139, 136),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(48.0))),
        title: Text('Add Your Details'),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            if (imagepath != null)
              ClipRRect(
                child: Image.file(
                  File(imagepath!),
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 77, 139, 136),
              ),
              onPressed: () => getImage(source: ImageSource.gallery),
              child: const Text('Select New Image'),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 77, 139, 136),
                ),
                onPressed: () => getImage(source: ImageSource.camera),
                child: const Text('Take New Image')),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _nameControler,
                decoration: InputDecoration(
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
                style: TextStyle(color: Colors.white),
                controller: _ageController,
                decoration: InputDecoration(
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
                style: TextStyle(color: Colors.white),
                controller: _locationController,
                decoration: InputDecoration(
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
                style: TextStyle(color: Colors.white),
                controller: _qulificationController,
                decoration: InputDecoration(
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
                    backgroundColor: Color.fromARGB(255, 77, 139, 136),
                  ),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      validCheck(context);
                    } else {
                      print('data empty');
                    }
                    // validCheck(context);
                  },
                  child: Text('ADD-STUDENT')),
            ),
          ],
        ),
      ),
    );
  }

  void validCheck(BuildContext context) {
    if (_nameControler.text.isEmpty ||
        _ageController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _qulificationController.text.isEmpty ||
        imagepath == null) {
      return;
    } else {
      box.add(StudentModel(
        imagepath: imagepath,
        name: _nameControler.text,
        age: _ageController.text,
        location: _locationController.text,
        qualificcation: _qulificationController.text,
      ));
      Navigator.of(context).pop();
    }
  }

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        imagepath = (image!.path);
      });
    } else {
      return null;
    }
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
