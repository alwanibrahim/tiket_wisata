import 'package:flutter/material.dart';
import 'package:tiket_wisata/api/doa_service.dart';
import 'package:tiket_wisata/models/doa_model.dart';

class SemuadoaScreen extends StatefulWidget {
  const SemuadoaScreen({super.key});

  @override
  State<SemuadoaScreen> createState() => _SemuadoaScreenState();
}

class _SemuadoaScreenState extends State<SemuadoaScreen> {
  final ApiDoa doaApi = ApiDoa();
  final TextEditingController searchController = TextEditingController();
  List<Doa> doas = [];
  List<Doa> filteredDoas = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final doaData = await doaApi.getDoa();
    if (!mounted) return;
    setState(() {
      doas = doaData;
      filteredDoas = doaData;
    });
  }

  void searchDoas(String query) {
    final result = doas.where((item) {
      final name = item.judul.toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredDoas = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Cari doa...',
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search),
          ),
          onChanged: searchDoas,
        ),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: filteredDoas.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: filteredDoas.length,
                itemBuilder: (context, index) {
                  final doa = filteredDoas[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doa.judul,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            doa.arab,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            doa.latin,
                            style: const TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            doa.terjemah,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
