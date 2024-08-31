class SectionModel {
  int? id;
  int? examName;
  String? sectionNo;
  String? sectionName;
  int? noOfQuesToBeValidated;
  double? positiveMarks;
  double? negetiveMark;
  int? totalScore;
  int? noOfQuestions;

  SectionModel(
      {this.id,
      this.examName,
      this.sectionNo,
      this.sectionName,
      this.noOfQuesToBeValidated,
      this.positiveMarks,
      this.negetiveMark,
      this.totalScore,
      this.noOfQuestions});

  SectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examName = json['exam_name'];
    sectionNo = json['section_no'];
    sectionName = json['section_name'];
    noOfQuesToBeValidated = json['no_of_ques_to_be_validated'];
    positiveMarks = json['positive_marks'];
    negetiveMark = json['negetive_mark'];
    totalScore = json['total_score'];
    noOfQuestions = json['no_of_questions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exam_name'] = this.examName;
    data['section_no'] = this.sectionNo;
    data['section_name'] = this.sectionName;
    data['no_of_ques_to_be_validated'] = this.noOfQuesToBeValidated;
    data['positive_marks'] = this.positiveMarks;
    data['negetive_mark'] = this.negetiveMark;
    data['total_score'] = this.totalScore;
    data['no_of_questions'] = this.noOfQuestions;
    return data;
  }
}
