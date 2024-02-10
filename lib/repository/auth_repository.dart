import 'dart:convert';
import 'dart:developer';

import 'package:social_media_apps/env/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final Dio dio = Dio();
  Future logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var sessionToken = prefs.getString('session') ?? "";

    FormData fdata = FormData.fromMap({'session_token': sessionToken});
    final response = await dio.post(
      '$baseUrl/Auth/logout.php',
      data: fdata,
    );
    // prefs.remove('session_token');
    prefs.clear();
  }

  Future login({required String username, required String password}) async {
    final formData = FormData.fromMap({'user': username, 'pwd': password});

    final response = await dio.post(
      '$baseUrl/Auth/login.php',
      data: formData,
    );
    log("res $response");
    Map repoResponse = {};
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.data);
      print("DATA: $data");
      if (data['status'] == 'success') {
        repoResponse = data;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('session', data['session_token']);
      } else {
        repoResponse = data;
      }
    }
    return repoResponse;
  }

  Future register({required String name, required String username, required String email, required String password, required String tglLahir}) async {
    final formData = FormData.fromMap({'name': name, 'username': username, 'email': email, 'password': password, 'tgl_lahir': tglLahir});
    final response = await dio.post(
      '$baseUrl/Auth/register.php',
      data: formData,
    );
    log("res $response");
    Map repoResponse = {};
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.data);
      print("DATA: $data");

      repoResponse = data;
    }
    return repoResponse;
  }

  Future checkSession(String sessionToken) async {
    try {
      print('ISI TOKEN: $sessionToken');
      FormData fdata = FormData.fromMap({"session_token": sessionToken});
      Response response = await dio.post(
        '$baseUrl/Auth/session.php',
        data: fdata,
      );
      print("CHECK SESSION: ${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Session failed');
        return null;
      }
    } catch (e) {
      print("ERROR: $e");
      // return false;
    }
  }
}
