
import 'package:tiket_wisata/models/ayat_mode.dart';
import 'package:html/parser.dart';


class Surat {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final String audio;
    final List<Ayat> ayat; // Pastikan ini ada


  Surat({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audio,
    required this.ayat,

  });

  factory Surat.fromJson(Map<String, dynamic> json) {
    return Surat(
      nomor: json["nomor"]??'',
      nama: json["nama"]??'',
      namaLatin: json["nama_latin"]??'',
      jumlahAyat: json["jumlah_ayat"]??'',
      tempatTurun: json["tempat_turun"]??'',
      arti: json["arti"]??'',
      deskripsi: _removeTag(json["deskripsi"]??''),
      audio: json["audio"]??'',
      ayat: (json["ayat"] as List<dynamic>?)?.map((item)=> Ayat.fromJson(item)).toList()??[]
    );
  }
  static String _removeTag(String htmlText) {
    return parse(htmlText).body?.text ?? '';
  }
}
