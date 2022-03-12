import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/ErrorPage.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/MainPage.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/MainPageContratti.dart';

class MyDrawer extends StatelessWidget {
  final SchedaController controller = SchedaController();

  MyDrawer({Key? key}) : super(key: key);


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
        ],
      ),
    );
  }

  void initComune(context) async {
    try {
      await controller.inizializzaComune();
    } catch (err) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ErrorPage("ERRORE! Devi creare un contratto comune")));
    }
  }

  void initPrivato(context) async {
    if (controller.listaPrivato.isEmpty || controller.listaContratto.isEmpty) {
      try {
        await controller.inizializzaPrivato();
      } catch (err) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ErrorPage("ERRORE!")));
      }
    }
  }
}
