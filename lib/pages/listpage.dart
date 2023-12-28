import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:storeit/pages/dashboard.dart';
import 'package:storeit/widget/headerdrawer.dart';
import 'package:storeit/pages/productinpage.dart';
import 'package:storeit/pages/productoutpage.dart';
import 'package:storeit/pages/productupdatepage.dart';
import 'package:storeit/oop_pillars/abstract_color.dart';
import 'package:storeit/oop_pillars/abstract_icon.dart';
import 'package:storeit/widget/search.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final StreamController<List> _streamController = StreamController();
  late Timer _timer;

  Future _listProduct() async {
    var response = await http.get(Uri.parse(
        "https://dontdreamitsover.000webhostapp.com/productdata.php"));
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
        automaticallyImplyLeading: true,
        elevation: 3,
        backgroundColor: PrimaryColor().getColor(),
        title: Text(
          "Product List",
          style: TextStyle(
              color: AccentColor().getColor(), fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: PrimaryColor().getColor(),
        child: Column(
          children: [
            const Headerdrawer(),
            ListTile(
              hoverColor: Colors.white38,
              leading: Icon(
                IconDashboard().getIcon(),
                color: AccentColor().getColor(),
              ),
              title: Text(
                "Dashboard",
                style: TextStyle(
                    color: AccentColor().getColor(),
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                );
              },
            ),
            ListTile(
              hoverColor: Colors.white38,
              leading:
                  Icon(IconList().getIcon(), color: AccentColor().getColor()),
              title: Text(
                "Product List",
                style: TextStyle(
                    color: AccentColor().getColor(),
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListPage()),
                );
              },
            ),
            ListTile(
              hoverColor: Colors.white38,
              leading:
                  Icon(IconIn().getIcon(), color: AccentColor().getColor()),
              title: Text(
                "Product IN",
                style: TextStyle(
                    color: AccentColor().getColor(),
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InPage()),
                );
              },
            ),
            ListTile(
              hoverColor: Colors.white38,
              leading:
                  Icon(IconOut().getIcon(), color: AccentColor().getColor()),
              title: Text(
                "Product Out",
                style: TextStyle(
                    color: AccentColor().getColor(),
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeletePage()),
                );
              },
            ),
            ListTile(
              hoverColor: Colors.white38,
              leading:
                  Icon(IconUpdate().getIcon(), color: AccentColor().getColor()),
              title: Text(
                "Update Product",
                style: TextStyle(
                    color: AccentColor().getColor(),
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpdatePage()),
                );
              },
            ),
          ],
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
                        color: BgColor().getColor(),
                        elevation: 0,
                        child: ListTile(
                            title: Text(
                              data["name"],
                              style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87),
                            ),
                            subtitle: Text(
                              "ID : ${data["id"]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  "Rp${data["price"]},00",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(221, 104, 101, 101),
                                      fontSize: 18),
                                ),
                                Text(
                                  "Stock : ${data["stock"]}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(221, 104, 101, 101),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            )),
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
