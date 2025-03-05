import 'package:flutter/material.dart';
import '../models/product.dart';

class OrderPage extends StatelessWidget {
  final List<Product> products = [
    Product(name: "Laptop Gaming", price: 15000000, imageUrl: "https://www.asus.com/media/Odin/Websites/global/ProductLine/20200824120814.jpg"),
    Product(name: "Smartphone", price: 5000000, imageUrl: "https://www.asus.com/media/Odin/Websites/global/ProductLine/20200824120814.jpg"),
    Product(name: "Smartwatch", price: 2000000, imageUrl: "https://www.asus.com/media/Odin/Websites/global/ProductLine/20200824120814.jpg"),
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
              leading: Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(product.name),
              subtitle: Text("Rp ${product.price.toStringAsFixed(0)}"),
              trailing: ElevatedButton(
                onPressed: () {},
                child: Text("Order"),
              ),
            ),
          );
        },
      ),
    );
  }
}
