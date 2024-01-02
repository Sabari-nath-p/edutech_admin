import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Request;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Constants/AppHeaders.dart';
import 'package:mathlab_admin/Constants/Strings.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Constants/inputField.dart';
import 'package:mathlab_admin/Screen/ProfileView/Service/controller.dart';

class MultiStudentCourseAdd extends StatelessWidget {
  MultiStudentCourseAdd({super.key});
  TextEditingController FileController = TextEditingController();
  TextEditingController isExamController = TextEditingController();
  ProfileController pctrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (context) {
      return Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: 800, maxHeight: 550),
          child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 90),
              child: Column(
                children: [
                  tx700("Add Course", size: 24),
                  SizedBox(
                    height: 25,
                  ),
                  TBox("Is Exam", isExamController),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Tfields("FilePath", FileController),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () async {
                            final response =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                            );

                            if (response != null) {
                              FileController.text = response.files.first.path!;
                            }
                          },
                          child: Icon(Icons.file_copy))
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      if (FileController.text.isEmpty) {
                        ShowToast(
                            title: "No File Found",
                            body: 'Please input excel file');
                        return;
                      } else if (pctrl.loading) {
                        return;
                      } else {
                        upLoadFiles();
                      }
                    },
                    child: ButtonContainer(
                      (pctrl.loading)
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 22)
                          : tx600("Add to Profile", color: Colors.white),
                      width: 150,
                      radius: 10,
                    ),
                  ),
                ],
              )),
        ),
      );
    });
  }

  upLoadFiles() async {
    pctrl.loading = true;
    pctrl.update();
    final dio = Request.Dio();
    String url = (isExamController.text == "1")
        ? "applicationview/exam-add-excel/"
        : "applicationview/course-add-excel/";
    Request.FormData formData = Request.FormData.fromMap({
      'file': await Request.MultipartFile.fromFile(FileController.text!,
          filename: FileController.text.split("/").last),
    });

    final response = await dio.post(
        endpoint + url, //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(
            headers: AuthHeader, validateStatus: (stat) => true));
    print(response.data!);
    if (response.statusCode == 200) {
      pctrl.loading = false;
      pctrl.update();
    } else {
      ShowToast(title: "Request Failed", body: response.data);
      pctrl.loading = false;
      pctrl.update();
    }
  }
}
