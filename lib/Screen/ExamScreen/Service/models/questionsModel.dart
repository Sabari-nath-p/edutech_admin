import 'package:mathlab_admin/Screen/ExamScreen/Service/models/multiplechoice.dart';

class questionsModel {
  int? questionID;
  int? questionNumber;
  String? questionType;
  MultipleChoiceModel? questionModel;

  questionsModel(this.questionID, this.questionNumber, this.questionType,
      this.questionModel);
}
