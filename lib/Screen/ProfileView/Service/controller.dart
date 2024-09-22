import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mathlab_admin/Constants/AppHeaders.dart';
import 'package:mathlab_admin/Constants/Strings.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';
import 'package:mathlab_admin/Screen/ProfileView/Model/CUserListModel.dart';
import 'package:mathlab_admin/Screen/ProfileView/Model/IndividualUserModel.dart';
import 'package:mathlab_admin/Screen/ProfileView/Model/UserListModel.dart';
import 'package:mathlab_admin/Screen/ProfileView/Model/UserProfileModel.dart';
import 'package:excel/excel.dart' as ex;
import 'package:mathlab_admin/Screen/ProfileView/View/IndividualProfileView.dart';

class ProfileController extends GetxController {
  List<UserProfileModel> userList = [];
  List<UserListModel> SearchStudentList = [];
  UserListModel? selectedProfileModel;
  IndividualUserModel? individualUser;
  bool loading = false;
  TextEditingController courseText = TextEditingController();
  TextEditingController exportCourseText = TextEditingController();
  TextEditingController notificationCourseText = TextEditingController();
  TextEditingController NotificationMessage = TextEditingController();
  TextEditingController NotificationBody = TextEditingController();
  TextEditingController NotificationDate = TextEditingController();
  var profileDatas;

  String getCourseID(String courseName) {
    HomeController ctrl = Get.put(HomeController());
    for (var data in ctrl.CourseList) {
      if (data.fieldOfStudy == courseName)
        return data.courseUniqueId.toString();
    }
    return "";
  }

  fetchUser(String email) async {
    individualUser = null;
    update();
    final Response = await get(
        Uri.parse(endpoint +
            "applicationview/get-all-user-list/${selectedProfileModel!.username!}"),
        headers: AuthHeader);

    if (Response.statusCode == 200) {
      individualUser = IndividualUserModel.fromJson(json.decode(Response.body));
      update();
    }
  }

  sendNotificationActiveCourse({bool isexpired = false}) async {
    if (notificationCourseText.text.isNotEmpty &&
        NotificationMessage.text.isNotEmpty &&
        NotificationBody.text.isNotEmpty) {
      //  final Response = await
      String parms = "";
      if (isexpired) parms = "show_expired=True&";
      final Response = await get(
          Uri.parse(endpoint +
              "users/get-remaning-dates?course=true&course_name=${notificationCourseText.text}&${parms}"),
          headers: AuthHeader);

      if (Response.statusCode == 200) {
        var data = json.decode(Response.body);

        List<CUserlistModel> clist = [];
        for (var user in data) {
          clist.add(CUserlistModel.fromJson(user));
        }
        print(clist);

        final notResponse =
            await post(Uri.parse("https://api.engagespot.com/v3/notifications"),
                headers: {
                  "X-ENGAGESPOT-API-KEY": "4j76o2qeddbwmfqat1pczp",
                  'Accept': 'application/json',
                  "Content-Type": "application/json",
                  "X-ENGAGESPOT-API-SECRET":
                      "9cjcp7c8a7gptpi1eknc9m0j2g22ga2bb5hi0eh90a8j8b65"
                },
                body: json.encode({
                  "notification": {
                    "title": NotificationMessage.text.toString(),
                    "message": NotificationBody.text.toString(),
                  },
                  "recipients": [for (var data in clist) data.username]
                }));

        print(notResponse.body);
        print(notResponse.statusCode);

        if (Response.statusCode == 200 || Response.statusCode == 201) {
          NotificationBody.text = "";
          NotificationMessage.text = "";
          update();
          ShowToast(
              title: "Completed",
              body: "Notification has been send succeessfully");
        }
      }
    } else {
      ShowToast(
          title: "Notification Send Failed",
          body: "Course and title are mandatory");
    }
  }

