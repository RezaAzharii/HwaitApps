import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hwait_apps/data/model/request/admin/recommendation_request_model.dart';
import 'package:hwait_apps/data/model/response/recommendation_response_model.dart';
import 'package:hwait_apps/service/service_http_client.dart';
import 'package:http/http.dart' as http;

class RecommendationRepository {
  final ServiceHttpClient httpClient;
  RecommendationRepository(this.httpClient);

  Future<Either<String, RecommendationResponseModel>>
  getAllRecommendation() async {
    try {
      final response = await httpClient.get("recommendations");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final recommendationResponse = RecommendationResponseModel.fromMap(
          jsonResponse,
        );
        return Right(recommendationResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occured');
      }
    } catch (e) {
      return Left('An error occured while get all recommendation: $e');
    }
  }

  Future<Either<String, Recom>> getRecommendation(int id) async {
    try {
      final response = await httpClient.get("recommendations/$id");
      print('RESPONSE BODY: ${response.body}');
      print('STATUS CODE: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final datum = Recom.fromMap(jsonResponse['data']);
        return Right(datum);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left('An error occurred: $e');
    }
  }

  Future<Either<String, Map<String, dynamic>>> addRecommendation(
    RecommendationRequestModel data,
  ) async {
    try {
      final response = await httpClient.postMultipartWithToken(
        endPoint: 'recommendations',
        fields: data.toFields(),
        file: data.imageFile,
      );

      final res = await http.Response.fromStream(response);

      if (res.statusCode == 201) {
        return Right(jsonDecode(res.body));
      } else {
        final error = jsonDecode(res.body);
        return Left(error['message'] ?? 'Gagal menambahkan rekomendasi');
      }
    } catch (e) {
      return Left('Terjadi kesalahan: $e');
    }
  }

  Future<Either<String, String>> deleteRecommendation(int id) async {
    try {
      final response = await httpClient.deleteWithToken('recommendations/$id');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Right(data['message'] ?? 'Berhasil dihapus');
      } else {
        final data = jsonDecode(response.body);
        return Left(data['message'] ?? 'Gagal menghapus rekomendasi');
      }
    } catch (e) {
      return const Left('Terjadi kesalahan saat menghapus data');
    }
  }

  Future<Either<String, Unit>> updateRecommendation(
    int id,
    Map<String, dynamic> updatedData,
  ) async {
    try {
      final response = await httpClient.putWithToken(
        'recommendations/$id',
        updatedData,
      );
      if (response.statusCode == 200) {
        return right(unit);
      } else {
        final body = jsonDecode(response.body);
        return left(body['message'] ?? 'Gagal memperbarui');
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
