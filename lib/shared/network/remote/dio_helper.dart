import 'package:dio/dio.dart';
import 'package:souq/shared/constants/constants.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

// ////////////////////////////////////////////
  static Future<Response<dynamic>> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    required String token,
    // Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio.get(url, queryParameters: query);
    // print(data.toString());
  }

// ///////////////////////////////////////////////////
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token != null? token : ''
      // 'Authorization': token
    };
    return await dio.post(url, data: data);
    // print(data.toString());
  }
// ///////////////////////////////////////////////////
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token != null? token : ''
      // 'Authorization': token
    };
    return await dio.put(url, data: data);
    // print(data.toString());
  }
// ///////////////////////////////////////////////////

}
