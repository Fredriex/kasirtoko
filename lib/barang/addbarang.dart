import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class addbarang extends StatefulWidget {
  @override
  State<addbarang> createState() => _AddBarangState();
}

class _AddBarangState extends State<addbarang>{

  var _kodeController = TextEditingController();
  var _namaController = TextEditingController();
  var _satuanController = TextEditingController();
  var _hargabeliController = TextEditingController();
  var _hargajualController = TextEditingController();
  bool _validateKode = false;
  bool _validateNama = false;
  bool _validateSatuan = false;
  bool _validatehargabeli = false;
  bool _validatehargajual = false;
  String result = '';

  @override
  void dispose() {
    _kodeController.dispose();
    _namaController.dispose();
    _satuanController.dispose();
    _hargabeliController.dispose();
    _hargajualController.dispose();
    super.dispose();
  }

  Future<void> _postData() async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse('http://172.16.58.237/android/simpan.php'));
      request.fields.addAll({
        'kode': _kodeController.text,
        'nama': _namaController.text,
        'satuan': _satuanController.text,
        'hargabeli': _hargabeliController.text,
        'hargajual': _hargajualController.text,
        'save': 'ok'
      });
      http.StreamedResponse response = await request.send();
      log(jsonDecode(response.toString()));
      if (response.statusCode == 201) {
// Successful POST request, handle the response here
        final responseData = jsonDecode(response.toString());
      } else {
// If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Add Barang'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Barang',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _kodeController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Kode',
                    labelText: 'Kode',
                    errorText:
                    _validateKode ? 'Kode Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Nama',
                    labelText: 'Nama',
                    errorText:
                    _validateNama ? 'Nama Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _satuanController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Satuan',
                    labelText: 'Satuan',
                    errorText:
                    _validateSatuan ? 'Satuan Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _hargabeliController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Harga Beli',
                    labelText: 'Harga Beli',
                    errorText:
                    _validatehargabeli ? 'Harga Beli Value Can\'t Be Empty' :
                    null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _hargajualController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Harga Jual',
                    labelText: 'Harga Jual',
                    errorText:
                    _validatehargajual ? 'Harga Jual Value Can\'t Be Empty' :
                    null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _kodeController.text.isEmpty
                              ? _validateNama = true
                              : _validateNama = false;
                          _namaController.text.isEmpty
                              ? _validateSatuan = true
                              : _validateSatuan = false;
                          _satuanController.text.isEmpty
                              ? _validatehargabeli = true
                              : _validatehargabeli = false;
                          _hargabeliController.text.isEmpty
                              ? _validatehargajual = true
                              : _validatehargajual = false;
                        });
                        if (_validateKode == false &&
                            _validateNama == false &&
                            _validateSatuan == false &&
                            _validatehargabeli == false &&
                            _validatehargajual == false) {
                          _postData();
                          Navigator.pop(context,null);
                        }
                      },
                      child: const Text('Save')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _kodeController.text = '';
                        _namaController.text = '';
                        _satuanController.text = '';
                        _hargabeliController.text = '';
                        _hargajualController.text = '';
                      },
                      child: const Text('Cancel'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}