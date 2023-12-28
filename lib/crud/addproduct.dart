// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:storeit/pages/dashboard.dart';
import 'package:storeit/pages/productinpage.dart';
import 'package:storeit/oop_pillars/abstract_color.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController stock = TextEditingController();

  Future add(BuildContext cont) async {
    if (id.text != "" &&
        name.text != "" &&
        price.text != "" &&
        stock.text != "") {
      var url = "https://dontdreamitsover.000webhostapp.com/addproduct.php";
      var response = await http.post(Uri.parse(url), body: {
        "id": id.text,
        "name": name.text,
        "price": price.text,
        "stock": stock.text,
      });

      var data = json.decode(response.body);

      if (data == "success") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InPage()));
      } else {
        Text("error");
      }
    }
  }

  Widget idProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Input Product ID",
          style: TextStyle(
              color: PrimaryColor().getColor(),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black45, blurRadius: 2, offset: Offset(0, 1))
              ]),
          height: 50,
          width: 450,
          child: TextField(
            controller: id,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.key),
                hintText: "ID",
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget nameProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Input Product Name",
          style: TextStyle(
              color: PrimaryColor().getColor(),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black45, blurRadius: 2, offset: Offset(0, 1))
              ]),
          height: 50,
          width: 450,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: name,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.notes_outlined),
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget priceProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Input Product Price",
          style: TextStyle(
              color: PrimaryColor().getColor(),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black45, blurRadius: 2, offset: Offset(0, 1))
              ]),
          height: 50,
          width: 450,
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: price,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.monetization_on_outlined),
                hintText: "Price",
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget stockProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Input Product Stock",
          style: TextStyle(
              color: PrimaryColor().getColor(),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black45, blurRadius: 2, offset: Offset(0, 1))
              ]),
          height: 50,
          width: 450,
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: stock,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.warehouse_outlined),
                hintText: "Stock",
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget addProduct() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 25),
            backgroundColor: PrimaryColor().getColor(),
            shadowColor: PrimaryColor().getColor(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        onPressed: () {
          add(context);
        },
        child: Text(
          "Add",
          style: TextStyle(
              color: AccentColor().getColor(),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: PrimaryColor().getColor(),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Dashboard()));
            },
            icon: const Icon(Icons.arrow_back_sharp)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: BgColor().getColor(),
        title: Text(
          "PRODUCT IN",
          style: TextStyle(
              color: PrimaryColor().getColor(),
              fontSize: 40,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: BgColor().getColor(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50),
                    idProduct(),
                    SizedBox(height: 10),
                    nameProduct(),
                    SizedBox(height: 10),
                    priceProduct(),
                    SizedBox(height: 10),
                    stockProduct(),
                    SizedBox(height: 30),
                    addProduct(),
                    SizedBox(height: 5),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
