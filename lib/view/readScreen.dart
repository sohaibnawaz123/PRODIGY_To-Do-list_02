// ignore_for_file: file_names

import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_firebase/model/notemodel.dart';
import 'package:todo_list_firebase/utils/constants.dart';
import 'package:todo_list_firebase/view/notesAddScreen.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddNotes(
            appTitle: 'Add Notes', noteId: '',
          ));
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
          child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Notes').orderBy('createdAt', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error in Retiving Data",
                style: appText(AppConstants.appErrorColor, 24),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(
                  color: AppConstants.appBARbg,
                ),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "No Data Found Press Add Note Button To Add Notes",
                  style: appText(AppConstants.appErrorColor, 24),
                ),
              ),
            );
          }
          if (snapshot.data != null) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .8, crossAxisCount: 2),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final noteData = snapshot.data!.docs[index];
                  final NotesModel notesModel = NotesModel(
                      noteId: noteData['noteId'],
                      noteTitle: noteData['noteTitle'],
                      noteDecription: noteData['noteDecription'],
                      createdAt: noteData['createdAt'],
                      updatedAt: noteData['updatedAt']);
                  return GestureDetector(
                    onTap: () => Get.to(AddNotes(appTitle: 'Edit Note', noteId: notesModel.noteId,)),
                    child: Padding(
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
                              Expanded(
                                flex: 1,
                                child: Text(
                                  notesModel.noteTitle,
                                  style: headingText(
                                      AppConstants.headingColor, 18),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: AppConstants.headingColor,
                                height: 2,
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  notesModel.noteDecription,
                                  style: appText(AppConstants.headingColor, 12),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: AppConstants.headingColor,
                                height: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection('Notes')
                                          .doc(notesModel.noteId)
                                          .delete();
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: AppConstants.appErrorColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      )),
    );
  }
}
