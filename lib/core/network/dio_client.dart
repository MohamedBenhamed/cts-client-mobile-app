import 'package:dio/dio.dart';
import 'package:estore_client/core/utils/app_constance.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: AppConstance.baseUrl,
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

  Future<Response> post(String endpoint, {required dynamic data}) async {
    try {
      return await dio.post(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      return await dio.get(path, queryParameters: queryParams);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getById(String path, {dynamic id}) async {
    try {
      final fullPath = id != null ? '$path/$id/' : path;
      return await dio.get(fullPath);
    } catch (e) {
      rethrow;
    }
  }
}
