import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:hwait_apps/data/model/request/saver/request_target_model.dart';
import 'package:hwait_apps/data/model/response/response_detail_target_model.dart';
import 'package:hwait_apps/data/model/response/response_riwayat_tabungan_model.dart';
import 'package:hwait_apps/data/model/response/response_target_model.dart';
import 'package:hwait_apps/service/service_http_client.dart';

class TargetRepository {
  final ServiceHttpClient httpClient;

  TargetRepository(this.httpClient);

  Future<List<Target>> getActiveTargets() async {
    final response = await httpClient.get('targets');

    if (response.statusCode == 200) {
      final model = TargetResponseModel.fromJson(response.body);
      return model.data
              ?.where((target) => target.status != 'selesai')
              .toList() ??
          [];
    } else {
      throw Exception('Gagal mengambil data target');
    }
  }

  Future<Either<String, RiwayatTabunganResponseModel>>
  getRiwayatTabungan() async {
    try {
      final response = await httpClient.get('targets/riwayatTabungan');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final riwayatTabungan = RiwayatTabunganResponseModel.fromMap(
          jsonResponse,
        );
        return Right(riwayatTabungan);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occured');
      }
    } catch (e) {
      return Left('An error occured while get all riwayat tabungan');
    }
  }

  Future<ResponseDetailTargetModel> getDetailTarget(int id) async {
    try {
      final response = await httpClient.get('targets/$id/progres');

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      return ResponseDetailTargetModel.fromJson(response.body);
    } catch (e) {
      print('Error detail target: $e');
      throw Exception('Gagal memuat detail target: $e');
    }
  }

  Future<Either<String, Map<String, dynamic>>> addTarget(
    TargetRequestModel data,
  ) async {
    try {
      final response = await httpClient.postMultipartWithToken(
        endPoint: 'targets',
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
      return Left('$e');
    }
  }
}
