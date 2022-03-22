import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/DrawerWidget.dart';

class CreaContrattoPrivato extends StatefulWidget {
  const CreaContrattoPrivato({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreaContrattoPrivatoState();
  }
}

class _CreaContrattoPrivatoState extends State<CreaContrattoPrivato> {
  final SchedaController controller = SchedaController();
  final oreController = TextEditingController();
  final valoreController = TextEditingController();
  final clienteController = TextEditingController();
  DateTime data = DateTime.now();
  String oreText = "";
  String valoreText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: const Text("Contratto Privato"),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text("durata contratto: ${oreController.text}",
                style: const TextStyle(fontSize: 18)),
            buildOreTotali("Ore totali contratto: "),
            const SizedBox(
              height: 10,
            ),
            Text("valore contratto: ${valoreController.text}",
                style: const TextStyle(fontSize: 18)),
            buildValore("Valore: "),
            const SizedBox(
              height: 10,
            ),
            buildCliente("Cliente"),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
                onPressed: confermaCreazione,
                child: const Text("Crea Contratto"))
          ],
        ));
  }

  Widget buildOreTotali(String text) => TextField(
        controller: oreController,
        decoration: InputDecoration(
          hintText: text,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => setState(() {
          oreText = " ${oreController.text}";
        }),
      );

  Widget buildValore(String text) => TextField(
        controller: valoreController,
        decoration: InputDecoration(
          hintText: text,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => setState(() {
          valoreText = " ${valoreController.text}";
        }),
      );

  Widget buildCliente(String text) => TextField(
        autocorrect: true,
        controller: clienteController,
        decoration: InputDecoration(
          labelText: text,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      );

  void confermaCreazione() {
    controller.creaContrattoPrivato(int.parse(oreController.text),
        int.parse(valoreController.text), clienteController.text);

    _showToast(context);
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Contratto creato'),
        action: SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
