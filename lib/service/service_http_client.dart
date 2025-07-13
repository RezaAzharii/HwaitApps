import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ServiceHttpClient {
  final String baseUrl = 'http://192.168.1.7:8000/api/';
  final secureStorage = FlutterSecureStorage();

  Future<http.Response> post(String endPoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endPoint");
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception("POST request failed; $e");
    }
  }

  Future<http.Response> postWithToken(
    String endPoint,
    Map<String, dynamic> body,
  ) async {
    final token = await secureStorage.read(key: 'authToken');
    final url = Uri.parse("$baseUrl$endPoint");
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception("POST request failed; $e");
    }
  }

  Future<http.StreamedResponse> postMultipartWithToken({
    required String endPoint,
    required Map<String, String> fields,
    File? file,
    String fileField = 'image_path',
  }) async {
    final token = await secureStorage.read(key: 'authToken');
    final uri = Uri.parse('$baseUrl$endPoint');

    var request =
        http.MultipartRequest('POST', uri)
          ..headers.addAll({
            'Accept': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          })
          ..fields.addAll(fields);

    if (file != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          fileField,
          file.path,
          filename: basename(file.path),
        ),
      );
    }

    return request.send();
  }

  Future<http.Response> get(String endPoint) async {
    final token = await secureStorage.read(key: 'authToken');
    final url = Uri.parse("$baseUrl$endPoint");
    try {
      final response = await http.get(
        url,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception("GET request failed; $e");
    }
  }

  Future<http.Response> putWithToken(
    String endPoint,
    Map<String, dynamic> body,
  ) async {
    final token = await secureStorage.read(key: 'authToken');
    final url = Uri.parse("$baseUrl$endPoint");
    try {
      final response = await http.put(
        url,
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception("PUT request failed: $e");
    }
  }

  Future<http.Response> deleteWithToken(String endPoint) async {
    final token = await secureStorage.read(key: 'authToken');
    final url = Uri.parse("$baseUrl$endPoint");
    try {
      final response = await http.delete(
        url,
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      throw Exception("DELETE request failed: $e");
    }
  }
}
