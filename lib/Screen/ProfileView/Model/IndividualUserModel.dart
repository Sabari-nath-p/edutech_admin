class IndividualUserModel {
  int? id;
  String? name;
  String? username;
  String? phoneNumber;
  String? dateJoined;
  String? lastLogin;
  bool? isActive;
  bool? verified;
  int? countOfCoursesPurchased;
  int? countOfExamsPurchased;
  PurchaseList? purchaseList;
  List? examResponse;

  IndividualUserModel(
      {this.id,
      this.name,
      this.username,
      this.phoneNumber,
      this.dateJoined,
      this.lastLogin,
      this.isActive,
      this.verified,
      this.countOfCoursesPurchased,
      this.countOfExamsPurchased,
      this.purchaseList,
      this.examResponse});

  IndividualUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    phoneNumber = json['phone_number'];
    dateJoined = json['date_joined'];
    lastLogin = json['last_login'];
    isActive = json['is_active'];
    verified = json['verified'];
    countOfCoursesPurchased = json['count_of_courses_purchased'];
    countOfExamsPurchased = json['count_of_exams_purchased'];
    purchaseList = json['purchase_list'] != null
        ? new PurchaseList.fromJson(json['purchase_list'])
        : null;
    if (json['exam_response'] != null) {
      examResponse = json['exam_response'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['phone_number'] = this.phoneNumber;
    data['date_joined'] = this.dateJoined;
    data['last_login'] = this.lastLogin;
    data['is_active'] = this.isActive;
    data['verified'] = this.verified;
    data['count_of_courses_purchased'] = this.countOfCoursesPurchased;
    data['count_of_exams_purchased'] = this.countOfExamsPurchased;
    if (this.purchaseList != null) {
      data['purchase_list'] = this.purchaseList!.toJson();
    }
    if (this.examResponse != null) {
      data['exam_response'] = this.examResponse;
    }
    return data;
  }
}

class PurchaseList {
  List<PurchasedCourses>? purchasedCourses;

  PurchaseList({this.purchasedCourses});

  PurchaseList.fromJson(Map<String, dynamic> json) {
    if (json['purchased_courses'] != null) {
      purchasedCourses = <PurchasedCourses>[];
      json['purchased_courses'].forEach((v) {
        purchasedCourses!.add(new PurchasedCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchasedCourses != null) {
      data['purchased_courses'] =
          this.purchasedCourses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchasedCourses {
  int? courseId;
  String? dateOfPurchase;
  String? expirationDate;
  String? orderId;
  double? amountPaid;
  bool? isPaid;

  PurchasedCourses(
      {this.courseId,
      this.dateOfPurchase,
      this.expirationDate,
      this.orderId,
      this.amountPaid,
      this.isPaid});

  PurchasedCourses.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    dateOfPurchase = json['date_of_purchase'];
    expirationDate = json['expiration_date'];
    orderId = json['order_id'];
    amountPaid = json['amount paid'];
    isPaid = json['isPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['date_of_purchase'] = this.dateOfPurchase;
    data['expiration_date'] = this.expirationDate;
    data['order_id'] = this.orderId;
    data['amount paid'] = this.amountPaid;
    data['isPaid'] = this.isPaid;
    return data;
  }
}
