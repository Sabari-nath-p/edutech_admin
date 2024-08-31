class CUserlistModel {
  String? username;
  String? phoneNumber;
  String? courseName;
  int? noOfDaysToExpire;
  bool? expired;
  String? userId;
  String? name;

  CUserlistModel(
      {this.username,
      this.phoneNumber,
      this.courseName,
      this.noOfDaysToExpire,
      this.expired,
      this.userId,
      this.name});

  CUserlistModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phoneNumber = json['phone_number'];
    courseName = json['course_name'];
    noOfDaysToExpire = int.parse(json['no_of_days_to_expire'].toString());
    expired = json['expired'];
    userId = json['user_id'].toString();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['phone_number'] = this.phoneNumber;
    data['course_name'] = this.courseName;
    data['no_of_days_to_expire'] = this.noOfDaysToExpire;
    data['expired'] = this.expired;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    return data;
  }
}
