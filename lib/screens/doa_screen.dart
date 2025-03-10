import 'package:flutter/material.dart';
import 'package:tiket_wisata/api/doa_service.dart';
import 'package:tiket_wisata/models/doa_model.dart';

class DoaScreen extends StatefulWidget {
  final Doa doa;

  const DoaScreen({super.key, required this.doa});

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  final ApiDoa doaApi = ApiDoa();
  List<Doa> doas = [];

  @override
  void initState() {
    super.initState();
    fethData();
  }

  Future<void> fethData() async {
    final doaData = await doaApi.getDoa();

    doas.shuffle();
    if (!mounted) return;

    setState(() {
      doas = doaData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doa.judul),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doa.judul,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              widget.doa.arab,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              widget.doa.latin,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10),
            Text(
              widget.doa.terjemah,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
