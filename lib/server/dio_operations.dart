import 'dart:developer';

import 'package:dio/dio.dart';

class DioOperations {
  static Future<dynamic> getRequest(String requestUrl) async {
    try {
      final dio = Dio();
      final Response<Map<String, dynamic>> response;

      response = await dio.get<Map<String, dynamic>>(
        requestUrl,
      );
      if (response.statusCode == 200) {
        log(response.data.toString());
        return response.data;
      } else {
        return null;
      }
    } on DioException catch (e) {
      print(e);
    }
  }
}
