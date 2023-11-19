class MultiSelectModel {
  int? msqId;
  int? questionNo;
  String? questionType;
  int? examName;
  String? question;
  String? questionImage;
  double? positiveMarks;
  double? negetiveMark;
  List<Options>? options;
  String? solutionImage;
  String? solutionText;
  String? slugMultiselect;

  MultiSelectModel(
      {this.msqId,
      this.questionNo,
      this.questionType,
      this.examName,
      this.question,
      this.questionImage,
      this.positiveMarks,
      this.negetiveMark,
      this.options,
      this.solutionImage,
      this.solutionText,
      this.slugMultiselect});

  MultiSelectModel.fromJson(Map<String, dynamic> json) {
    msqId = json['msq_id'];
    questionNo = json['question_no'];
    questionType = json['question_type'];
    examName = json['exam_name'];
    question = json['question'];
    questionImage = json['question_image'];
    positiveMarks = json['positive_marks'];
    negetiveMark = json['negetive_mark'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    solutionImage = json['solution_image'];
    solutionText = json['solution_text'];
    slugMultiselect = json['slug_multiselect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msq_id'] = this.msqId;
    data['question_no'] = this.questionNo;
    data['question_type'] = this.questionType;
    data['exam_name'] = this.examName;
    data['question'] = this.question;
    data['question_image'] = this.questionImage;
    data['positive_marks'] = this.positiveMarks;
    data['negetive_mark'] = this.negetiveMark;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['solution_image'] = this.solutionImage;
    data['solution_text'] = this.solutionText;
    data['slug_multiselect'] = this.slugMultiselect;
    return data;
  }
}

class Options {
  int? optionId;
  int? question;
  int? optionNo;
  String? optionsText;
  String? optionsImage;
  bool? isAnswer;
  String? slugOptions;

  Options(
      {this.optionId,
      this.question,
      this.optionNo,
      this.optionsText,
      this.optionsImage,
      this.isAnswer,
      this.slugOptions});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    question = json['question'];
    optionNo = json['option_no'];
    optionsText = json['options_text'];
    optionsImage = json['options_image'];
    isAnswer = json['is_answer'];
    slugOptions = json['slug_options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['question'] = this.question;
    data['option_no'] = this.optionNo;
    data['options_text'] = this.optionsText;
    data['options_image'] = this.optionsImage;
    data['is_answer'] = this.isAnswer;
    data['slug_options'] = this.slugOptions;
    return data;
  }
}
