class CourseModel {
  int? courseUniqueId;
  String? fieldOfStudy;
  String? courseImage;
  String? coverImage;
  String? price;
  String? courseDescription;
  String? userBenefit;
  bool? onlyPaid;
  bool? isActive;

  CourseModel(
      {this.courseUniqueId,
      this.fieldOfStudy,
      this.courseImage,
      this.coverImage,
      this.price,
      this.courseDescription,
      this.userBenefit,
      this.onlyPaid,
      this.isActive});

  CourseModel.fromJson(Map<String, dynamic> json) {
    courseUniqueId = json['course_unique_id'];
    fieldOfStudy = json['field_of_study'];
    courseImage = json['course_image'];
    coverImage = json['cover_image'];
    price = json['price'];
    courseDescription = json['Course_description'];
    userBenefit = json['user_benefit'];
    onlyPaid = json['only_paid'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson({bool read = true}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (read) data['course_unique_id'] = this.courseUniqueId;
    data['field_of_study'] = this.fieldOfStudy;
    if (read) data['course_image'] = this.courseImage;
    if (read) data['cover_image'] = this.coverImage;
    data['price'] = this.price;
    data['Course_description'] = this.courseDescription;
    data['user_benefit'] = this.userBenefit;
    data['only_paid'] = this.onlyPaid;
    data['is_active'] = this.isActive;
    return data;
  }
}
