import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hwait_apps/data/model/request/saver/request_setoran_model.dart';
import 'package:hwait_apps/data/model/response/response_setoran_model.dart';
import 'package:hwait_apps/service/service_http_client.dart';

class SetoranRepository {
  final ServiceHttpClient httpClient;

  SetoranRepository({required this.httpClient});

  Future<Either<String, Data>> submitSetoran(
    RequestSetoranModel requestModel,
  ) async {
    try {
      print('DATA DIKIRIM: ${requestModel.toMap()}');
      final response = await httpClient.postWithToken(
        'progres',
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        final progres = Data.fromMap(jsonResponse['data']);
        return Right(progres);
      } else {
        return Left(jsonResponse['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left('Gagal mengirim setoran: $e');
    }
  }
}
