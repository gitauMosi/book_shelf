import 'package:dio/dio.dart';

class ApiClient {
  final String baseUrl;
  final String? xRapidapiKey;
  final String? xRapidapiHost;
  final Dio dio;

  ApiClient({
    required this.baseUrl,
    required this.xRapidapiKey,
    required this.xRapidapiHost,
    required this.dio,
  });
  // get
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl$path',
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-rapidapi-key': xRapidapiKey,
            'x-rapidapi-host': xRapidapiHost,
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to GET from $path: $e');
    }
  }
}
