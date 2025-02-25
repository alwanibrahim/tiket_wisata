import 'package:flutter/material.dart';
import 'package:tiket_wisata/gen/assets.gen.dart'; 

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan ikon dari assets
            Image.asset(Assets.icons.homeIcon.path, width: 100, height: 100),

            SizedBox(height: 20),


            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Aksi tombol
                print("Button ditekan!");
              },
              child: Text("Klik Saya"),
            ),
          ],
        ),
      ),
    );
  }
}
