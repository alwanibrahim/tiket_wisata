import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:tiket_wisata/screens/login_screen.dart';

final pages = [
  const PageData(
    icon: Icons.menu_book, // Ikon buku untuk Al-Quran
    title: "Baca Al-Quran",
    bgColor: Color(0xff2E7D32), // Warna hijau yang tenang
    textColor: Colors.white,
  ),
  const PageData(
    icon: Icons.search, // Ikon pencarian untuk mencari ayat
    title: "Cari Ayat",
    bgColor: Color(0xff1565C0), // Warna biru yang menenangkan
    textColor: Colors.white,
  ),
  const PageData(
    icon: Icons.audiotrack, // Ikon audio untuk mendengarkan Al-Quran
    title: "Dengarkan Murattal",
    bgColor: Color(0xff6A1B9A), // Warna ungu yang elegan
    textColor: Colors.white,
  ),
];

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.1,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Icon(
            Icons.navigate_next,
            size: screenWidth * 0.08,
            color: Colors.white,
          ),
        ),
        itemCount: pages.length,
        itemBuilder: (index) {
          final page = pages[index];
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Page(page: page),
                if (index == pages.length - 1) // Tombol muncul di halaman terakhir
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Mulai",
                        style: TextStyle(
                          color: page.bgColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PageData {
  final String? title;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;

  const PageData({
    this.title,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [page.bgColor, page.bgColor.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            page.icon,
            size: screenHeight * 0.1,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        Text(
          page.title ?? "",
          style: TextStyle(
            color: page.textColor,
            fontSize: screenHeight * 0.035,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins', // Gunakan font kustom
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
