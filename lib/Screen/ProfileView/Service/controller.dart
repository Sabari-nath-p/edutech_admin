import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mathlab_admin/Constants/AppHeaders.dart';
import 'package:mathlab_admin/Constants/Strings.dart';
import 'package:mathlab_admin/Screen/ProfileView/Model/UserProfileModel.dart';

class ProfileController extends GetxController {
  List<UserProfileModel> userList = [];
  UserProfileModel? selectedProfileModel;
  bool loading = false;

  loadProfiles() async {
    userList.clear();
    final Response = await get(Uri.parse(endpoint + "users/viewallusers/"),
        headers: AuthHeader);

    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      for (var data in js) {
        userList.add(UserProfileModel.fromJson(data));
      }
      update();
    }
  }

  String getEnrollCount(UserProfileModel up) {
    int courseC = 0;
    int examc = 0;
    if (up.purchaseList != null) {
      if (up.purchaseList!.purchasedCourses != null)
        courseC = up.purchaseList!.purchasedCourses!.length;
      if (up.purchaseList!.purchasedExams != null)
        examc = up.purchaseList!.purchasedExams!.length;
    }

    return "$courseC , $examc";
  }

  String DateView(String dt) {
    return DateFormat.yMMMMd().format(DateTime.parse(dt).toLocal());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    loadProfiles();
    super.onInit();
  }
}
