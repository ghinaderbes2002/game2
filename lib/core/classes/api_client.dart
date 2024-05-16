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
      Response<dynamic> response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return ApiResponse(statusCode: response.statusCode!, data: response.data);
    } catch (error) {
      throw Exception('Failed to post data: $error');
    }
  }

  Future<ApiResponse<dynamic>> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response<dynamic> response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return ApiResponse(statusCode: response.statusCode!, data: response.data);
    } catch (error) {
      throw Exception('Failed to get data: $error');
    }
  }

  Future<ApiResponse<dynamic>> deleteData({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response<dynamic> response = await _dio.delete(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return ApiResponse(statusCode: response.statusCode!, data: response.data);
    } catch (error) {
      throw Exception('Failed to delete data: $error');
    }
  }
}






// -----------------     USAGE     ----------------- // 

/*
  ApiClient apiClient = ApiClient();
  try {
    ApiResponse<dynamic> postResponse = await apiClient.postData(
      url: 'https://example.com/api/post',
      data: {'key': 'value'},
      // queryParameters: {'param1': 'value1', 'param2': 'value2'},
      // headers: {'Authorization': 'Bearer YOUR_ACCESS_TOKEN'},
    );
    print('POST Response Status Code: ${postResponse.statusCode}');
    print('POST Response Data: ${postResponse.data}');
  } catch (error) {
    print('Error while making POST request: $error');
  }
*/