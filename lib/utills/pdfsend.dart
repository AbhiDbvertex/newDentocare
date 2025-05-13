import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dentocoreauth/utils/app_constant.dart';

import 'Utills.dart';

class PDFsend {
  final util=Utills();

   Future<String> uploadPDF(String uid) async {
     util.startLoading();

    var dio = Dio();

    FilePickerResult? filepick = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (filepick != null) {
      File file = new File(filepick!.files.first.path ?? "");

      String fileName = file.path.split('/').last;

      String filePath = file.path;

      FormData formData = FormData.fromMap({
        'x-api-key': "dentist@123",
        "image": await MultipartFile.fromFile(filePath, filename: fileName),
        "sender_id": "${uid}",
        "receiver_id": "1"
      });

      var data = await MultipartFile.fromFile(filePath, filename: fileName);
      debugPrint("pdftest" + data.toString());
      var response = await dio.post(
        AppConstant.BASE_URL + "/api/chatpdf",
        onSendProgress: (int sent, int total) {
          debugPrint("pdftest" + "$sent $total");
        },
        data: formData,
      );

      if(response!=null){
        util.showFailProcess();
        var result=jsonDecode(response.toString());
        final res=result['status'];
        if(res==true){
          final res=result['message'];
          util.showSnackBar("Alert", "${res}", true);
        }
        debugPrint("pdftest" + response.toString());
        return res ;
      }

      else{
        util.showFailProcess();
        util.showSnackBar("Alert", "Failed to upload!", false);
        return "failed";
      }



    } else {
      util.showFailProcess();
      debugPrint("pdftest" + "null");
      Utills().showSnackBar("Alert", "Failed to upload!", false);
      return "falied" ;
    }
  }
}
