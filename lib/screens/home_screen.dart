import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tiket_wisata/api/doa_service.dart';
import 'package:tiket_wisata/api/surat_service.dart';
import 'package:tiket_wisata/models/doa_model.dart';
import 'package:tiket_wisata/models/surat_model.dart';
import 'package:tiket_wisata/screens/ayat_screen.dart';
import 'doa_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiDoa doaApi = ApiDoa();
  final ApiSurat suratApi = ApiSurat();
  List<Doa> tigaDoas = [];
  List<Surat> surats = [];
  List<Surat> filteredSurahs = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final doaData = await doaApi.getDoa();
    final suratData = await suratApi.getSurat();

    doaData.shuffle();
    if (!mounted) return;

    setState(() {
      tigaDoas = doaData.take(3).toList();
      surats = suratData.take(10).toList();
      filteredSurahs = suratData;
    });
  }
  void searchSurah(String query) {
    final results = surats.where((surah) {
      final name = surah.namaLatin.toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredSurahs = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Berpahala"),
        backgroundColor: Colors.green[700],
      ),
      body: surats.isEmpty || tigaDoas.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Doa Harian
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Doa Harian",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 180,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items: tigaDoas.map((doa) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoaScreen(doa: doa),
                            ),
                          );
                        },
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    doa.judul,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    doa.arab,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.right,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis, //...
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // 🔹 Search Bar
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Daftar Surat",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Cari surat...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged:
                          searchSurah, // Jalankan fungsi search saat user mengetik
                    ),
                  ),

                  // 🔹 Daftar Surat
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    itemCount: filteredSurahs.length,
                    itemBuilder: (context, index) {
                      final surat = filteredSurahs[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green[200],
                            child: Text(
                              surat.nomor.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          title: Text(surat.namaLatin,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text("Jumlah Ayat: ${surat.jumlahAyat}"),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailSuratScreen(
                                        nomorSurat: surat.nomor)));
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
