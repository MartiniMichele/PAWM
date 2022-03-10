import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/database/dbManager.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/DrawerWidget.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/CreaSchedaComune.dart';

///Widget contenente la base della prima pagina
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _MainPageHome());
  }
}

///Widget personalizzato della pagina iniziale
class _MainPageHome extends StatelessWidget {

  _MainPageHome({Key? key}) : super(key: key);
  SchedaController controller = SchedaController();

  @override
  Widget build(BuildContext context) {
    var _buttonText = [
      "Scheda Comune",
      "Scheda Privato",
      "Scheda per Contratto"
    ];

    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Home'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreaSchedeComune())),
                controller.inizializzaComune()
                },
                child: Text(_buttonText.first),
                style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
              ),
              const SizedBox(
                height: 50,
              ),
              //metodo senza parentesi perché è un riferimento ad esso
              ElevatedButton(
                onPressed: () => {
                  controller.leggiContrattoComune(),
                  print(controller.contrattoComune)
                },
                child: Text(_buttonText[1]),
                style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () => {
                  controller.creaSchedaComune(10, "ufficio", "data", "orario", "descrizione"),
                  controller.aggiornaContrattoComune()
                },
                child: Text(_buttonText.last),
                style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
              )
            ],
          ),
        ));
  }
}
