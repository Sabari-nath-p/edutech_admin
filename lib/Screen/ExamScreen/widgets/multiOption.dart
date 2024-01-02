import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mathlab_admin/Constants/AppColor.dart';
import 'package:mathlab_admin/Constants/AppHeaders.dart';
import 'package:mathlab_admin/Constants/Strings.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/ExamScreen/widgets/AddOption.dart';
import 'package:tex_text/tex_text.dart';

import '../Service/controller.dart';

class MultiSelectOption extends StatelessWidget {
  MultiSelectOption({super.key});

  ExamController Ectrl = Get.put(ExamController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            height(10),
            Expanded(child: tx700("Multi Select Option", size: 24)),
            InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => Container(
                          alignment: Alignment.center, child: AddOption()));
                },
                child: Icon(Icons.add)),
            width(10),
          ],
        ),
        for (var data in Ectrl.multiSelectModel!.options!)
          Container(
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  color: primaryColor,
                  width: 30,
                  child: Text(
                    (Ectrl.multiSelectModel!.options!.indexOf(data) + 1)
                        .toString(),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                ),
                if (data.optionsText != null)
                  Container(
                    width: 380,
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //: BoxConstraints(: 140, maxWidth: 240),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black38)),
                    child: Row(
                      children: [
                        Expanded(
                          child: TexText(
                            data.optionsText!,
                            // maxLines: null,
                            // controller: controller,
                            // decoration: InputDecoration(
                            //     border: InputBorder.none,
                            //     isDense: true,
                            //     hintText: title,
                            //     isCollapsed: true),
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ),
                        if (data.isAnswer!) Icon(Icons.verified)
                      ],
                    ),
                  ),
                width(10),
                if (data.optionsImage != null)
                  SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.network(
                        data.optionsImage!,
                        fit: BoxFit.fill,
                      )),
                Expanded(child: Container()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => Container(
                                alignment: Alignment.center,
                                child: AddOption(
                                  option: data,
                                )));
                      },
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: primaryColor,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final Response = await delete(
                            Uri.parse(endpoint +
                                "/exam/addexam/${Ectrl.examID}/multiselect/${Ectrl.multiSelectModel!.msqId}/options/${data.optionId!}/"),
                            headers: AuthHeader);
                        print(Response.body);
                        print(Response.statusCode);

                        if (Response.statusCode == 200 ||
                            Response.statusCode == 204) {
                          Ectrl.loadmSQ();
                        }
                      },
                      child: Icon(
                        Icons.delete,
                        size: 20,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
                width(20)
              ],
            ),
          ),
        height(60)
      ],
    );
  }
}
