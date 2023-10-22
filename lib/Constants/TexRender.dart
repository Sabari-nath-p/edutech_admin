import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tex_text/tex_text.dart';

import 'functionsupporter.dart';

class TextRender extends StatefulWidget {
  ValueNotifier notifier;
  TextEditingController controller;
  TextRender({super.key, required this.notifier, required this.controller});

  @override
  State<TextRender> createState() => _TextRenderState();
}

class _TextRenderState extends State<TextRender> {
  
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: 600, maxHeight: 700),
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
                        Container(
                          width: 580,
                          height: 200,
                          //: BoxConstraints(: 140, maxWidth: 240),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.black38)),
                          child: TexText(widget.controller.text
                              // maxLines: null,
                              // controller: controller,
                              // decoration: InputDecoration(
                              //     border: InputBorder.none,
                              //     isDense: true,
                              //     hintText: title,
                              //     isCollapsed: true),
                              ),
                        ),
                        height(20),
                        Container(
                          width: 580,
                          height: 200,
                          //: BoxConstraints(: 140, maxWidth: 240),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.black38)),
                          child: TextField(
                            maxLines: null,
                            controller: widget.controller,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                hintText: "Input latex",
                                isCollapsed: true),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      widget.notifier.value++;
                      Navigator.of(context).pop();
                    },
                    child: ButtonContainer(
                      tx600("Save", color: Colors.white),
                      width: 150,
                      radius: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
    ;
  }
}
