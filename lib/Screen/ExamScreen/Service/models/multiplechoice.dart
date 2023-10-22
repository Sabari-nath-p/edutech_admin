class MultipleChoiceModel {
  int? mcqId;
  int? questionType;
  int? examName;
  int? questionNo;
  String? question;
  String? questionImage;
  String? option1Text;
  String? option2Text;
  String? option3Text;
  String? option4Text;
  String? option1Image;
  String? option2Image;
  String? option3Image;
  String? option4Image;
  double? positiveMarks;
  double? negetiveMark;

  String? answer;
  String? solutionText;
  String? solutionImage;
  String? slugMultiplechoice;

  MultipleChoiceModel(
      {this.mcqId,
      this.questionType,
      this.examName,
      this.questionNo,
      this.question,
      this.questionImage,
      this.option1Text,
      this.option2Text,
      this.option3Text,
      this.option4Text,
      this.option1Image,
      this.option2Image,
      this.option3Image,
      this.option4Image,
      this.positiveMarks,
      this.negetiveMark,
      this.answer,
      this.solutionText,
      this.solutionImage,
      this.slugMultiplechoice});

  MultipleChoiceModel.fromJson(Map<String, dynamic> json) {
    mcqId = json['mcq_id'];
    questionType = json['question_type'];
    examName = json['exam_name'];
    questionNo = json['question_no'];
    question = json['question'];
    questionImage = json['question_image'];
    option1Text = json['option1_text'];
    option2Text = json['option2_text'];
    option3Text = json['option3_text'];
    option4Text = json['option4_text'];
    option1Image = json['option1_image'];
    option2Image = json['option2_image'];
    option3Image = json['option3_image'];
    option4Image = json['option4_image'];
    positiveMarks = json['positive_marks'];
    negetiveMark = json['negetive_mark'];
    answer = json['answer'];
    solutionText = json['solution_text'];
    solutionImage = json['solution_image'];
    slugMultiplechoice = json['slug_multiplechoice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mcq_id'] = this.mcqId;
    data['question_type'] = this.questionType;
    data['exam_name'] = this.examName;
    data['question_no'] = this.questionNo;
    data['question'] = this.question;
    data['question_image'] = this.questionImage;
    data['option1_text'] = this.option1Text;
    data['option2_text'] = this.option2Text;
    data['option3_text'] = this.option3Text;
    data['option4_text'] = this.option4Text;
    data['option1_image'] = this.option1Image;
    data['option2_image'] = this.option2Image;
    data['option3_image'] = this.option3Image;
    data['option4_image'] = this.option4Image;
    data['positive_marks'] = this.positiveMarks;
    data['negetive_mark'] = this.negetiveMark;
    data['answer'] = this.answer;
    data['solution_text'] = this.solutionText;
    data['solution_image'] = this.solutionImage;
    data['slug_multiplechoice'] = this.slugMultiplechoice;
    return data;
  }
}
