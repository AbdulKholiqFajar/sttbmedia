import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:social_media_apps/env/env.dart';

class PostRepository {
  final Dio dio = Dio();
  Future getPost() async {
    final response = await dio.get('$baseUrl/DataInformasi/getInformasi.php');
    log("res $response");
    var responses;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.data);
      print("DATA: $data");
      responses = data;
    }
    return responses;
  }

  Future addPost({required String caption, required File image, required String createdAt}) async {
    final formData = FormData.fromMap({'caption': caption, 'image': await MultipartFile.fromFile(image.path), 'created_at': createdAt});
    final response = await dio.post('$baseUrl/DataInformasi/addInformasi.php', data: formData);
    log("res $response");
    Map repoResponse = {};
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.data);
      print("DATA: $data");
      repoResponse = data;
    }
    return repoResponse;
  }
}
