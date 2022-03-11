
import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/DrawerWidget.dart';

class CreaSchedaPrivatoContratto extends StatefulWidget {

  const CreaSchedaPrivatoContratto({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreaSchedaPrivatoContrattoWidgetState();
  }

}

class _CreaSchedaPrivatoContrattoWidgetState extends State<CreaSchedaPrivatoContratto> {
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
        title: const Text("Scheda Privato Contratto"),
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

  DropdownMenuItem<String> buildDropDown(String item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  Future<void> confermaCreazione() async {
    await controller.creaSchedaPerContrattoPrivato(
        int.parse(durataController.text),
        "${data.day}/${data.month}/${data.year}",
        "${data.hour}:${data.minute}",
        descrizioneController.text,
        clienteController.text);
  }
}