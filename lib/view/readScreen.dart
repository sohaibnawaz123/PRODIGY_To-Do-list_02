// ignore_for_file: file_names

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_firebase/utils/constants.dart';
import 'package:todo_list_firebase/view/notesAddScreen.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddNotes());
        },
        backgroundColor: AppConstants.appBARbg,
        elevation: 20,
        tooltip: "Add Note",
        child: Icon(
          Icons.note_add,
          color: AppConstants.appbg,
        ),
      ),
      backgroundColor: AppConstants.appbg,
      appBar: AppBar(
        backgroundColor: AppConstants.appBARbg,
        title: Text(
          "ToDo List",
          style: headingText(AppConstants.textColor2, 36,
              shadowColor: AppConstants.textColor),
        ),
        elevation: 5,
        shadowColor: AppConstants.headingColor,
      ),
      body: SizedBox(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: .8, crossAxisCount: 2),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClayContainer(
                  width: Get.width * 0.45,
                  height: Get.height * 0.3,
                  borderRadius: 10,
                  spread: 1,
                  depth: 50,
                  color: AppConstants.appbg,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tittles",
                          style: headingText(AppConstants.headingColor, 24),
                        ),
                        Divider(
                          thickness: 2,
                          color: AppConstants.headingColor,
                          height: 2,
                        ),
                        Text(
                          "Description",
                          style: appText(AppConstants.headingColor, 18),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
