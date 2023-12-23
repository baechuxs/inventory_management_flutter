import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:storeit/oop_pillars/abstract_color.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  final StreamController<List> _streamController = StreamController();
  late Timer _timer;

  Future _listProduct() async {
    var response = await http.get(Uri.parse(
        "https://solongandgoodnight.000webhostapp.com/productdata.php"));
    var data = jsonDecode(response.body);

    _streamController.add(data);
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
        automaticallyImplyLeading: false,
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
                children: snapshot.data?.map((data) {
                      return Card(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                            data["name"],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ID : ${data["id"]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              Text("Stock : ${data["stock"]}"),
                            ],
                          ),
                          trailing: Text(
                            "Rp${data["price"]},00",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black45),
                          ),
                        ),
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
