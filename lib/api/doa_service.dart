import 'package:dio/dio.dart';
import 'package:tiket_wisata/models/doa_model.dart';

class ApiDoa {
  final Dio _dio = Dio();
  Future<List<Doa>> getDoa() async {
    try {
      final response = await _dio.get("https://open-api.my.id/api/doa");
      List<dynamic> doaJson = response.data;
      return doaJson.map((item) => Doa.fromJson(item)).toList();
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  Future<Doa> getDetailDoa(int x) async {
    try {
      final response = await _dio.get("https://open-api.my.id/api/doa/$x");
      return Doa.fromJson(response.data);
    } catch (e) {
      throw Exception('error : $e');
    }
  }
}
