import 'package:html/parser.dart';

class Ayat {
  final int id;
  final int surah;
  final int nomor;
  final String ar;
  final String tr;
  final String idn;

  Ayat({
    required this.id,
    required this.surah,
    required this.nomor,
    required this.ar,
    required this.tr,
    required this.idn,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      id: json['id']??'',
      surah: json['surah']??'',
      nomor: json['nomor']??'',
      ar: json['ar']??'',
      tr: _removeTag(json['tr']??''),
      idn: _removeTag(json['idn']??''),
    );

  }
    static String _removeTag(String htmlText) {
    return parse(htmlText).body?.text ?? '';
  }
}

