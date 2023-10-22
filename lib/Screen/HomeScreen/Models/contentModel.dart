import 'package:mathlab_admin/Screen/HomeScreen/Models/ExamModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/NoteModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/VideoModel.dart';

class contentModel {
  int? content_id;
  String? title;
  String? type;
  String? created_date;
  bool? isVisible;
  VideoModel? video;
  NoteModel? noteModel;
  ExamModel? examModel;

  contentModel(
    this.content_id,
    this.title,
    this.type,
    this.created_date,
    this.video,
    this.noteModel,
    this.examModel,
    this.isVisible,
  );
}
