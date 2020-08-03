import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vidder/secret.dart';

class HttpClient {
  Future<String> uploadVideoToCloudinary({@required File file}) async {
    final url = "https://api.cloudinary.com/v1_1/$CloudinaryCloudName/video/upload";
    final Dio dio = Dio();
    final FormData formData = FormData.fromMap({
      "upload_preset": "vidder_default_unsigned",
      "file": file.readAsBytesSync(),
    });
    final response = await dio.post(url, data: formData);
    final json = jsonDecode(response.toString());
    print(json);
    return Future.value(json["secret_url"]);
  }
}