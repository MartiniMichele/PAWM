import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/MainPage.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/PrimaComune.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 80,
            child: DrawerHeader(
                child: Text(
                  "Menu",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(color: Colors.green)),
          ),
          ListTile(
            tileColor: Colors.white,
            title: const Text("Crea prime schede"),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrimaComune()))
            },
          ),
          ListTile(
            tileColor: Colors.white,
            title: const Text("Crea schede"),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPage()))
            },
          ),
          ListTile(
            tileColor: Colors.white,
            title: const Text("Visualizza dati"),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrimaComune()))
            },
          )
        ],
      ),
    );
  }
}
