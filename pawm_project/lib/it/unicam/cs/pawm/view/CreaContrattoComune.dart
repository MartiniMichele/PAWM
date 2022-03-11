import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/DrawerWidget.dart';

class CreaContrattoComune extends StatefulWidget {
  const CreaContrattoComune({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreaContrattoComuneState();
  }
}

class _CreaContrattoComuneState extends State<CreaContrattoComune> {
  final SchedaController controller = SchedaController();
  final oreController = TextEditingController();
  final valoreController = TextEditingController();
  DateTime data = DateTime.now();
  String oreText = "";
  String valoreText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: const Text("Contratto Comune"),
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

  confermaCreazione() {
    controller.creaContrattoComune(
        int.parse(oreController.text), int.parse(valoreController.text));
  }
}
