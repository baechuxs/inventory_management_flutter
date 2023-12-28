import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:storeit/oop_pillars/abstract_color.dart';
import 'package:storeit/oop_pillars/abstract_icon.dart';

class InfoProduct extends StatefulWidget {
  const InfoProduct({super.key});

  @override
  State<InfoProduct> createState() => _InfoProductState();
}

class _InfoProductState extends State<InfoProduct> {
  final StreamController<List> _streamController = StreamController();
  late Timer _timer;

  Future _infoProduct() async {
    var response = await http.get(Uri.parse(
        "https://dontdreamitsover.000webhostapp.com/productcount.php"));
    var data = jsonDecode(response.body);

    _streamController.add(data);
  }

  @override
  void initState() {
    _infoProduct();

    _timer =
        Timer.periodic(const Duration(seconds: 5), (timer) => _infoProduct());
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
      backgroundColor: BgColor().getColor(),
      body: Container(
        width: 650,
        height: 500,
        padding: const EdgeInsets.all(5),
        child: StreamBuilder<List>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: snapshot.data?.map((data) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: PrimaryColor().getColor(),
                          elevation: 2,
                          child: ListTile(
                              leading: Icon(
                                TotalProduct().getIcon(),
                                color: AccentColor().getColor(),
                              ),
                              title: Text(
                                "Total Product in Inventory: ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AccentColor().getColor()),
                              ),
                              trailing: Text(
                                data["count(id)"] ?? '0',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: PrimaryColor().getColor(),
                          elevation: 2,
                          child: ListTile(
                              leading: Icon(
                                TotalStock().getIcon(),
                                color: AccentColor().getColor(),
                              ),
                              title: Text(
                                "Total Stock in Inventory: ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AccentColor().getColor()),
                              ),
                              trailing: Text(
                                data["sum(stock)"] ?? '0',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: PrimaryColor().getColor(),
                          elevation: 2,
                          child: ListTile(
                              leading: Icon(
                                ProductValue().getIcon(),
                                color: AccentColor().getColor(),
                              ),
                              title: Text(
                                "Total Product Value: ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AccentColor().getColor()),
                              ),
                              trailing: Text(
                                "Rp${data["sum(price)"] ?? '0'},00",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: PrimaryColor().getColor(),
                          elevation: 2,
                          child: ListTile(
                              leading: Icon(
                                StockValue().getIcon(),
                                color: AccentColor().getColor(),
                              ),
                              title: Text(
                                "Total Stock Value: ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AccentColor().getColor()),
                              ),
                              trailing: Text(
                                "Rp${data["sum(stock*price)"] ?? '0'},00",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )),
                        ),
                      ],
                    );
                  }).toList() ??
                  [],
            );
          },
        ),
      ),
    );
  }
}
