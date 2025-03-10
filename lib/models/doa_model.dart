class Doa {
  final int id;
  final String judul;
  final String latin;
  final String arab;
  final String terjemah;

  Doa(
      {required this.id,
      required this.judul,
      required this.latin,
      required this.arab,
      required this.terjemah});

  factory Doa.fromJson(Map<String, dynamic> json) {
    return Doa(
        id: json["id"],
        judul: json["judul"],
        latin: json["latin"],
        arab: json["arab"],
        terjemah: json["terjemah"]);
  }
}
