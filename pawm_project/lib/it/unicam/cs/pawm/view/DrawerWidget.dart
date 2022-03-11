import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/MainPage.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/CreaSchedaComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/MainPageContratti.dart';

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
            child: const DrawerHeader(
                child: Text(
                  "Menu",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(color: Colors.green)),
          ),
          ListTile(
            tileColor: Colors.white,
            title: const Text("Crea Contratti"),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPageContratti()))
            },
          ),
          ListTile(
            tileColor: Colors.white,
            title: const Text("Crea schede"),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MainPage()))
            },
          ),
          ListTile(
            tileColor: Colors.white,
            title: const Text("Visualizza dati"),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPage()))
            },
          )
        ],
      ),
    );
  }
}
