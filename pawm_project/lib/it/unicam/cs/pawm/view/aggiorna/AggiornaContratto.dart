import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/ContrattoPrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/widget/DrawerWidget.dart';

class AggiornaContratto extends StatefulWidget {
  const AggiornaContratto({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AggiornaContrattoState();
  }
}

class _AggiornaContrattoState extends State<AggiornaContratto> {
  final SchedaController controller = SchedaController();
  final oreController = TextEditingController();
  final valoreController = TextEditingController();
  final clienteController = TextEditingController();
  bool isChosen = false;
  String oreText = "";
  String valoreText = "";
  String cliente = "";
  List<DropdownMenuItem<String>> clientiItems = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text("Aggiorna Scheda Contratto"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            //height: 400,
            child: _buildPage(),
          )
        ],
      ),
    );
  }

  Widget _buildPage() {
    if (!isChosen) {
      return _buildChoice();
    } else {
      return _buildCorrection();
    }
  }

  Widget _buildCorrection() => Row(
        children: [
          Expanded(
            child: Column(
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
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade700),
                    onPressed: _confermaAggiornamento,
                    child: const Text("Aggiorna Contratto"))
              ],
            ),
          ),
        ],
      );

  Widget _buildChoice() => Row(
    children: [
      Expanded(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            DropdownButton(
                value: cliente,
                items: clientiItems,
                onChanged: (value) =>
                    setState(() => cliente = value.toString())),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _contrattoScelto,
              child: const Text("Seleziona contratto"),
              style:
              ElevatedButton.styleFrom(primary: Colors.green.shade700),
            ),
          ],
        ),
      ),
    ],
  );

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

  void _showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _contrattoScelto() {
    if (controller.listaContratto.isEmpty) {
      _showToast(context, "Nessun contratto, crea un contratto");
    }

    ContrattoPrivato contratto = controller.listaContratto.firstWhere((element) => element.cliente == cliente);

    oreController.text = contratto.oreTotali.toString();
    valoreController.text = contratto.valoreContratto.toString();
    clienteController.text = contratto.cliente;

    setState(() {
      isChosen = true;
    });
  }

  Future<void> _confermaAggiornamento() async {
    await controller.rinnovaContrattoPrivato(cliente, int.parse(oreController.text) , int.parse(valoreController.text));

    _showToast(context, "Contratto Aggiornato");
  }

  void _init() {
    cliente = controller.listaContratto.last.cliente;
    _populateDropdownItem();
  }

  void _populateDropdownItem() {
    for (String element in controller.clientiContratti()) {
      clientiItems.add(DropdownMenuItem<String>(
        value: element,
        child: Text(
          element,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ));
    }
  }
}
