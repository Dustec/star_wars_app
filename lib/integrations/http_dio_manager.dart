import 'dart:_http';

import '../core/domain/managers/http_manager.dart';

class HttpDioManager implements HttpManager {
  @override
  Future<HttpResponse> delete(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse> post(
    String url, {
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse> put(
    String url, {
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
