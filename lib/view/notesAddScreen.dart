import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:todo_list_firebase/controller/noteController.dart';
import 'package:todo_list_firebase/view/readScreen.dart';
import '../utils/constants.dart';

class AddNotes extends StatefulWidget {
  final String appTitle;
  final String noteId;
  const AddNotes({super.key, required this.appTitle, required this.noteId});

  @override
  State<AddNotes> createState() => AddNotesState();
}

class AddNotesState extends State<AddNotes> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final NoteController _noteController = Get.put(NoteController());
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    if (widget.noteId.isNotEmpty) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    try {
      var document = await FirebaseFirestore.instance
          .collection('Notes')
          .doc(widget.noteId)
          .get();
      if (document.exists) {
        var noteData = document.data()!;
        titleController.text = noteData['noteTitle'] ?? '';
        descriptionController.text = noteData['noteDecription'] ?? '';
        isUpdating = true;
      }
    } catch (e) {
      Get.snackbar('Error', "Failed to load note: $e",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppConstants.appErrorColor,
          colorText: AppConstants.textColor2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appbg,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              if (isUpdating) {
                _noteController.updateNote(
                  widget.noteId,
                  titleController.text,
                  descriptionController.text,
                  DateTime.now(),
                );
                Get.offAll(ReadScreen());
              } else {
                sendData();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.save,
                color: AppConstants.textColor2,
                shadows: [
                  BoxShadow(
                      color: AppConstants.textColor,
                      offset: const Offset(1, 1),
                      blurRadius: 5)
                ],
                size: 30,
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: AppConstants.textColor2),
        backgroundColor: AppConstants.appBARbg,
        title: Text(
          widget.appTitle,
          style: headingText(AppConstants.textColor2, 36,
              shadowColor: AppConstants.textColor),
        ),
        elevation: 5,
        shadowColor: AppConstants.headingColor,
      ),
      body: Align(
        alignment: const Alignment(0, -1),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.height / 20),
              SizedBox(
                width: Get.width * 0.9,
                child: TextField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: Text(
                      'Note Title',
                      style: appText(AppConstants.headingColor, 24),
                    ),
                    hintText: 'Note title',
                    hintStyle: appText(AppConstants.textColor, 18),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2,
                            color: AppConstants.headingColor,
                            style: BorderStyle.solid)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2,
                            color: AppConstants.headingColor,
                            style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2,
                            color: AppConstants.appBARbg,
                            style: BorderStyle.solid)),
                  ),
                ),
              ),
              SizedBox(height: Get.height / 30),
              SizedBox(
                width: Get.width * 0.9,
                child: TextField(
                  enabled: true,
                  minLines: 17,
                  maxLines: 17,
                  scrollPhysics: const AlwaysScrollableScrollPhysics(),
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Note Description',
                    hintStyle: appText(AppConstants.textColor, 18),
                    label: Text(
                      'Note Description',
                      style: appText(AppConstants.headingColor, 24),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2,
                            color: AppConstants.headingColor,
                            style: BorderStyle.solid)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2,
                            color: AppConstants.headingColor,
                            style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2,
                            color: AppConstants.appBARbg,
                            style: BorderStyle.solid)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendData() async {
    String title = titleController.text;
    String description = descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      String noteId = randomAlphaNumeric(10);
      await _noteController.storeToFireStore(
          noteId, title, description, DateTime.now(), DateTime.now());

      Get.offAll(const ReadScreen());
    } else {
      Get.snackbar('Error', "Please Fill the Fields",
          snackPosition: SnackPosition.TOP,
          colorText: AppConstants.textColor2,
          backgroundColor: AppConstants.appErrorColor);
    }
  }
}
