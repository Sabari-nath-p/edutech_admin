import 'dart:convert';

import 'package:dio/dio.dart' as Request;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mathlab_admin/Constants/AppHeaders.dart';
import 'package:mathlab_admin/Constants/Strings.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/ExamModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/ModulesModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/NoteModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/VideoModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/contentModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/courseModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/subjectModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/addExam.dart';
import 'package:quickalert/quickalert.dart';

class HomeController extends GetxController {
  int CurrentMenu = 0;
  bool CourseUploading = false;
  String SelectedCourse = "";
  String SelectedSubject = "";
  String SelectedModule = "";
  String SelectedCotent = "";
  DateTime? SelectedDate;
  late CourseModel SelectedCourseModel;
  late SubjectModel SelectedSubjectModel;
  late ModuleModel SelectedModuleModel;
  late contentModel SelectedContentModel;
  List<CourseModel> CourseList = [];
  List<SubjectModel> SubjectList = [];
  List<ModuleModel> ModuleList = [];
  List<contentModel> ContentList = [];

  SetCourse(String id, {var cs = false}) {
    SelectedCourse = id;
    SubjectList = [];
    if (cs != false) {
      SelectedCourseModel = cs;
      update();
      loadSubject();
    }
    update();
  }

  SetSubject(String id, {var cs = false}) {
    SelectedSubject = id;

    update();
    if (cs != false) {
      SelectedSubjectModel = cs;
      update();
      loadModule();
    }
    update();
  }

  SetModule(String id, {var cs = false}) {
    SelectedModule = id;

    update();
    if (cs != false) {
      SelectedModuleModel = cs;
      update();
      loadContent();
    }
    update();
  }

  SetContent(String id, {var cs = false}) {
    SelectedCotent = id;

    update();
    if (cs != false) {
      SelectedContentModel = cs;
      update();
      // loadContent();
    }
    update();
  }

  loadContent() async {
    ContentList = [];
    final response = await http.get(
        Uri.parse(endpoint +
            "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/$SelectedModule/videos/"),
        headers: AuthHeader);
    print(response.body);
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      for (var data in res) {
        VideoModel model = VideoModel.fromJson(data);
        contentModel Cmodel = contentModel(
          model.videoUniqueId,
          model.title,
          "VIDEO",
          model.createdDate,
          model,
          null,
          null,
          model.isActive,
        );
        ContentList.add(Cmodel);
      }
      update();
    }

    final res = await http.get(
        Uri.parse(endpoint +
            "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/$SelectedModule/notes/"),
        headers: AuthHeader);
    print(res.body);
    if (res.statusCode == 200) {
      var res1 = json.decode(res.body);
      for (var data in res1) {
        NoteModel model = NoteModel.fromJson(data);
        contentModel Cmodel = contentModel(
          model.notesId,
          model.title,
          "NOTE",
          model.createdDate,
          null,
          model,
          null,
          model.isActive,
        );
        ContentList.add(Cmodel);
      }
      update();
    }
    final eres = await http.get(
        Uri.parse(endpoint +
            "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/$SelectedModule/exams/"),
        headers: AuthHeader);

    if (eres.statusCode == 200) {
      var res2 = json.decode(eres.body);
      for (var data in res2) {
        ExamModel model = ExamModel.fromJson(data);
        contentModel Cmodel = contentModel(
          model.examUniqueId,
          model.examName,
          "EXAM",
          model.createdDate,
          null,
          null,
          model,
          model.isActive,
        );
        ContentList.add(Cmodel);
      }
      update();
    }

