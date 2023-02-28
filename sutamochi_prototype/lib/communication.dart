import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class Communication {
  static const String baseURL = "127.0.0.1:3000";

  Map<String, String> getHeaders() {
    return {
      HttpHeaders.contentTypeHeader: 'application/json'
    };
  }

  Future<dynamic> get(String endpoint, [params]) async {
    final uri = Uri.http(baseURL, endpoint, params);
    Map<String, String> headers = getHeaders();
    dynamic response = await call(() async =>
        http.get(uri, headers: headers));
    return response;
  }

  Future<dynamic> post(String endpoint, [params]) async {
    final uri = Uri.http(baseURL, endpoint, params);
    Map<String, String> headers = getHeaders();
    dynamic response = await call(() async =>
        http.post(uri, body: json.encode(params), headers: headers));
    return response;
  }

  Future<dynamic> put(String endpoint, [params]) async {
    final uri = Uri.http(baseURL, endpoint, params);
    Map<String, String> headers = getHeaders();
    dynamic response = await call(() async =>
        http.put(uri, body: json.encode(params), headers: headers));
    return response;
  }

  Future<dynamic> delete(String endpoint, [params]) async {
    final uri = Uri.http(baseURL, endpoint, params);
    Map<String, String> headers = getHeaders();
    dynamic response = await call(() async =>
        http.delete(uri, body: json.encode(params), headers: headers));
    return response;
  }

  Future<dynamic> call(Function callback) async {
    try {
      final response = await callback() as http.Response;
      checkStatusCode(response.statusCode);
      return json.decode(response.body);
    } on SocketException catch (e) {
      throw Exception('No Internet Connection');
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  void checkStatusCode(int httpStatus) {
    switch (httpStatus) {
      case 200:
      case 201:
        break;
      case 400:
        throw Exception('400 Bad Request');
      case 401:
        throw Exception('401 Unauthorized');
      case 403:
        throw Exception('403 Forbidden');
      case 404:
        throw Exception('404 Not Found');
      case 405:
        throw Exception('405 Method Not Allowed');
      case 500:
        throw Exception('500 Internal Server Error');
      default:
        throw Exception('Http status $httpStatus unknown error.');
    }
  }

}
