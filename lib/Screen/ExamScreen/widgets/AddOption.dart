import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Constants/AppHeaders.dart';
import 'package:mathlab_admin/Constants/Strings.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Constants/inputField.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/controller.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/models/multiSelectModel.dart';
import 'package:dio/dio.dart' as Request;

class AddOption extends StatefulWidget {
  Options? option;
  AddOption({super.key, this.option});

  @override
  State<AddOption> createState() => _AddOptionState();
}

class _AddOptionState extends State<AddOption> {
  bool loading = false;

  TextEditingController optionNo = TextEditingController();

  TextEditingController optionText = TextEditingController();

  TextEditingController OptionImage = TextEditingController();

  TextEditingController isAnswer = TextEditingController();
  ExamController Ectrl = Get.put(ExamController());

  @override
  void initState() {
    // TODO: implement initState
    if (widget.option != null) {
      optionNo.text = widget.option!.optionNo.toString();
      optionText.text = widget.option!.optionsText.toString();
      if (widget.option!.optionsImage != null)
        OptionImage.text = widget.option!.optionsImage.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: 900, maxHeight: 600),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 90),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Tfields("Option No", optionNo),
                        height(10),
                        ETLfields(
                          "Option Text",
                          optionText,
                        ),
                        height(10),
                        fieldImage("Option Image", OptionImage),
                        height(10),
                        TBox("Is Answer", isAnswer),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (optionNo.text.isNotEmpty &&
                          (optionText.text.isNotEmpty ||
                              OptionImage.text.isNotEmpty)) {
                        setState(() {
                          loading = true;
                        });
                        if (widget.option == null)
                          AddOptionRequest();
                        else
                          UpdateOptionRequest();
                      }
                    },
                    child: ButtonContainer(
                      (loading)
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 22)
                          : tx600(
                              (widget.option != null)
                                  ? "Update Option"
                                  : "Add Option",
                              color: Colors.white),
                      width: 150,
                      radius: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  AddOptionRequest() async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "options_text": optionText.text,
      "option_no": optionNo.text,
      "question": Ectrl.multiSelectModel!.msqId,
      "is_active": isAnswer.text == "1",
      if (OptionImage.text != "")
        'options_image': await Request.MultipartFile.fromFile(OptionImage.text,
            filename: OptionImage.text.split("/").last),
    });

    final response = await dio.post(
        endpoint +
            "/exam/addexam/${Ectrl.examID}/multiselect/${Ectrl.multiSelectModel!.msqId}/options/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(
          headers: AuthHeader,
          validateStatus: (status) => true,
        ));
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Ectrl.loadmSQ();

      Navigator.pop(context);
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  UpdateOptionRequest() async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "options_text": optionText.text,
      "option_no": optionNo.text,
      "question": Ectrl.multiSelectModel!.msqId,
      "is_active": isAnswer.text == "1",
      if (OptionImage.text != "" &&
          OptionImage.text != widget.option!.optionsImage)
        'options_image': await Request.MultipartFile.fromFile(OptionImage.text,
            filename: OptionImage.text.split("/").last),
    });

    final response = await dio.patch(
        endpoint +
            "/exam/addexam/${Ectrl.examID}/multiselect/${Ectrl.multiSelectModel!.msqId}/options/${widget.option!.optionId!}/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(
          headers: AuthHeader,
          validateStatus: (status) => true,
        ));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Ectrl.loadmSQ();

      Navigator.pop(context);
    } else {
      setState(() {
        loading = false;
      });
    }
  }
}
