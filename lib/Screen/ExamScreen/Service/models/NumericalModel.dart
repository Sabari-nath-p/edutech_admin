class NumericalsModel {
  int? nqId;
  int? questionType;
  int? examName;
  int? questionNo;
  String? question;
  String? questionImage;
  String? ansMinRange;
  String? ansMaxRange;
  String? answer;
  double? positiveMarks;
  double? negetiveMark;
  String? solutionText;
  String? solutionImage;
  String? slugNumericals;

  NumericalsModel(
      {this.nqId,
      this.questionType,
      this.examName,
      this.questionNo,
      this.question,
      this.questionImage,
      this.ansMinRange,
      this.ansMaxRange,
      this.answer,
      this.positiveMarks,
      this.negetiveMark,
      this.solutionText,
      this.solutionImage,
      this.slugNumericals});

  NumericalsModel.fromJson(Map<String, dynamic> json) {
    nqId = json['nq_id'];
    questionType = json['question_type'];
    examName = json['exam_name'];
    questionNo = json['question_no'];
    question = json['question'];
    questionImage = json['question_image'];
    ansMinRange = json['ans_min_range'];
    ansMaxRange = json['ans_max_range'];
    answer = json['answer'];
    positiveMarks = json['positive_marks'];
    negetiveMark = json['negetive_mark'];
    solutionText = json['solution_text'];
    solutionImage = json['solution_image'];
    slugNumericals = json['slug_numericals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nq_id'] = this.nqId;
    data['question_type'] = this.questionType;
    data['exam_name'] = this.examName;
    data['question_no'] = this.questionNo;
    data['question'] = this.question;
    data['question_image'] = this.questionImage;
    data['ans_min_range'] = this.ansMinRange;
    data['ans_max_range'] = this.ansMaxRange;
    data['answer'] = this.answer;
    data['positive_marks'] = this.positiveMarks;
    data['negetive_mark'] = this.negetiveMark;
    data['solution_text'] = this.solutionText;
    data['solution_image'] = this.solutionImage;
    data['slug_numericals'] = this.slugNumericals;
    return data;
  }
}
