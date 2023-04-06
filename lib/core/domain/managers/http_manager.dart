import 'dart:io';

abstract class HttpManager {
  Future<HttpResponse> get(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> post(
    String url, {
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> put(
    String url, {
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> delete(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  });
}
