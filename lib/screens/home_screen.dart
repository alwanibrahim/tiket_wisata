import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async'; // Import untuk Timer
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tiket_wisata/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> surahs = [];
  List<dynamic> duas = [];
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredSurahs = [];
  String selectedEndpoint = 'naik'; // Default endpoint

  @override
  void initState() {
    super.initState();
    fetchSurahs();
    fetchMultipleDuas(); // Ambil doa dari beberapa endpoint

    // Ubah endpoint setiap 10 detik
    Timer.periodic(Duration(seconds: 10), (timer) {
      changeEndpoint(getNextEndpoint());
    });
  }

  Future<void> fetchSurahs() async {
    final response = await http
        .get(Uri.parse('https://quran-api.santrikoding.com/api/surah'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        surahs = (data..shuffle()).take(5).toList();
        filteredSurahs = surahs;
      });
    }
  }

  Future<void> fetchDuas({required String endpoint}) async {
    final response = await http.get(Uri.parse(
        'https://doa-doa-api-ahmadramadhan.fly.dev/api/doa/$endpoint'));
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      if (data is List) {
        setState(() {
          duas = data; // Jika data adalah list, langsung simpan
        });
      } else if (data is Map) {
        setState(() {
          duas = [data]; // Jika data adalah map, ubah ke list
        });
      }
    } else {
      print('Gagal memuat data doa: ${response.statusCode}');
    }
  }

  Future<void> fetchMultipleDuas() async {
    final endpoints = ['naik', 'sebelum', 'sesudah', 'tidur', 'bangun'];
    List<dynamic> allDuas = [];

    for (var endpoint in endpoints) {
      final response = await http.get(Uri.parse(
          'https://doa-doa-api-ahmadramadhan.fly.dev/api/doa/$endpoint'));
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        if (data is Map) {
          allDuas.add(data); // Tambahkan doa ke list
        }
      }
    }

    setState(() {
      duas = allDuas; // Simpan semua doa
    });
  }

  void changeEndpoint(String newEndpoint) {
    setState(() {
      selectedEndpoint = newEndpoint;
      fetchDuas(endpoint: selectedEndpoint); // Fetch data dengan endpoint baru
    });
  }

  String getNextEndpoint() {
    final endpoints = ['naik', 'sebelum', 'sesudah', 'tidur', 'bangun'];
    final currentIndex = endpoints.indexOf(selectedEndpoint);
    final nextIndex = (currentIndex + 1) % endpoints.length;
    return endpoints[nextIndex];
  }

  void filterSurahs(String query) {
    setState(() {
      filteredSurahs = surahs
          .where((surah) => surah['nama']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quranic Guide'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.green[700]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 10,
        shadowColor: Colors.teal.withOpacity(0.5),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Colors.teal),
                  hintText: 'Cari Surah...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
                onChanged: filterSurahs,
              ),
            ),
          ),
          if (duas.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                ),
                items: duas.map((doa) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoaDetailScreen(doa: doa),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.teal[400]!, Colors.green[700]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.teal.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.favorite, color: Colors.white70),
                                SizedBox(height: 10),
                                Text(
                                  doa['doa'] ?? 'Doa Pilihan',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: filteredSurahs.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(20),
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${filteredSurahs[index]['jumlah_ayat']} Ayat',
                        style: TextStyle(
                          color: Colors.teal[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      filteredSurahs[index]['nama'] ?? 'Surah',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    subtitle: Text(
                      filteredSurahs[index]['arti'] ?? 'Arti Surah',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.teal),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SurahDetailScreen(surah: filteredSurahs[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal[100]!, Colors.white],
          ),
        ),
        child: ListView(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal[700]!, Colors.green[700]!],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 50, color: Colors.teal),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Quranic Guide',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.teal),
              title: Text(
                'Profile Pengembang',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DoaDetailScreen extends StatelessWidget {
  final dynamic doa;
  DoaDetailScreen({required this.doa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doa['doa'] ?? 'Detail Doa'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.green[700]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    doa['ayat'] ?? 'بِسْمِ اللهِ',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                      fontFamily: 'Amiri',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 20),
                  Text(
                    doa['latin'] ?? 'Bismillah',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  Text(
                    '"${doa['artinya'] ?? 'Dengan menyebut nama Allah'}"',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Keterangan:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Doa ini merupakan doa sehari-hari yang diajarkan dalam Islam. '
              'Dianjurkan untuk membaca doa ini sebelum memulai aktivitas tertentu.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

class SurahDetailScreen extends StatelessWidget {
  final dynamic surah;
  SurahDetailScreen({required this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surah['nama'] ?? 'Surah'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.green[700]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal[50]!, Colors.white],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 3,
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    surah['nama_latin'] ?? 'Nama Surah',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '(${surah['arti'] ?? 'Arti Surah'})',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Divider(color: Colors.teal.withOpacity(0.3)),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDetailItem('Ayat', surah['jumlah_ayat']),
                      _buildDetailItem('Tempat Turun', surah['tempat_turun']),
                      _buildDetailItem('Urutan', surah['nomor']),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Deskripsi Surah:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            SizedBox(height: 15),
            Text(
              surah['deskripsi'] ?? 'Penjelasan tentang surah ini',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.6,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, dynamic value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.teal[600],
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value?.toString() ?? '-',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
