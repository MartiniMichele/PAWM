import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/crea/CreaSchedaPrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/crea/CreaSchedaPrivatoContratto.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/widget/DrawerWidget.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/crea/CreaSchedaComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/widget/ErrorPage.dart';

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
  final SchedaController controller = SchedaController();

  @override
  Widget build(BuildContext context) {
    var _text = [
      "Scheda Comune",
      "Scheda Privato",
      "Scheda per Contratto",
      "Home"
    ];

    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(backgroundColor: Colors.green, title: Text(_text[3])),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreaSchedeComune()));
                  await _initComune(context);
                },
                child: Text(_text[0]),
                style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
              ),
              const SizedBox(
                height: 50,
              ),
              //metodo senza parentesi perché è un riferimento ad esso
              ElevatedButton(
                onPressed: () async {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreaSchedaPrivato()));
                  await _initPrivato(context);
                },
                child: Text(_text[1]),
                style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {

                  await _initPrivatoContratto(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const CreaSchedaPrivatoContratto()));

                },
                child: Text(_text[2]),
                style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
              )
            ],
          ),
        ));
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
  }
}
