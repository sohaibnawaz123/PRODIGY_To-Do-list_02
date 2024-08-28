// ignore_for_file: file_names

class NotesModel {
  final int noteId;
  final String noteTitle;
  final String noteDecription;
  final String pirority;
  final dynamic createdAt;
  final dynamic updatedAt;

  NotesModel(
      {required this.noteId,
      required this.noteTitle,
      required this.noteDecription,
      required this.pirority,
      required this.createdAt,
      required this.updatedAt});

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'noteTitle': noteTitle,
      'noteDecription': noteDecription,
      'pirority': pirority,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> json) {
    return NotesModel(
        noteId: json['noteId'],
        noteTitle: json['noteTitle'],
        noteDecription: json['noteDecription'],
        pirority: json['pirority'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
