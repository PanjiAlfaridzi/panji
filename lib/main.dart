import 'package:flutter/material.dart';

void main() {
  runApp(TransaksiTokoApp());
}

class TransaksiTokoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Transaksi Toko Komputer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransaksiPage(),
    );
  }
}

class TransaksiPage extends StatefulWidget {
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final List<Map<String, dynamic>> _barang = [
    {"nama": "Laptop", "harga": 25000000, "jumlah": 0},
    {"nama": "Mouse", "harga": 12500000, "jumlah": 0},
    {"nama": "Keyboard", "harga": 150000, "jumlah": 0},
    {"nama": "Monitor", "harga": 5000000, "jumlah": 0},
    {"nama": "Monitor", "harga": 2200000, "jumlah": 0},
  ];

  double _totalBayar = 0.0;
  List<Map<String, dynamic>> _struk = [];

  void _resetTransaksi() {
    setState(() {
      _totalBayar = 0.0;
      _struk.clear();
      for (var item in _barang) {
        item["jumlah"] = 0;
      }
    });
  }

  void _cetakStruk() {
    setState(() {
      _totalBayar = 0.0;
      _struk = _barang.where((item) => item["jumlah"] > 0).map((item) {
        double subtotal = item["harga"] * item["jumlah"];
        _totalBayar += subtotal;
        return {
          "nama": item["nama"],
          "kuantitas": item["jumlah"],
          "subtotal": subtotal,
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
// Set the button color to blue
      fixedSize: Size(150, 20), // Set uniform size for both buttons
      textStyle: TextStyle(fontSize: 16), // Set text style
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi Toko Komputer"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _barang.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5), // Add some spacing
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: ListTile(
                      title: Text(_barang[index]["nama"]),
                      subtitle: Text("Harga: Rp${_barang[index]["harga"]}"),
                      trailing: SizedBox(
                        width: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _barang[index]["jumlah"] =
                                  int.tryParse(value) ?? 0;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "0",
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _resetTransaksi,
                    child: Text("Reset"),
                    style: buttonStyle,
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _cetakStruk,
                    child: Text("Cetak Struk"),
                    style: buttonStyle,
                  ),
                ],
              ),
            ),
            Divider(),
            Text("Struk Transaksi:"),
            Expanded(
              child: ListView.builder(
                itemCount: _struk.length,
                itemBuilder: (context, index) {
                  final item = _struk[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: ListTile(
                      title: Text(item["nama"]),
                      subtitle: Text(
                          "Kuantitas: ${_barang[index]["harga"]} x ${item["kuantitas"]}"),
                      trailing: Text("Subtotal: Rp${item["subtotal"]}"),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(10),
              child: Text(
                "Total Bayar: Rp$_totalBayar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
