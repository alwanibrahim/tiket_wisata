import 'package:flutter/material.dart';
import 'package:tiket_wisata/constants/colors.dart';
import 'package:tiket_wisata/models/product.dart';
import 'package:tiket_wisata/screens/order/qris_payment_page.dart';

class OrderDetailPage extends StatelessWidget {
  final Product order;

  OrderDetailPage({required this.order});

  void _showPaymentDialog(BuildContext context, String method) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembayaran'),
          content: Text('Apakah Anda ingin membayar dengan $method?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (method == 'Qris') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QrisPaymentPage(order: order),
                    ),
                  );
                } else if (method == 'Tunai') {
                  Product.addPaidOrder(order); // Menambah tiket ke daftar paidOrders
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tiket berhasil dibeli!')),
                  );
                  Navigator.pushReplacementNamed(context, '/main');
                }
              },
              child: Text('Bayar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Order'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  order.imageUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Nama Produk: ${order.name}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Harga: Rp ${order.price.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _showPaymentDialog(context, 'Qris'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Bayar dengan Qris', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () => _showPaymentDialog(context, 'Tunai'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 5, 143, 129),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Bayar dengan Tunai', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
