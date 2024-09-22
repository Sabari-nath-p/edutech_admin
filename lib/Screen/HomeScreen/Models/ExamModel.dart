class ExamModel {
  int? examUniqueId;
  int? module;
  int? accessType;
  String? examId;
  String? examName;
  String? instruction;
  String? pdf;
  String? durationOfExam;
  int? totalMarks;
  int? passmark;
  int? noOfQuestions;
  String? createdDate;
  String? updatedDate;
  String? slugExams;
  bool? isActive;

  ExamModel({
    this.examUniqueId,
    this.module,
    this.accessType,
    this.examId,
    this.examName,
    this.instruction,
    this.durationOfExam,
    this.totalMarks,
    this.pdf,
    this.noOfQuestions,
    this.createdDate,
    this.updatedDate,
    this.slugExams,
    this.isActive,
    this.passmark,
  });

  ExamModel.fromJson(Map<String, dynamic> json) {
    examUniqueId = json['exam_unique_id'];
    module = json['module'];
    accessType = json['access_type'];
    examId = json['exam_id'];
    examName = json['exam_name'];
    instruction = json['instruction'];
    durationOfExam = json['duration_of_exam'];
    totalMarks = json['total_marks'];
    noOfQuestions = json['no_of_questions'];
    pdf = json["solution_pdf"];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    slugExams = json['slug_exams'];
    isActive = json['is_active'];
    passmark = json["pass_mark"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam_unique_id'] = this.examUniqueId;
    data['module'] = this.module;
    data['access_type'] = this.accessType;
    data['exam_id'] = this.examId;
    data['exam_name'] = this.examName;
    data['instruction'] = this.instruction;
    data['duration_of_exam'] = this.durationOfExam;
    data['total_marks'] = this.totalMarks;
    data["solution_pdf"] = this.pdf;
    data['no_of_questions'] = this.noOfQuestions;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['slug_exams'] = this.slugExams;
    data['is_active'] = this.isActive;
    return data;
  }
}
