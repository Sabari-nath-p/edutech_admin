import 'package:mathlab_admin/Screen/ExamScreen/Service/models/NumericalModel.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/models/multiSelectModel.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/models/multiplechoice.dart';

class questionsModel {
  int? questionID;
  int? questionNumber;
  String? questionType;
  MultipleChoiceModel? questionModel;
  MultiSelectModel? multiSelectModel;
  NumericalsModel? numericalsModel;

  questionsModel(this.questionID, this.questionNumber, this.questionType,
      this.questionModel, this.multiSelectModel, this.numericalsModel);
}
