class SubjectModel {
  int? subjectId;
  int? fieldOfStudy;
  String? subjects;
  String? subjectImage;
  int? modulesCount;
  String? directSlug;
  bool? isActive;

  SubjectModel({
    this.subjectId,
    this.fieldOfStudy,
    this.subjects,
    this.subjectImage,
    this.modulesCount,
    this.directSlug,
    this.isActive,
  });

  SubjectModel.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    fieldOfStudy = json['field_of_study'];
    subjects = json['subjects'];
    subjectImage = json['subject_image'];
    modulesCount = json['modules_count'];
    directSlug = json['direct_slug'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_id'] = this.subjectId;
    data['field_of_study'] = this.fieldOfStudy;
    data['subjects'] = this.subjects;
    data['subject_image'] = this.subjectImage;
    data['modules_count'] = this.modulesCount;
    data['direct_slug'] = this.directSlug;
    data['is_active'] = this.isActive;
    return data;
  }
}
