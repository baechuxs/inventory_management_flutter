// ignore_for_file: library_private_types_in_public_api, prefer_final_fields
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:storeit/oop_pillars/abstract_color.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final StreamController<List> _streamController = StreamController();
  late Timer _timer;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _listProduct();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _listProduct();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  Future<void> _listProduct() async {
    var response = await http.get(Uri.parse(
        "https://solongandgoodnight.000webhostapp.com/productdata.php"));
    var data = jsonDecode(response.body);

    _streamController.add(data);
  }

  void _performSearch(String query) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: PrimaryColor().getColor(),
        foregroundColor: AccentColor().getColor(),
        title: TextField(
          controller: _searchController,
          style: const TextStyle(
              color:
                  Colors.white), // Ubah warna teks yang diketik menjadi putih
          decoration: const InputDecoration(
            hintText: 'Search by Name or ID',
            hintStyle: TextStyle(
                color: Colors.white), // Ubah warna teks hint menjadi putih
            border: InputBorder.none,
          ),
          onChanged: (value) {
            _performSearch(value);
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(4),
        child: StreamBuilder<List>(
          stream: _streamController.stream,
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              List filteredData = snapshot.data!
                  .where((data) =>
                      (data['name'] as String)
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()) ||
                      (data['id'] as String)
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()))
                  .toList();

              return ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(filteredData[index]["name"]),
                      subtitle: Text("ID : ${filteredData[index]["id"]}"),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text("Loading..."));
          },
        ),
      ),
    );
  }
}
