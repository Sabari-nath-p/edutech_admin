import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathlab_admin/Constants/AppColor.dart';
import 'package:mathlab_admin/Constants/TexRender.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tex_text/tex_text.dart';

import 'functionsupporter.dart';

TBox(String title, TextEditingController controller) {
  return StatefulBuilder(builder: (context, stage) {
    return Row(
      children: [
        Container(width: 240, child: tx500(title, size: 18)),
        tx500(":"),
        width(10),
        Checkbox(
            value: (controller.text == "1") ? true : false,
            onChanged: (value) {
              stage(() {
                if (controller.text == "1")
                  controller.text = "";
                else
                  controller.text = "1";
              });
            })
      ],
    );
  });
}

Tfields(
  String title,
  TextEditingController controller,
) {
  return Container(
    child: Row(
      children: [
        Container(width: 240, child: tx500(title, size: 18)),
        tx500(":"),
        width(10),
        Container(
          width: 300,
          //: BoxConstraints(: 140, maxWidth: 240),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black38)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: title,
                isCollapsed: true),
          ),
        )
      ],
    ),
  );
}

AField(
  String title,
  TextEditingController controller,
) {
  return StatefulBuilder(builder: (context, st) {
    return Container(
      child: Row(
        children: [
          Container(width: 240, child: tx500(title, size: 18)),
          tx500(":"),
          width(10),
          Container(
              width: 300,
              //: BoxConstraints(: 140, maxWidth: 240),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      st(() {
                        controller.text = "2";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.black38),
                          color:
                              (controller.text == "2") ? primaryColor : null),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      child: Text("FREE",
                          style: TextStyle(
                              color: (controller.text == "2")
                                  ? Colors.white
                                  : null)),
                    ),
                  ),
                  width(10),
                  InkWell(
                    onTap: () {
                      st(() {
                        controller.text = "1";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.black38),
                          color:
                              (controller.text == "1") ? primaryColor : null),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      child: Text(
                        "PAID",
                        style: TextStyle(
                            color:
                                (controller.text == "1") ? Colors.white : null),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  });
}

ETfields(
  String title,
  TextEditingController controller,
) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(width: 240, child: tx500(title, size: 18)),
        tx500(":"),
        width(10),
        Container(
          width: 400,
          height: 200,
          //: BoxConstraints(: 140, maxWidth: 240),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black38)),
          child: TextField(
            maxLines: null,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: title,
                isCollapsed: true),
          ),
        ),
      ],
    ),
  );
}

ETLfields(String title, TextEditingController controller) {
  return Container(
    child: StatefulBuilder(builder: (context, state) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(width: 240, child: tx500(title, size: 18)),
          tx500(":"),
          width(10),
          Container(
            width: 380,
            height: 200,
            //: BoxConstraints(: 140, maxWidth: 240),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black38)),
            child: TexText(controller.text
                // maxLines: null,
                // controller: controller,
                // decoration: InputDecoration(
                //     border: InputBorder.none,
                //     isDense: true,
                //     hintText: title,
                //     isCollapsed: true),
                ),
          ),
          width(10),
          InkWell(
              onTap: () {
                ValueNotifier updater = ValueNotifier(10);

                updater.addListener(
                  () {
                    state(() {});
                  },
                );
                showDialog(
                    context: context,
                    builder: (context) => Container(
                        alignment: Alignment.center,
                        child: TextRender(
                          notifier: updater,
                          controller: controller,
                        )));
              },
              child: Icon(Icons.add)),
          width(10),
        ],
      );
    }),
  );
}

fieldImage(String title, TextEditingController file) {
  String backyup = file.text;
  bool isselected = false;
  print(file.text);
  return StatefulBuilder(builder: (context, state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 240, child: tx500(title, size: 18)),
        tx500(":"),
        width(10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                final response =
                    await FilePicker.platform.pickFiles(allowMultiple: false);
                if (response != null) {
                  if (kIsWeb) {
                    file.text = String.fromCharCodes(
                        response.files.single.bytes as Iterable<int>);
                    //   print(response.files.single.bytes);
                    isselected = true;
                    state(() {});
                  } else {
                    //File Ttile = File(response.files.single.path.toString());

                    // Uint8List byte = ;
                    file.text = response.files.single.path.toString();
                    isselected = true;
                    state(() {});
                  }
                  // file = temp;

                  //response.files.single];

                  //setState(() {});
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black26),
                child: tx500("Choose Image", color: Colors.white, size: 14),
              ),
            ),
            height(8),
            if (file.text != "")
              Container(
                  width: 200,
                  height: 200,
                  child: (!file.text.contains("https"))
                      ? (kIsWeb)
                          ? Image.memory(
                              Uint8List.fromList(file.text.codeUnits),
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(file.text),
                              fit: BoxFit.cover,
                            )
                      : Image.network(
                          (file.text),
                          fit: BoxFit.cover,
                        ))
          ],
        ),
        width(10),
        if (isselected)
          InkWell(
              onTap: () {
                state(() {
                  isselected = false;
                  file.text = backyup;
                });
              },
              child: Icon(Icons.close))
      ],
    );
  });
}

FieldPdf(String title, TextEditingController file) {
  String backyup = file.text;
  bool isselected = false;
  print(file.text);
  return StatefulBuilder(builder: (context, state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 240, child: tx500(title, size: 18)),
        tx500(":"),
        width(10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                final response = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                );
                if (response != null) {
                  if (kIsWeb) {
                    file.text = String.fromCharCodes(
                        response.files.single.bytes as Iterable<int>);
                    //   print(response.files.single.bytes);
                    isselected = true;
                    state(() {});
                  } else {
                    //File Ttile = File(response.files.single.path.toString());

                    // Uint8List byte = ;
                    file.text = response.files.single.path.toString();
                    isselected = true;
                    state(() {});
                  }
                  // file = temp;

                  //response.files.single];

                  //setState(() {});
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black26),
                child: tx500("Choose Pdf", color: Colors.white, size: 14),
              ),
            ),
            height(8),
            if (file.text != "")
              Container(
                  width: 300,
                  height: 400,
                  child: (!file.text.contains("https"))
                      ? (kIsWeb)
                          ? SfPdfViewer.memory(
                              Uint8List.fromList(file.text.codeUnits),
                            )
                          : SfPdfViewer.file(
                              File(file.text),
                            )
                      : SfPdfViewer.network(
                          file.text,
                        ))
          ],
        ),
        width(10),
        if (isselected)
          InkWell(
              onTap: () {
                state(() {
                  isselected = false;
                  file.text = backyup;
                });
              },
              child: Icon(Icons.close))
      ],
    );
  });
}
