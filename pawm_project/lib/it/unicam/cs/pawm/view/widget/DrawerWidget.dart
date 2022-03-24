import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/MainPageVisualizza.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/widget/ErrorPage.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/MainPage.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/MainPageAggiorna.dart';
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
          ListTile(
            tileColor: Colors.white,
            title: const Text("Aggiorna schede"),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPageAggiorna()))
            },
          ),
          ListTile(
            tileColor: Colors.white,
            title: const Text("Visualizza Dati"),
            onTap: () async {
              await _initComune(context);
              await _initPrivato(context);
              await _initPrivatoContratto(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPageVisualizza()));

              _checkDati(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _initComune(context) async {
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

  Future<void> _initPrivato(context) async {
    if (controller.listaPrivato.isEmpty) {
      try {
        await controller.inizializzaPrivato();
      } catch (err) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ErrorPage("ERRORE!")));
      }
    }
  }

  Future<void> _initPrivatoContratto(context) async {
    if (controller.listaContratto.isEmpty) {
      try {
        await controller.inizializzaPrivatoContratto();
      } catch (err) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ErrorPage("ERRORE!")));
      }
    }
    _checkDati(context);
  }

  void _checkDati(context) {
    if (controller.listaContratto.isEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ErrorPage("ERRORE! Devi creare un contratto privato")));
    }
    if (controller.contrattoComune.id == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ErrorPage("ERRORE! Devi creare un contratto comune")));
    }
  }
}
