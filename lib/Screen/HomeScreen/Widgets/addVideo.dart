import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/VideoModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/subjectModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';

import '../../../Constants/functionsupporter.dart';
import '../../../Constants/inputField.dart';

class AddVideo extends StatefulWidget {
  var Vdata;
  AddVideo({super.key, this.Vdata = 1});

  @override
  State<AddVideo> createState() => _AddVideoState(Vdata: Vdata);
}

class _AddVideoState extends State<AddVideo> {
  var Vdata;
  _AddVideoState({required this.Vdata});

  TextEditingController VideoID = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController isActive = TextEditingController();
  TextEditingController accessType = TextEditingController();
  TextEditingController createdData = TextEditingController();

  HomeController ctrl = Get.put(HomeController());
  late VideoModel md;
  @override
  void initState() {
    // TODO: implement initState
    createdData.text = DateTime.now().toString();
    if (Vdata != 1) {
      md = VideoModel.fromJson(Vdata);
      VideoID.text = md.videoId!;
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
                        tx700("Add Video", size: 24),
                        height(10),
                        Tfields("Video Title", title),
                        height(10),
                        Tfields("Video ID", VideoID),
                        height(10),
                        ETfields("Video Description", description),
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
                          VideoID.text.isNotEmpty &&
                          accessType.text.isNotEmpty &&
                          createdData.text.isNotEmpty) {
                        setState(() {
                          ctrl.CourseUploading = true;
                        });
                        if (Vdata == 1)
                          AddVideoData();
                        else
                          EditVideoData();
                      } else {}
                    },
                    child: ButtonContainer(
                      (ctrl.CourseUploading)
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 22)
                          : tx600((Vdata != 1) ? "Update Video" : "Add Video",
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

    VideoModel model = VideoModel();
    model.module = ctrl.SelectedModuleModel.modulesId;
    model.accessType = int.parse(accessType.text.toString()).toInt();
    model.videoId = VideoID.text;
    model.description = description.text;
    model.title = title.text;
    model.isActive = true;
    model.createdDate =
        formatter.format(DateTime.parse(createdData.text).toLocal());
    model.updatedDate = model.createdDate;
    print(model.createdDate);
    ctrl.AddVideo(model, context);
  }

  EditVideoData() {
    final DateFormat formatter = DateFormat('y-MM-ddThh:mm:ss');

    VideoModel model = VideoModel();
    model.videoUniqueId = md.videoUniqueId;
    model.module = ctrl.SelectedModuleModel.modulesId;
    model.accessType = int.parse(accessType.text.toString()).toInt();
    model.videoId = VideoID.text;
    model.description = description.text;
    model.title = title.text;
    model.isActive = (md.isActive == "1");
    model.createdDate =
        formatter.format(DateTime.parse(createdData.text).toLocal());
    model.updatedDate = model.createdDate;
    print(model.createdDate);
    ctrl.UpdateVideo(model, context);
  }
}
