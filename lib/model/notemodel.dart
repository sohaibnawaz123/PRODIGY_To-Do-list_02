// ignore_for_file: file_names

class NotesModel {
  final String noteId;
  final String noteTitle;
  final String noteDecription;
  final dynamic createdAt;
  final dynamic updatedAt;

  NotesModel(
      {required this.noteId,
      required this.noteTitle,
      required this.noteDecription,
      required this.createdAt,
      required this.updatedAt});

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'noteTitle': noteTitle,
      'noteDecription': noteDecription,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> json) {
    return NotesModel(
        noteId: json['noteId'],
        noteTitle: json['noteTitle'],
        noteDecription: json['noteDecription'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
