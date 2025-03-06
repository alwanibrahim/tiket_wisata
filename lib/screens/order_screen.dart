import 'package:flutter/material.dart';
import '../models/product.dart';

class OrderPage extends StatelessWidget {
  final List<Product> products = [
    Product(
        name: "Laptop Gaming",
        price: 15000000,
        imageUrl:
            "https://www.asus.com/media/Odin/Websites/global/ProductLine/20200824120814.jpg"),
    Product(
        name: "Smartphone",
        price: 5000000,
        imageUrl:
            "https://www.asus.com/media/Odin/Websites/global/ProductLine/20200824120814.jpg"),
    Product(
        name: "Smartwatch",
        price: 2000000,
        imageUrl:
            "https://www.asus.com/media/Odin/Websites/global/ProductLine/20200824120814.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Page")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(product.imageUrl,
                  width: 50, height: 50, fit: BoxFit.cover),
              title: Text(product.name),
              subtitle: Text("Rp ${product.price.toStringAsFixed(0)}"),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailPage(order: product),
                    ),
                  );
                },
                child: Text("Order"),
              ),
            ),
          );
        },
      ),
    );
  }
}

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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pembayaran dengan $method berhasil')),
                );
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
      appBar: AppBar(title: Text('Detail Order')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Produk: ${order.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Harga: Rp ${order.price.toStringAsFixed(0)}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _showPaymentDialog(context, 'Qris'),
                  child: Text('Bayar dengan Qris'),
                ),
                ElevatedButton(
                  onPressed: () => _showPaymentDialog(context, 'Tunai'),
                  child: Text('Bayar dengan Tunai'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}