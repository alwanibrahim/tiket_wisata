import 'package:dio/dio.dart';
import 'package:tiket_wisata/models/surat_model.dart';

class ApiSurat {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: 'https://quran-api.santrikoding.com/api/surah',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10)));

  Future<List<Surat>> getSurat() async {
    try {
      final response = await _dio.get('');
      List<dynamic> suratJson = response.data;
      return suratJson.map((item) => Surat.fromJson(item)).toList();
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  Future<Surat> getDetailSurat(int x) async {
    try {
      final response = await _dio.get("/$x");
      if (response.statusCode == 200) {
        return Surat.fromJson(response.data);
      } else {
        throw Exception("Dio error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('error : $e');
    }
  }
}
