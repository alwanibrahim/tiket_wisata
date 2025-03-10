import 'package:flutter/material.dart';
import 'package:tiket_wisata/api/surat_service.dart';
import 'package:tiket_wisata/models/surat_model.dart';

class DetailSuratScreen extends StatefulWidget {
  final int nomorSurat;

  const DetailSuratScreen({super.key, required this.nomorSurat});

  @override
  State<DetailSuratScreen> createState() => _DetailSuratScreenState();
}

class _DetailSuratScreenState extends State<DetailSuratScreen> {
  final ApiSurat suratApi = ApiSurat();
  Surat? surat;

  @override
  void initState() {
    super.initState();
    fetchDetailSurat();
  }

  Future<void> fetchDetailSurat() async {
    try {
      final suratDetail = await suratApi.getDetailSurat(widget.nomorSurat);
      if (!mounted) return;

      setState(() {
        surat = suratDetail;
      });
    } catch (e) {
      print("Error fetching detail: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Detail Surat"), backgroundColor: Colors.green[700]),
      body: surat == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surat!.namaLatin,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "(${surat!.nama}) - ${surat!.arti}",
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Jumlah Ayat: ${surat!.jumlahAyat}, Diturunkan di ${surat!.tempatTurun}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            surat!.deskripsi,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          if (surat!.audio.isNotEmpty)
                            ElevatedButton(
                              onPressed: () {
                                // Implementasi pemutar audio
                              },
                              child: Text("Dengarkan Audio"),
                            ),
                          SizedBox(height: 20),
                          Text(
                            "Ayat-ayat:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: surat!.ayat.length,
                            itemBuilder: (context, index) {
                              final ayat = surat!.ayat[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Card(
                                  elevation: 3,
                                  child: ListTile(
                                    title: Text(
                                      ayat.ar,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5),
                                        Text(
                                          ayat.tr,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        SizedBox(height: 5),
                                        Text(ayat.idn,
                                            style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
