// ignore: file_names
// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:todo_list_firebase/controller/noteController.dart';
import 'package:todo_list_firebase/view/readScreen.dart';
import '../utils/constants.dart';

class AddNotes extends StatelessWidget {
  final String appTitle;
  AddNotes({super.key, required this.appTitle});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final NoteController _noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appbg,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstants.textColor2),
        backgroundColor: AppConstants.appBARbg,
        title: Text(
          appTitle,
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
              SizedBox(
                height: Get.height / 20,
              ),
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
              SizedBox(
                height: Get.height / 30,
              ),
              SizedBox(
                width: Get.width * 0.9,
                child: TextField(
                  enabled: true,
                  minLines: 15,
                  maxLines: 30,
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
              SizedBox(
                height: Get.height / 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.appBARbg,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    maximumSize: Size(Get.width - 40, 50),
                    minimumSize: Size(Get.width - 40, 50),
                  ),
                  onPressed: () async {
                    String title = titleController.text;
                    String description = descriptionController.text;

                    if (title.isNotEmpty && description.isNotEmpty) {
                      String noteId = randomAlphaNumeric(10);
                      await _noteController.storeToFireStore(noteId, title,
                          description, DateTime.now(), DateTime.now());

                      Get.offAll(const ReadScreen());
                    } else {
                      Get.snackbar('Error', "Please Fill the Feilds",
                          snackPosition: SnackPosition.TOP,
                          colorText: AppConstants.textColor2,
                          backgroundColor: AppConstants.appErrorColor);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_comment_outlined,
                        color: AppConstants.textColor2,
                        shadows: [
                          BoxShadow(
                              color: AppConstants.textColor,
                              offset: const Offset(1, 1),
                              blurRadius: 5)
                        ],
                        size: 30,
                      ),
                      SizedBox(
                        width: Get.width * 0.05,
                      ),
                      Text(
                        'ADD NOTE',
                        style: headingText(AppConstants.textColor2, 28,
                            shadowColor: AppConstants.textColor),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
