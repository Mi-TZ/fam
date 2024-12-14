import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio();

  static Dio getInstance() {
    return _dio;
  }
}