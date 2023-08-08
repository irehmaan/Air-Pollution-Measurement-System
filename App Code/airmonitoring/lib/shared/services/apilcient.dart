import 'package:dio/dio.dart';

class ApiClient {
  Dio dio = Dio();

  Future<Response<T>> get<T>(String url) {
    return dio.get<T>(url);
  }

  post(data, url) {}
}
