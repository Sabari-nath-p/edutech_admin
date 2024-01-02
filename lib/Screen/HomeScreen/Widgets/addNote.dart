import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/NoteModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/VideoModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/subjectModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';

import '../../../Constants/functionsupporter.dart';
import '../../../Constants/inputField.dart';

class AddNote extends StatefulWidget {
  var Vdata;
  AddNote({super.key, this.Vdata = 1});

  @override
  State<AddNote> createState() => _AddNoteState(Vdata: Vdata);
}

class _AddNoteState extends State<AddNote> {
  var Vdata;
  _AddNoteState({required this.Vdata});

  TextEditingController pdfLink = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController isActive = TextEditingController();
  TextEditingController accessType = TextEditingController();
  TextEditingController createdData = TextEditingController();

  HomeController ctrl = Get.put(HomeController());
  late NoteModel md;
  @override
  void initState() {
    // TODO: implement initState
    createdData.text = DateTime.now().toString();
    if (ctrl.SelectedDate != null) {
      createdData.text = ctrl.SelectedDate!.toString();
    }
    if (Vdata != 1) {
      md = NoteModel.fromJson(Vdata);
      pdfLink.text = md.pdf!;
      title.text = md.title!;
      description.text = md.description!;
      accessType.text = md.accessType.toString();
      createdData.text = md.createdDate!;

      isActive.text = (Vdata["is_active"]) ? "1" : "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: 800, maxHeight: 700),
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
                        tx700("Add Note", size: 24),
                        height(10),
                        Tfields("Note Title", title),
                        height(10),
                        FieldPdf("Note PDF", pdfLink),
                        height(10),
                        ETfields("Note Description", description),
                        height(10),
                        Tfields("Order Postion", createdData),
                        AField("Access Type", accessType),
                        height(10),
                        if (Vdata != 1) TBox("Visibility", isActive),
                        if (Vdata != 1) height(10),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (title.text.isNotEmpty &&
                          pdfLink.text.isNotEmpty &&
                          accessType.text.isNotEmpty &&
                          createdData.text.isNotEmpty) {
                        setState(() {
                          ctrl.CourseUploading = true;
                        });
                        print(isActive.text);
                        // d return;
                        if (Vdata == 1)
                          AddVideoData();
                        else
                          EditVideoData();
                      } else {
                        ShowToast(
                            title: "Input Field are missing",
                            body: "Please fill the field to continue");
                      }
                    },
                    child: ButtonContainer(
                      (ctrl.CourseUploading)
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 22)
                          : tx600((Vdata != 1) ? "Update Note" : "Add Note",
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

  AddVideoData() {
    final DateFormat formatter = DateFormat('y-MM-ddThh:mm:ss');

    NoteModel model = NoteModel();
    model.module = ctrl.SelectedModuleModel.modulesId;
    model.accessType = int.parse(accessType.text.toString()).toInt();
    model.pdf = pdfLink.text;
    model.description = description.text;
    model.title = title.text;
    model.isActive = true;
    model.createdDate =
        formatter.format(DateTime.parse(createdData.text).toLocal());
    model.updatedDate = model.createdDate;
    print(model.createdDate);
    ctrl.AddNote(model, context);
  }

  EditVideoData() {
    final DateFormat formatter = DateFormat('y-MM-ddThh:mm:ss');

    NoteModel model = NoteModel();
    model.notesId = md.notesId;
    model.module = ctrl.SelectedModuleModel.modulesId;
    model.accessType = int.parse(accessType.text.toString()).toInt();
    model.pdf = pdfLink.text;
    model.description = description.text;
    model.title = title.text;
    model.isActive = isActive.text == "1" ? true : false;
    model.createdDate =
        formatter.format(DateTime.parse(createdData.text).toLocal());
    model.updatedDate = model.createdDate;
    print(model.createdDate);
    ctrl.UpdateNote(model, context, (pdfLink.text != md.pdf));
  }
}
