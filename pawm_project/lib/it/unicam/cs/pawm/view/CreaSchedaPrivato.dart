import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/DrawerWidget.dart';

class CreaSchedaPrivato extends StatefulWidget {
  const CreaSchedaPrivato({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _CreaSchedaPrivatoWidgetState();
    }
  }

class _CreaSchedaPrivatoWidgetState extends State<CreaSchedaPrivato> {
  final SchedaController controller = SchedaController();
  final durataController = TextEditingController();
  final clienteController = TextEditingController();
  final descrizioneController = TextEditingController();
  DateTime data = DateTime.now();
  String durataText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("Scheda Privato"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text("durata intervento: ${durataController.text}",
              style: const TextStyle(fontSize: 18)),
          buildDurata("inserisci durata"),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          buildMultilineText("descrizione"),
          Text(" ${descrizioneController.text}"),
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
              child: const Text("Crea Scheda"))
        ],
      ),
    );
  }

  Widget buildDurata(String text) =>
      TextField(
        controller: durataController,
        decoration: InputDecoration(
          hintText: text,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) =>
            setState(() {
              durataText = " ${durataController.text}";
            }),
      );

  Widget buildMultilineText(String text) =>
      TextField(
        autocorrect: true,
        controller: descrizioneController,
        decoration: InputDecoration(
          labelText: text,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      );

  Widget buildCliente(String text) =>
      TextField(
        autocorrect: true,
        controller: clienteController,
        decoration: InputDecoration(
          labelText: text,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      );


  Future<void> confermaCreazione() async {
    controller.creaSchedaPrivato(
        int.parse(durataController.text),
        "${data.day}/${data.month}/${data.year}",
        "${data.hour}",
        descrizioneController.text,
        clienteController.text);
  }
}
