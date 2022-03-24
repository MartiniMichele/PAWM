import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/ContrattoPrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaPrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/visualizza/VisualizzaContrattiPrivati.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/visualizza/VisualizzaContrattoComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/visualizza/VisualizzaSchedeComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/visualizza/VisualizzaSchedePrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/visualizza/VisualizzaSchedePrivatoContratto.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/widget/DrawerWidget.dart';

class MainPageVisualizza extends StatefulWidget {
  const MainPageVisualizza({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainPageVisualizzaState();
  }
}

class _MainPageVisualizzaState extends State<MainPageVisualizza> {
  static SchedaController controller = SchedaController();
  int index = 0;
  final screens = [
    VisualizzaContrattoComune(),
    VisualizzaContrattiPrivati(controller.listaContratto),
    VisualizzaSchedeComune(controller.contrattoComune.listaSchede),
    VisualizzaSchedePrivato(controller.listaPrivato),
    VisualizzaSchedePrivatoContratto(controller.schedeContratti())
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: _buildNavigationBar(),
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text("Visualizza Dati"),
        backgroundColor: Colors.green,
      ),
      body: screens[index],
    );
  }

  Widget _buildNavigationBar() => NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Colors.green,
            backgroundColor: Colors.grey.shade300),
        child: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (index) => setState(() {
                  this.index = index;
                }),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.ad_units), label: "C. Comune"),
              NavigationDestination(
                  icon: Icon(Icons.amp_stories), label: "C. Privati"),
              NavigationDestination(icon: Icon(Icons.web), label: "S. Comune"),
              NavigationDestination(
                  icon: Icon(Icons.article), label: "S. Privato"),
              NavigationDestination(
                  icon: Icon(Icons.wysiwyg), label: "S. Contratto"),
            ]),
      );
}
