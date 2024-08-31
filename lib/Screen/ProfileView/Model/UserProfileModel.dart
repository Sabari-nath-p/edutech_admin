class UserProfileModel {
  int? id;
  String? name;
  String? username;
  String? phoneNumber;
  String? dateJoined;
  String? lastLogin;
  bool? isActive;
  PurchaseList? purchaseList;
  List<ExamResponse>? examResponse;
  String purchaseIDString = "";

  UserProfileModel(
      {this.id,
      this.name,
      this.username,
      this.phoneNumber,
      this.dateJoined,
      this.lastLogin,
      this.isActive,
      this.purchaseList,
      this.examResponse});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    phoneNumber = json['phone_number'];
    dateJoined = json['date_joined'];
    lastLogin = json['last_login'];
    isActive = json['is_active'];
    purchaseList = json['purchase_list'] != null
        ? new PurchaseList.fromJson(json['purchase_list'])
        : null;
    if (json['exam_response'] != null) {
      examResponse = <ExamResponse>[];
      json['exam_response'].forEach((v) {
        examResponse!.add(new ExamResponse.fromJson(v));
      });
    }
    if (purchaseList != null) {
      if (purchaseList!.purchasedCourses != null) {
        purchaseIDString = purchaseList!.purchasedCourses!
            .map((e) => e.courseId)
            .toList()
            .join(",");
      }
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
    if (this.purchaseList != null) {
      data['purchase_list'] = this.purchaseList!.toJson();
    }
    if (this.examResponse != null) {
      data['exam_response'] =
          this.examResponse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchaseList {
  List<PurchasedCourses>? purchasedCourses;
  List<PurchasedExams>? purchasedExams;

  PurchaseList({this.purchasedCourses, this.purchasedExams});

  PurchaseList.fromJson(Map<String, dynamic> json) {
    if (json['purchased_courses'] != null) {
      purchasedCourses = <PurchasedCourses>[];
      json['purchased_courses'].forEach((v) {
        purchasedCourses!.add(new PurchasedCourses.fromJson(v));
      });
    }
    if (json['purchased_exams'] != null) {
      purchasedExams = <PurchasedExams>[];
      json['purchased_exams'].forEach((v) {
        purchasedExams!.add(new PurchasedExams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchasedCourses != null) {
      data['purchased_courses'] =
          this.purchasedCourses!.map((v) => v.toJson()).toList();
    }
    if (this.purchasedExams != null) {
      data['purchased_exams'] =
          this.purchasedExams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchasedCourses {
  int? courseId;
  String? dateOfPurchase;
  String? expirationDate;

  PurchasedCourses({this.courseId, this.dateOfPurchase, this.expirationDate});

  PurchasedCourses.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    dateOfPurchase = json['date_of_purchase'];
    expirationDate = json['expiration_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['date_of_purchase'] = this.dateOfPurchase;
    data['expiration_date'] = this.expirationDate;
    return data;
  }
}

class PurchasedExams {
  int? examId;
  String? dateOfPurchase;
  String? expirationDate;

  PurchasedExams({this.examId, this.dateOfPurchase, this.expirationDate});

  PurchasedExams.fromJson(Map<String, dynamic> json) {
    examId = json['exam_id'];
    dateOfPurchase = json['date_of_purchase'];
    expirationDate = json['expiration_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam_id'] = this.examId;
    data['date_of_purchase'] = this.dateOfPurchase;
    data['expiration_date'] = this.expirationDate;
    return data;
  }
}

class ExamResponse {
  String? examId;
  String? examName;
  var response;
  int? qualifyScore;
  String? timeTaken;
  String? marksScored;

  ExamResponse(
      {this.examId,
      this.examName,
      this.response,
      this.qualifyScore,
      this.timeTaken,
      this.marksScored});

  ExamResponse.fromJson(Map<String, dynamic> json) {
    examId = json['exam_id'];
    examName = json['exam_name'];
    response = json['response'] != null ? json['response'] : null;
    qualifyScore = json['qualify_score'];
    timeTaken = json['time_taken'];
    marksScored = json['marks_scored'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam_id'] = this.examId;
    data['exam_name'] = this.examName;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['qualify_score'] = this.qualifyScore;
    data['time_taken'] = this.timeTaken;
    data['marks_scored'] = this.marksScored;
    return data;
  }
}

class Response {
  String? s1;
  int? time;
  String? title;
  String? passmark;

  Response({this.s1, this.time, this.title, this.passmark});

  Response.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    time = json['time'];
    title = json['title'];
    passmark = json['passmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['time'] = this.time;
    data['title'] = this.title;
    data['passmark'] = this.passmark;
    return data;
  }
}
