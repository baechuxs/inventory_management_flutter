import 'package:flutter/material.dart';
import 'package:storeit/pages/dashboard.dart';
import 'package:storeit/widget/headerdrawer.dart';
import 'package:storeit/oop_pillars/abstract_color.dart';
import 'package:storeit/widget/list.dart';
import 'package:storeit/crud/updateproduct.dart';
import 'package:storeit/pages/listpage.dart';
import 'package:storeit/pages/productinpage.dart';
import 'package:storeit/pages/productoutpage.dart';
import 'package:storeit/oop_pillars/abstract_icon.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => UpdatePageState();
}

class UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BgColor().getColor(),
      appBar: AppBar(
        elevation: 3,
        backgroundColor: PrimaryColor().getColor(),
        foregroundColor: AccentColor().getColor(),
        title: const Text(
          "UPDATE",
          style: TextStyle(fontSize: 20),
        ),
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
      body: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 80,
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        children: const <Widget>[
          UpdateProduct(),
          ListProduct(),
        ],
      ),
    );
  }
}
