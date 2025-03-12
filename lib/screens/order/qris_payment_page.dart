import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tiket_wisata/constants/colors.dart';
import 'package:tiket_wisata/models/product.dart';

class QrisPaymentPage extends StatelessWidget {
  final Product order;

  QrisPaymentPage({required this.order});

  @override
  Widget build(BuildContext context) {
    String qrData = "${order.name}-${order.price}-Qris";

    return Scaffold(
      appBar: AppBar(
        title: Text('Bayar dengan Qris'),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.secondary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(
                "Scan QR Code untuk membayar",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // QR Code
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Product Details
              Text(
                "Detail Pesanan",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Nama Produk: ${order.name}",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Harga: Rp ${order.price.toStringAsFixed(0)}",
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
              SizedBox(height: 30),
              // Finish Button
              ElevatedButton(
                onPressed: () {
                  // Simpan pesanan ke daftar yang sudah dibayar
                  Product.addPaidOrder(order);

                  // Pindah ke halaman tiket yang berisi daftar pesanan yang sudah dibayar
                  Navigator.pushReplacementNamed(context, '/main');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Selesai",
                  style: TextStyle(fontSize: 18,color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
