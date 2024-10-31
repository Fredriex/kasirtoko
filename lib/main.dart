import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'barang/addbarang.dart';
import 'barang/editbarang.dart';
import 'barang/viewbarang.dart';
import 'modelbarang/Barang.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasir TOKO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Barang> _barangList = <Barang>[];
  var response;

  Future<void> bacabarang() async {
    try {
      final response = await http.get(Uri.parse('http://172.16.58.237/android/membaca.php'));
      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(response.body);
        if (jsonResult['data'] != null) {
          final List<dynamic> hasil = jsonResult['data'];
          hasil.forEach((barang) {
            log('Fetched barang: $barang'); // Log fetched barang
            var x = Barang(
              barang['kode'] ?? '',
              barang['nama'] ?? '',
              barang['satuan'] ?? '',
              int.tryParse(barang['hargabeli'].toString()) ?? 0, // Ensure parsing as a string
              int.tryParse(barang['hargajual'].toString()) ?? 0, // Ensure parsing as a string
            );
            setState(() {
              _barangList.add(x);
            });
          });
          log('Loaded ${_barangList.length} barang items');
        } else {
          log('No data found in the response');
        }
      } else {
        log('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching data: $e');
    }
  }


  @override
  void initState() {
    bacabarang();
    super.initState();
  }

  Future<void> deleteBarang(String kode) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('http://172.16.57.40/android/hapus.php'));
      request.fields.addAll({'kode': kode, 'save': 'ok'});
      http.StreamedResponse response = await request.send();
      log('Delete response: ${await response.stream.bytesToString()}');
      await bacabarang();
    } catch (e) {
      log('Error deleting data: $e');
    }
  }

  void _deleteFormDialog(BuildContext context, String kode) {
    showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title: const Text(
            'Kamu Yakin Menghapus',
            style: TextStyle(color: Colors.teal, fontSize: 20),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                await deleteBarang(kode);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("KASIR TOKO"),
      ),
      body: ListView.builder(
        itemCount: _barangList.length,
        itemBuilder: (context, index) {
          final barang = _barangList[index];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  viewbarang(barang: barang),
                  ),
                ).then((data) {
                  if (data != null) {
                    bacabarang();
                  }
                });
              },
              leading: const Icon(Icons.shopping_cart, color: Colors.purple),
              title: Text(_barangList[index].kode.toString() ?? ''),
              subtitle: Text(_barangList[index].nama ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      /*
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              editbarang( barang:_barangList[index],))).then((data)
                      {
                        if (data != null) {
                          bacabarang();
                        }
                      });
                      */
                    },
                    icon: const Icon(Icons.edit, color: Colors.teal),
                  ),
                  IconButton(
                    onPressed: () {
                      _deleteFormDialog(context, _barangList[index].kode.toString());
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addbarang()),
          ).then((data) {
            if (data != null) {
              bacabarang();
            }
          });
        },
        tooltip: 'Increment',
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
