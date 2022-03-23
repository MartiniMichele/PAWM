import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/aggiorna/AggiornaContratto.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/aggiorna/AggiornaSchedaComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/widget/DrawerWidget.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/widget/ErrorPage.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/aggiorna/AggiornaSchedaPrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/aggiorna/AggiornaSchedaPrivatoContratto.dart';

class MainPageAggiorna extends StatelessWidget {
  MainPageAggiorna({Key? key}) : super(key: key);
  final SchedaController controller = SchedaController();

  @override
  Widget build(BuildContext context) {
    var _text = [
      "Aggiorna Scheda Comune",
      "Aggiorna Scheda Privato",
      "Aggiorna Scheda per Contratto",
      "Rinnova Contratto",
      "Aggiorna"
    ];

    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(backgroundColor: Colors.green, title: Text(_text[4])),
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
                          builder: (context) => const AggiornaSchedaComune()));
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
                          builder: (context) => const AggiornaSchedaPrivato()));
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
                              const AggiornaSchedePrivatoContratto()));
                },
                child: Text(_text[2]),
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
                          builder: (context) => const AggiornaContratto()));
                },
                child: Text(_text[3]),
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
    print(controller.listaContratto);
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
