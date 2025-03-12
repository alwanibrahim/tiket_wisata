class Product {
  final String name;
  final double price;
  final String imageUrl; // Tambahkan gambar

  Product({required this.name, required this.price, required this.imageUrl});

  // List untuk menyimpan tiket yang telah dibayar
  static List<Product> paidOrders = [];

  // Fungsi untuk menambah tiket ke daftar yang sudah dibayar
  static void addPaidOrder(Product order) {
    paidOrders.add(order);
  }
}
