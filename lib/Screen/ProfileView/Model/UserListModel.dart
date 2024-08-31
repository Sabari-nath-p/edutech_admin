class UserListModel {
  String? name;
  String? username;
  String? phoneNumber;
  int? countOfExamsPurchased;
  int? countOfCoursesPurchased;
  bool? isActive;

  UserListModel(
      {this.name,
      this.username,
      this.phoneNumber,
      this.countOfExamsPurchased,
      this.countOfCoursesPurchased,
      this.isActive});

  UserListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    phoneNumber = json['phone_number'];
    countOfExamsPurchased = json['count_of_exams_purchased'];
    countOfCoursesPurchased = json['count_of_courses_purchased'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['phone_number'] = this.phoneNumber;
    data['count_of_exams_purchased'] = this.countOfExamsPurchased;
    data['count_of_courses_purchased'] = this.countOfCoursesPurchased;
    data['is_active'] = this.isActive;
    return data;
  }
}