    ContentList.sort((a, b) => a.created_date!.compareTo(b.created_date!));
    update();
  }

  loadModule() async {
    ModuleList = [];
    //update();
    final response = await http.get(
        Uri.parse(endpoint +
            "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/"),
        headers: AuthHeader);
    print(response.body);
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      for (var data in res) {
        ModuleModel model = ModuleModel.fromJson(data);
        ModuleList.add(model);
      }
      update();
    }
  }

  AddVideo(VideoModel videoModel, BuildContext context) async {
    final dio = Request.Dio();
    print(json.encode(videoModel.toJson()));
    Request.FormData formData = Request.FormData.fromMap(videoModel.toJson());

    final response = await dio.post(
        endpoint +
            "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/$SelectedModule/videos/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(
          headers: AuthHeader,
          validateStatus: (status) {
            return (status!.toInt() < 500);
          },
        ));
    print(response.data);

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ShowToast(
          title: "Video Added",
          body:
              "Video is added succefully in module ${SelectedModuleModel.moduleName}");
      CourseUploading = false;
      ContentList = [];
      loadContent();

      Navigator.of(context).pop();
    } else {
      ShowToast(title: "Error occurred", body: "Something went to wrong");
      CourseUploading = false;
      update();
    }
  }

  UpdateVideo(VideoModel videoModel, BuildContext context) async {
    final dio = Request.Dio();
    print(json.encode(videoModel.toJson(update: false)));
    Request.FormData formData = Request.FormData.fromMap(videoModel.toJson());

    final response = await dio.patch(
        endpoint +
            "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/$SelectedModule/videos/${videoModel.videoUniqueId}", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(
          headers: AuthHeader,
          validateStatus: (status) {
            return (status!.toInt() < 500);
          },
        ));
    print(response.data);

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ShowToast(
          title: "Video Updated",
          body:
              "Video is Updated succefully in module ${SelectedModuleModel.moduleName}");
      CourseUploading = false;
      ContentList = [];
      loadContent();

      Navigator.of(context).pop();
    } else {
      ShowToast(title: "Error occurred", body: "Something went to wrong");
      CourseUploading = false;
      update();
    }
  }

  DeleteVideo(String videoId, BuildContext context) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Are you sure want to delete",
        text:
            "Do you really want to delete your video? You can't undo this action",
        onConfirmBtnTap: () async {
          final response = await http.delete(
              Uri.parse(endpoint +
                  "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/$SelectedModule/videos/$videoId"),
              headers: AuthHeader);
          print(response.body);
          print(response.statusCode);

          if (response.statusCode == 204) {
            ShowToast(title: "Successful", body: "video deleted succefully");
            ContentList = [];
            loadContent();
            Navigator.of(context).pop();
          } else {
            ShowToast(title: "Error occurred", body: "Something went to wrong");
          }
        });
  }

  AddNote(NoteModel noteModel, BuildContext context) async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "module": noteModel.module,
      "access_type": noteModel.accessType,
      "title": noteModel.title,
      "description": noteModel.description,
      // "pdf": "https://mathlabtech.com/media/pdfs/S8_LinearTransformation_Material.pdf",
      "created_date": noteModel.updatedDate,
      "updated_date": noteModel.createdDate,

      "is_active": noteModel.isActive,

      if (noteModel.pdf != "")
        'pdf': await Request.MultipartFile.fromFile(noteModel.pdf!,
            filename: noteModel.pdf!.split("/").last),
    });

    final response = await dio.post(
        endpoint +
            "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/$SelectedModule/notes/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(headers: AuthHeader));
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      NoteModel md = NoteModel.fromJson(response.data);

      ShowToast(
          title: "Note Added",
          body:
              "${md.title} is added succefully with module  ${SelectedModuleModel.moduleName}");
      CourseUploading = false;
      ContentList = [];
      loadContent();

      Navigator.of(context).pop();
    } else {
      ShowToast(title: "Error occurred", body: "Something went to wrong");
      CourseUploading = false;
      update();
    }
  }

  UpdateNote(NoteModel noteModel, BuildContext context, bool isEdited) async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "module": noteModel.module,
      "access_type": noteModel.accessType,
      "title": noteModel.title,
      "description": noteModel.description,
      // "pdf": "https://mathlabtech.com/media/pdfs/S8_LinearTransformation_Material.pdf",
      // "created_date": noteModel.updatedDate,
      // "updated_date": noteModel.createdDate,

      "is_active": noteModel.isActive,

      if (noteModel.pdf != "" && isEdited)
        'pdf': await Request.MultipartFile.fromFile(noteModel.pdf!,
            filename: noteModel.pdf!.split("/").last),
    });

    final response = await dio.patch(
        endpoint +
            "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/$SelectedModule/notes/${noteModel.notesId}", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(headers: AuthHeader));
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      NoteModel md = NoteModel.fromJson(response.data);

      ShowToast(
          title: "Note Updated",
          body:
              "${md.title} is updated succefully with module  ${SelectedModuleModel.moduleName}");
      CourseUploading = false;
      ContentList = [];
      loadContent();

      Navigator.of(context).pop();
    } else {
      ShowToast(title: "Error occurred", body: "Something went to wrong");
      CourseUploading = false;
      update();
    }
  }

  DeleteNote(String noteID, BuildContext context) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Are you sure want to delete",
        text:
            "Do you really want to delete your note? You can't undo this action",
        onConfirmBtnTap: () async {
          final response = await http.delete(
              Uri.parse(endpoint +
                  "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/$SelectedModule/notes/$noteID"),
              headers: AuthHeader);
          print(response.body);
          print(response.statusCode);

          if (response.statusCode == 204) {
            ShowToast(title: "Successful", body: "Note deleted succefully");
            ContentList = [];
            loadContent();
            Navigator.of(context).pop();
          } else {
            ShowToast(title: "Error occurred", body: "Something went to wrong");
          }
        });
  }

  AddExam(ExamModel videoModel, BuildContext context) async {
    final dio = Request.Dio();
    print(json.encode(videoModel.toJson()));
    Request.FormData formData = Request.FormData.fromMap(videoModel.toJson());

    final response = await dio.post(
        endpoint +
            "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/$SelectedModule/exams/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(
          headers: AuthHeader,
          validateStatus: (status) {
            return (status!.toInt() < 500);
          },
        ));
    print(response.data);

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ShowToast(
          title: "Exam Added",
          body:
              "Exam is added succefully in module ${SelectedModuleModel.moduleName}");
      CourseUploading = false;
      ContentList = [];
      loadContent();

      Navigator.of(context).pop();
    } else {
      ShowToast(title: "Error occurred", body: "Something went to wrong");
      CourseUploading = false;
      update();
    }
  }

  UpdateExam(ExamModel videoModel, BuildContext context) async {
    final dio = Request.Dio();
    print(json.encode(videoModel.toJson()));
    Request.FormData formData = Request.FormData.fromMap(videoModel.toJson());

    final response = await dio.patch(
        endpoint +
            "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/$SelectedModule/exams/${videoModel.examUniqueId}", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(
          headers: AuthHeader,
          validateStatus: (status) {
            return (status!.toInt() < 500);
          },
        ));
    print(response.data);

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ShowToast(
          title: "Exam Updated",
          body:
              "Exam is updated succefully in module ${SelectedModuleModel.moduleName}");
      CourseUploading = false;
      ContentList = [];
      loadContent();

      Navigator.of(context).pop();
    } else {
      ShowToast(title: "Error occurred", body: "Something went to wrong");
      CourseUploading = false;
      update();
    }
  }

  DeleteExam(String ExamID, BuildContext context) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Are you sure want to delete",
        text:
            "Do you really want to delete your Exam? You can't undo this action",
        onConfirmBtnTap: () async {
          final response = await http.delete(
              Uri.parse(endpoint +
                  "users/fieldofstudy/${SelectedCourse}/subjects/${SelectedSubject}/modules/$SelectedModule/exams/$ExamID"),
              headers: AuthHeader);
          print(response.body);
          print(response.statusCode);

          if (response.statusCode == 204) {
            ShowToast(title: "Successful", body: "Exam deleted succefully");
            ContentList = [];
            loadContent();
            Navigator.of(context).pop();
          } else {
            ShowToast(title: "Error occurred", body: "Something went to wrong");
          }
        });
  }

  AddModule(ModuleModel moduleModel, BuildContext context) async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      //  "course_image": "https://mathlabtech.com/media/images/PG_ENTRANCE_EXAM_course_image.jpeg",
      // "cover_image": "https://mathlabtech.com/media/images/1000_F_310275872_2nIcdXv7L61QbLeM8969ARTQWPtxvm5o.jpg",
      "subjects": moduleModel.subjects,
      "is_active": moduleModel.isActive,
      "module_name": moduleModel.moduleName,
      "notes": [],
      "videos": [],
      "created_date": DateTime.now().toString(),
      "updated_date": DateTime.now().toString(),
      "exams": []
    });

    final response = await dio.post(
        endpoint +
            "users/fieldofstudy/$SelectedCourse/subjects/$SelectedSubject/modules/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(headers: AuthHeader));
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ModuleModel md = ModuleModel.fromJson(response.data);

      ShowToast(
          title: "Module Added",
          body:
              "${md.moduleName} is added succefully with module id ${md.modulesId}");
      CourseUploading = false;
      ModuleList = [];
      loadModule();

      Navigator.of(context).pop();
    } else {
      ShowToast(title: "Error occurred", body: "Something went to wrong");
      CourseUploading = false;
      update();
    }
  }

  UpdateModule(ModuleModel moduleModel, BuildContext context) async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      //  "course_image": "https://mathlabtech.com/media/images/PG_ENTRANCE_EXAM_course_image.jpeg",
      // "cover_image": "https://mathlabtech.com/media/images/1000_F_310275872_2nIcdXv7L61QbLeM8969ARTQWPtxvm5o.jpg",
      "subjects": moduleModel.subjects,
      "is_active": moduleModel.isActive,
      "module_name": moduleModel.moduleName,
    });

    final response = await dio.patch(
        endpoint +
            "users/fieldofstudy/$SelectedCourse/subjects/$SelectedSubject/modules/${moduleModel.modulesId}/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(headers: AuthHeader));
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ModuleModel md = ModuleModel.fromJson(response.data);

      ShowToast(
          title: "Module Updated",
          body:
              "${md.moduleName} is updated succefully with module id ${md.modulesId}");
      CourseUploading = false;
      ModuleList = [];
      loadModule();

      Navigator.of(context).pop();
    } else {
      ShowToast(title: "Error occurred", body: "Something went to wrong");
      CourseUploading = false;
      update();
    }
  }

  DeleteModule(String ModuleId, BuildContext context) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Are you sure want to delete",
        text:
            "Do you really want to delete your Module? You can't undo this action",
        onConfirmBtnTap: () async {
          final response = await http.delete(
              Uri.parse(endpoint +
                  "users/fieldofstudy/$SelectedCourse/subjects/$SelectedSubject/modules/$ModuleId/"),
              headers: AuthHeader);

          if (response.statusCode == 204) {
            ShowToast(title: "Successful", body: "Module deleted succefully");
            ModuleList = [];
            loadModule();
            Navigator.of(context).pop();
          } else {
            ShowToast(title: "Error occurred", body: "Something went to wrong");
          }
        });
  }

  loadSubject() async {
    SubjectList = [];
    update();
    final response = await http.get(
        Uri.parse(endpoint + "users/fieldofstudy/$SelectedCourse/subjects/"),
        headers: AuthHeader);

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      for (var data in res) {
        SubjectModel model = SubjectModel.fromJson(data);
        SubjectList.add(model);
      }
      update();
    }
  }

  AddSubject(SubjectModel subjectModel, BuildContext context) async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "field_of_study": SelectedCourse,
      //  "course_image": "https://mathlabtech.com/media/images/PG_ENTRANCE_EXAM_course_image.jpeg",
      // "cover_image": "https://mathlabtech.com/media/images/1000_F_310275872_2nIcdXv7L61QbLeM8969ARTQWPtxvm5o.jpg",
      "subjects": subjectModel.subjects,
      "is_active": subjectModel.isActive,
      "modules": [],

      if (subjectModel.subjectImage != "")
        'subject_image': await Request.MultipartFile.fromFile(
            subjectModel.subjectImage!,
            filename: subjectModel.subjectImage!.split("/").last),
    });

    final response = await dio.post(
        endpoint +
            "users/fieldofstudy/$SelectedCourse/subjects/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(headers: AuthHeader));
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      SubjectModel md = SubjectModel.fromJson(response.data);

      ShowToast(
          title: "Subject Added",
          body:
              "${md.subjects} is added succefully with subject id ${md.subjectId}");
      CourseUploading = false;
      SubjectList = [];
      loadSubject();

      Navigator.of(context).pop();
    } else {
      ShowToast(title: "Error occurred", body: "Something went to wrong");
      CourseUploading = false;
      update();
    }
  }

  UpdateSubject(
      SubjectModel subjectModel, bool isEdited, BuildContext context) async {
    final dio = Request.Dio();
    print(json.encode(subjectModel.toJson()));
    Request.FormData formData = Request.FormData.fromMap({
      //  "course_image": "https://mathlabtech.com/media/images/PG_ENTRANCE_EXAM_course_image.jpeg",
      // "cover_image": "https://mathlabtech.com/media/images/1000_F_310275872_2nIcdXv7L61QbLeM8969ARTQWPtxvm5o.jpg",
      "subjects": subjectModel.subjects,
      "is_active": subjectModel.isActive,

      if (subjectModel.subjectImage != "" && isEdited)
        'subject_image': await Request.MultipartFile.fromFile(
            subjectModel.subjectImage!,
            filename: subjectModel.subjectImage!.split("/").last),
    });

    final response = await dio.patch(
        endpoint +
            "users/fieldofstudy/$SelectedCourse/subjects/${subjectModel.subjectId}/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(headers: AuthHeader));
    print(response.data);
    print(response.statusMessage);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      SubjectModel md = SubjectModel.fromJson(response.data);

      ShowToast(
          title: "Subject Updated",
          body: "${md.subjects} is Updated succefully ");
      CourseUploading = false;
      SubjectList = [];
      loadSubject();

      Navigator.of(context).pop();
    } else {
      ShowToast(title: "Error occurred", body: "Something went to wrong");
      CourseUploading = false;
      update();
    }
  }

  DeleteSubject(String SubjectId, BuildContext context) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Are you sure want to delete",
        text:
            "Do you really want to delete your subject? You can't undo this action",
        onConfirmBtnTap: () async {
          final response = await http.delete(
              Uri.parse(endpoint +
                  "users/fieldofstudy/$SelectedCourse/subjects/$SubjectId/"),
              headers: AuthHeader);
          print(response.body);
          print(response.statusCode);

          if (response.statusCode == 204) {
            ShowToast(title: "Successful", body: "Subject deleted succefully");
            SubjectList = [];
            loadSubject();
            Navigator.of(context).pop();
          } else {
            ShowToast(title: "Error occurred", body: "Something went to wrong");
          }
        });
  }

  loadCourse() async {
    CourseList = [];
    update();
    final response = await http.get(Uri.parse(endpoint + "users/fieldofstudy/"),
        headers: AuthHeader);

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      for (var data in res) {
        CourseModel model = CourseModel.fromJson(data);
        CourseList.add(model);
      }
      update();
    }
  }

  AddCourse(CourseModel Cmodel, BuildContext context) async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "field_of_study": Cmodel.fieldOfStudy,
      //  "course_image": "https://mathlabtech.com/media/images/PG_ENTRANCE_EXAM_course_image.jpeg",
      // "cover_image": "https://mathlabtech.com/media/images/1000_F_310275872_2nIcdXv7L61QbLeM8969ARTQWPtxvm5o.jpg",
      "price": Cmodel.price,
      "Course_description": Cmodel.courseDescription,
      "user_benefit": Cmodel.userBenefit,
      "only_paid": Cmodel.onlyPaid,
      "subjects": [],
      "is_active": false,

      if (Cmodel.courseImage != "")
        'course_image': await Request.MultipartFile.fromFile(
            Cmodel.courseImage!,
            filename: Cmodel.courseImage!.split("/").last),
      if (Cmodel.coverImage != "")
        'cover_image': await Request.MultipartFile.fromFile(Cmodel.coverImage!,
            filename: Cmodel.coverImage!.split("/").last),
    });

    final response = await dio.post(endpoint + "users/fieldofstudy/",
        data: formData, options: Request.Options(headers: AuthHeader));

    if (response.statusCode == 200 || response.statusCode == 201) {
      CourseModel md = CourseModel.fromJson(response.data);

      ShowToast(
          title: "Course created",
          body:
              "${Cmodel.fieldOfStudy} is created succefully with course id ${md.courseUniqueId}");
      CourseUploading = false;
      CourseList = [];
      loadCourse();

      Navigator.of(context).pop();
    } else {
      CourseUploading = false;
      update();
      ShowToast(title: "Error occurred", body: "Something went to wrong");
    }
  }

  DeleteCourse(String courseUniqueId, BuildContext context) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Are you sure want to delete",
        text:
            "Do you really want to delete your course? You can't undo this action",
        onConfirmBtnTap: () async {
          final response = await http.delete(
              Uri.parse(endpoint + "users/fieldofstudy/$courseUniqueId/"),
              headers: AuthHeader);
          print(response.body);
          print(response.statusCode);

          if (response.statusCode == 204) {
            ShowToast(title: "Successful", body: "Course deleted succefully");
            CourseList = [];
            loadCourse();
            Navigator.of(context).pop();
          } else {
            ShowToast(title: "Error occurred", body: "Something went to wrong");
          }
        });
  }

  updateCourse(
      CourseModel Cmodel, CourseModel Pmodel, BuildContext context) async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "field_of_study": Cmodel.fieldOfStudy,
      //  "course_image": "https://mathlabtech.com/media/images/PG_ENTRANCE_EXAM_course_image.jpeg",
      // "cover_image": "https://mathlabtech.com/media/images/1000_F_310275872_2nIcdXv7L61QbLeM8969ARTQWPtxvm5o.jpg",
      "price": Cmodel.price,
      "Course_description": Cmodel.courseDescription,
      "user_benefit": Cmodel.userBenefit,
      "only_paid": Cmodel.onlyPaid,

      "is_active": Cmodel.isActive,

      if (Cmodel.courseImage != "" && Cmodel.courseImage != Pmodel.courseImage)
        'course_image': await Request.MultipartFile.fromFile(
            Cmodel.courseImage!,
            filename: Cmodel.courseImage!.split("/").last),
      if (Cmodel.coverImage != "" && Cmodel.coverImage != Pmodel.coverImage)
        'cover_image': await Request.MultipartFile.fromFile(Cmodel.coverImage!,
            filename: Cmodel.coverImage!.split("/").last),
    });

    final response = await dio.put(
        endpoint + "users/fieldofstudy/${Pmodel.courseUniqueId}/",
        data: formData,
        options: Request.Options(headers: AuthHeader));

    if (response.statusCode == 200 || response.statusCode == 201) {
      CourseModel md = CourseModel.fromJson(response.data);

      ShowToast(
          title: "Course Updated",
          body:
              "${Cmodel.fieldOfStudy} is updated succefully with course id ${md.courseUniqueId}");
      CourseUploading = false;
      CourseList = [];
      loadCourse();

      Navigator.of(context).pop();
    } else {
      CourseUploading = false;
      update();
      ShowToast(title: "Error occurred", body: "Something went to wrong");
    }
  }
}
