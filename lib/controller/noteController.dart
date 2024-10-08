// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todo_list_firebase/model/notemodel.dart';

import '../utils/constants.dart';

class NoteController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeToFireStore(String noteId, String noteTitle,
      String noteDecription, dynamic createdAt, dynamic updatedAt) async {
    try {
      NotesModel notesModel = NotesModel(
          noteId: noteId,
          noteTitle: noteTitle,
          noteDecription: noteDecription,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());

      _firestore
          .collection('Notes')
          .doc(noteId.toString())
          .set(notesModel.toMap());
    } catch (e) {
      Get.snackbar(
        'Error',
        "$e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppConstants.appErrorColor,
        colorText: AppConstants.textColor2,
      );
    }
  }

  Future<void> updateNote(String noteId, String noteTitle,
      String noteDecription, dynamic updatedAt) async {
        try {
          _firestore.collection('Notes').doc(noteId).update({
      'noteTitle':noteTitle,
      'noteDecription':noteDecription,
      'updatedAt':updatedAt
    });
        } catch (e) {
          Get.snackbar(
        'Error',
        "$e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppConstants.appErrorColor,
        colorText: AppConstants.textColor2,
      );
        }
    
  }
}
