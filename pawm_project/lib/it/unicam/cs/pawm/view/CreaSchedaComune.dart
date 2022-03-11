import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/DrawerWidget.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/CreaSchedaPrivato.dart';

class CreaSchedeComune extends StatefulWidget {
  const CreaSchedeComune({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreaSchedaComuneWidgetState();
  }
}

class _CreaSchedaComuneWidgetState extends State<CreaSchedeComune> {
  final SchedaController controller = SchedaController();
  final durataController = TextEditingController();
  DateTime data = DateTime.now();

  //final textController = TextEditingController();
  final descrizioneController = TextEditingController();
  String durataText = "durata intervento:";
  String ufficio = "Urbanistica";
  final uffici = [
    "Ragioneria",
    "Tributi",
    "Ufficio Tecnico",
    "Urbanistica",
    "Affari Generali",
    "Anagrafe",
    "Vigili",
    "Servizi Sociali",
    " Protezione Civile"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text("Scheda Comune"),
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
          DropdownButton(
              value: ufficio,
              items: uffici.map(buildDropDown).toList(),
              onChanged: (value) => setState(() => ufficio = value.toString())),
          const SizedBox(
            height: 10,
          ),
          buildMultilineText("descrizione"),
          Text(" ${descrizioneController.text}"),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
              onPressed: confermaCreazione,
              child: const Text("Crea Scheda")),
        ],
      ),
    );
  }

  Widget buildDurata(String text) => TextField(
        controller: durataController,
        decoration: InputDecoration(
          hintText: text,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => setState(() {
          durataText = " ${durataController.text}";
        }),
      );

  Widget buildMultilineText(String text) => TextField(
        autocorrect: true,
        controller: descrizioneController,
        decoration: InputDecoration(
          labelText: text,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      );

/*
  Widget buildText(String text) => TextField(
        autocorrect: true,
        controller: textController,
        decoration: InputDecoration(
          labelText: text,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      );
      */

  DropdownMenuItem<String> buildDropDown(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  Future<void> confermaCreazione() async {
    await controller.creaSchedaComune(
        int.parse(durataController.text),
        ufficio,
        "${data.day}/${data.month}/${data.year}",
        "${data.hour}:${data.minute}",
        descrizioneController.text);
  }
}
