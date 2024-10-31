import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../modelbarang/Barang.dart';

class viewbarang extends StatefulWidget {
  final Barang barang;
  const viewbarang({Key? key, required this.barang}) : super(key: key);

  @override
  State<viewbarang> createState() => _ViewBarangState();
}

class _ViewBarangState extends State<viewbarang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('View Barang'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Detail Barang",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text('Kode',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(widget.barang.kode.toString(), style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text('Nama',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(widget.barang.nama.toString(), style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text('Satuan',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(widget.barang.satuan.toString(), style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text('Harga Beli',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(widget.barang.hargabeli.toString(), style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text('Harga Jual',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(widget.barang.hargajual.toString(), style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