  exportToExcel(String courseName, {bool expired = false}) async {
    final result = await FilePicker.platform.getDirectoryPath();
    String parm = "";
    if (result != null) {
      if (courseName != "") parm = "&course_name=$courseName";
      String param2 = "";
      if (expired) param2 = "show_expired=True";
      final Response = await get(
          Uri.parse(
              endpoint + "users/get-remaning-dates?course=true$parm&$param2"),
          headers: AuthHeader);

      if (Response.statusCode == 200) {
        var data = json.decode(Response.body);

        List<CUserlistModel> clist = [];
        for (var user in data) {
          clist.add(CUserlistModel.fromJson(user));
        }

        saveExcel(clist, result, expired: expired);
      }
    }
  }

  saveExcel(List<CUserlistModel> userlist, String path,
      {bool expired = false}) async {
    var excel = ex.Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Add headers to the worksheet
    sheet.cell(ex.CellIndex.indexByString("A1")).value =
        ex.TextCellValue("User ID");
    sheet.cell(ex.CellIndex.indexByString("B1")).value =
        ex.TextCellValue("Name");
    sheet.cell(ex.CellIndex.indexByString("C1")).value =
        ex.TextCellValue("Email");
    sheet.cell(ex.CellIndex.indexByString("D1")).value =
        ex.TextCellValue("Phone");
    sheet.cell(ex.CellIndex.indexByString("E1")).value =
        ex.TextCellValue("Course Name");
    if (!expired)
      sheet.cell(ex.CellIndex.indexByString("F1")).value =
          ex.TextCellValue("Expiry Date");

    // Add data to the worksheet
    for (int i = 0; i < userlist.length; i++) {
      CUserlistModel data = userlist[i];
      sheet.cell(ex.CellIndex.indexByString("A${i + 2}")).value =
          ex.TextCellValue(data.userId.toString());
      sheet.cell(ex.CellIndex.indexByString("B${i + 2}")).value =
          ex.TextCellValue(data.name ?? " ");
      sheet.cell(ex.CellIndex.indexByString("C${i + 2}")).value =
          ex.TextCellValue(data.username ?? "");
      sheet.cell(ex.CellIndex.indexByString("D${i + 2}")).value =
          ex.TextCellValue(data.phoneNumber ?? "");
      sheet.cell(ex.CellIndex.indexByString("E${i + 2}")).value =
          ex.TextCellValue(data.courseName ?? "");
      if (!expired)
        sheet.cell(ex.CellIndex.indexByString("F${i + 2}")).value =
            ex.TextCellValue(DateFormat('yyyy MM dd').format(DateTime.now()
                .add(Duration(days: data.noOfDaysToExpire ?? 0))));
    }

    // Directory? documentsDirectory = await getDownloadsDirectory();
    // print(documentsDirectory!.path);
// when you are in flutter web then save() downloads the excel file.

// Call function save() to download the file
    // var fileBytes = excel.save();
    // var directory = await getApplicationDocumentsDirectory();
    String filename = DateFormat('yyyy-MM-dd-hh:mm:ss').format(DateTime.now());
    filename = "StudentList_$filename";
    String excelFilePath = "${path}/$filename.xlsx";
    File file = File(excelFilePath);
    await file.writeAsBytes(excel.encode()!);
    print(excel.encode());
    print(file.path);

    ShowToast(title: "Completed", body: "Student List Exported Successfully");

    // FlutterPlatformAlert.showAlert(
    //     windowTitle: "File Exported",
    //     text: "Your exported file is save in ${file.path} ");
  }

  loadProfiles({String search = ""}) async {
    String parm = "";

    if (search.contains("@"))
      parm = "username=${search}";
    else
      parm = "name=${search}";

    print(parm);

    SearchStudentList.clear();
    final Response = await get(
        Uri.parse(endpoint +
            "applicationview/get-all-user-list?$parm&course_id=${getCourseID(courseText.text)}"),
        headers: AuthHeader);
    print(Response.body);
    print(Response.statusCode);
    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      profileDatas = js;
      for (var data in js["results"]) {
        SearchStudentList.add(UserListModel.fromJson(data));
      }
      update();
    }
  }

  loadProfilesMore() async {
    final Response =
        await get(Uri.parse(profileDatas["next"]), headers: AuthHeader);

    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      profileDatas = js;
      for (var data in js["results"]) {
        SearchStudentList.add(UserListModel.fromJson(data));
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
