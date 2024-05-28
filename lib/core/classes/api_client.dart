import 'package:dio/dio.dart';

class ApiResponse<T> {
  final int statusCode;
  final T data;

  ApiResponse({required this.statusCode, required this.data});
}

class ApiClient {
  final Dio _dio = Dio();

  Future<ApiResponse<dynamic>> postData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      print("Attempting to post data to $url");
      var response = await _dio.post(url,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      print("Data posted successfully with status code ${response.statusCode}");
      return ApiResponse(statusCode: response.statusCode!, data: response.data);
    } catch (error, stacktrace) {
      print("Failed to post data: $error");
      print("Stacktrace: $stacktrace");
      throw DioError(
        requestOptions: RequestOptions(path: url),
        error: 'Failed to post data: $error',
      );
    }
  }

  Future<ApiResponse<dynamic>> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      print("Attempting to post data to $url");
      var response = await _dio.get(url,
          queryParameters: queryParameters, options: Options(headers: headers));
      print("Data posted successfully with status code ${response.statusCode}");
      return ApiResponse(statusCode: response.statusCode!, data: response.data);
    } catch (error, stacktrace) {
      print("Failed to post data: $error");
      print("Stacktrace: $stacktrace");
      throw DioError(
        requestOptions: RequestOptions(path: url),
        error: 'Failed to post data: $error',
      );
    }
  }

  Future<ApiResponse<dynamic>> deleteData({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      print("Attempting to delete data at $url");
      Response<dynamic> response = await _dio.delete(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      print(
          "Data deleted successfully with status code ${response.statusCode}");
      return ApiResponse(statusCode: response.statusCode!, data: response.data);
    } catch (error, stacktrace) {
      print("Failed to delete data: $error");
      print("Stacktrace: $stacktrace");
      throw DioError(
        requestOptions: RequestOptions(path: url),
        error: 'Failed to delete data: $error',
      );
    }
  }

  Future<ApiResponse<dynamic>> putData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      print("Attempting to put data to $url");
      Response<dynamic> response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      print("Data put successfully with status code ${response.statusCode}");
      return ApiResponse(statusCode: response.statusCode!, data: response.data);
    } catch (error, stacktrace) {
      print("Failed to put data: $error");
      print("Stacktrace: $stacktrace");
      throw DioError(
        requestOptions: RequestOptions(path: url),
        error: 'Failed to put data: $error',
      );
    }
  }
}




