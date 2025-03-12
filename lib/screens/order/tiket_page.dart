import 'package:flutter/material.dart';
import 'package:tiket_wisata/models/product.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Tiket'),
          content: Text('Apakah Anda yakin ingin menghapus tiket ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Product.paidOrders.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tiket Saya')),
      body: Product.paidOrders.isEmpty
          ? Center(child: Text('Belum ada tiket yang dibeli'))
          : ListView.builder(
              itemCount: Product.paidOrders.length,
              itemBuilder: (context, index) {
                final order = Product.paidOrders[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(
                      order.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(order.name),
                    subtitle: Text('Rp ${order.price.toStringAsFixed(0)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _showDeleteDialog(context, index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
