import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:storeit/oop_pillars/abstract_color.dart';
import 'package:storeit/pages/dashboard.dart';

class DelProduct extends StatefulWidget {
  const DelProduct({Key? key}) : super(key: key);

  @override
  State<DelProduct> createState() => _DelProductState();
}

class _DelProductState extends State<DelProduct> {
  final StreamController<List> _streamController = StreamController();
  late Timer _timer;

  List<Map<String, dynamic>> selectedItems = [];

  Future _listProduct() async {
    var response = await http.get(Uri.parse(
        "https://dontdreamitsover.000webhostapp.com/productdata.php"));
    var data = jsonDecode(response.body);

    _streamController.add(data);
  }

  Future<void> _deleteItem(String id) async {
    var url = "https://dontdreamitsover.000webhostapp.com/deleteproduct.php";
    var response = await http.post(Uri.parse(url), body: {
      "id": id,
    });

    var data = json.decode(response.body);

    if (data == "success") {
    } else {}
  }

  @override
  void initState() {
    _listProduct();

    _timer =
        Timer.periodic(const Duration(seconds: 5), (timer) => _listProduct());
    super.initState();
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Dashboard()));
            },
            icon: const Icon(Icons.arrow_back_sharp)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        centerTitle: true,
        elevation: 2,
        backgroundColor: PrimaryColor().getColor(),
        title: Text(
          "Product List",
          style: TextStyle(
              color: AccentColor().getColor(), fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: BgColor().getColor(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(4),
        child: StreamBuilder<List>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: (snapshot.data)?.map<Widget>((data) {
                      return ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Remove Product'),
                                content: const Text(
                                    'Are you sure you want to remove this item?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('No'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      _deleteItem(data['id']);
                                      Navigator.of(context)
                                          .pop(); // Tutup dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        title: Text(
                          data["name"],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          "ID : ${data["id"]}\nStock : ${data["stock"]}",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        trailing: const Icon(Icons.delete),
                      );
                    }).toList() ??
                    [],
              );
            }
            return const Text("Loading...");
          },
        ),
      ),
    );
  }
}
