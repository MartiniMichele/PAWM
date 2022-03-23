import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/ContrattoPrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaPrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/widget/DrawerWidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class AggiornaSchedePrivatoContratto extends StatefulWidget {
  const AggiornaSchedePrivatoContratto({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AggiornaSchedePrivatoContrattoState();
  }
}

class _AggiornaSchedePrivatoContrattoState
    extends State<AggiornaSchedePrivatoContratto> {
  final SchedaController controller = SchedaController();
  final durataController = TextEditingController();
  final numeroInterventoController = TextEditingController();
  final screenshotController = ScreenshotController();
  final descrizioneController = TextEditingController();
  bool isChosen = false;
  int nIntervento = 0;
  int idContratto = 0;
  File? fileImage;
  String numeroIntervento = "";
  String oreRimanenti = "";
  String dataText = "";
  String oraText = "";
  String durataText = "durata intervento:";
  String numeroInterventoText = "numero intervento:";
  String cliente = "";
  List<DropdownMenuItem<String>> clientiItems = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
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
                Text("durata intervento: ${durataController.text}",
                    style: const TextStyle(fontSize: 18)),
                buildDurata("inserisci durata"),
                const SizedBox(
                  height: 10,
                ),
                buildMultilineText("descrizione"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(numeroIntervento,
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(
                      width: 40,
                    ),
                    Text(oreRimanenti, style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(dataText, style: const TextStyle(fontSize: 18)),
                    const SizedBox(
                      width: 40,
                    ),
                    Text(oraText, style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (fileImage == null) const Text("No image"),
                if (fileImage != null) buildFileImage(),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 40,
                    ),
                    buildImageButton(),
                    const SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade700),
                        onPressed: _confermaAggiornamento,
                        child: const Text("Crea Scheda")),
                  ],
                ),
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
                buildNumeroIntervento("numero intervento"),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: _schedaScelta,
                  child: const Text("Seleziona scheda"),
                  style:
                      ElevatedButton.styleFrom(primary: Colors.green.shade700),
                ),
              ],
            ),
          ),
        ],
      );

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

  Widget buildNumeroIntervento(String text) => Expanded(
          child: TextField(
        controller: numeroInterventoController,
        decoration: InputDecoration(
          hintText: text,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => setState(() {
          numeroInterventoText = " ${numeroInterventoController.text}";
        }),
      ));

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

  Widget buildImageButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
        child: const Text("Scegli immagine"),
        onPressed: () async {
          final picker = ImagePicker();
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);

          if (pickedFile == null) {
            return;
          }

          final file = File(pickedFile.path);
          setState(() {
            fileImage = file;
          });
        },
      );

  Widget buildFileImage() => Image.file(
        fileImage!,
        height: 200,
        fit: BoxFit.cover,
      );

  Future<void> saveImage(Uint8List bytes) async {
    if (await _requestPermission(Permission.storage)) {
      await ImageGallerySaver.saveImage(bytes,
          name: "Mit_Contratto_${cliente}_Aggiornato_$nIntervento");
    } else {
      return;
    }
    await [Permission.storage].request();
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  void _showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _schedaScelta() {
    if (controller.listaContratto.isEmpty) {
      _showToast(context, "Nessun contratto, crea un contratto");
    }

    nIntervento = int.parse(numeroInterventoController.text);
    ContrattoPrivato contratto = controller.listaContratto
        .firstWhere((element) => element.cliente == cliente);
    SchedaPrivato scheda = contratto.listaSchede
        .firstWhere((element) => element.numeroScheda == nIntervento);

    idContratto = contratto.id;
    durataController.text = "${scheda.durataIntervento}";
    descrizioneController.text = scheda.descrizione;

    dataText = "data: ${scheda.data}";
    oraText = "ora: ${scheda.orario}";

    setState(() {
      isChosen = true;
    });
  }

  Future<void> _confermaAggiornamento() async {
    await controller.correggiSchedaPrivatoContratto(nIntervento, idContratto,
        int.parse(durataController.text), descrizioneController.text);

    setState(() {
      numeroIntervento = "N.Intervento: " + nIntervento.toString();
      oreRimanenti = "ore Rimanenti: " +
          controller.listaContratto
              .firstWhere((element) => element.id == idContratto)
              .oreRimanenti
              .toString();
    });

    final image = await screenshotController.capture();
    await saveImage(image!);

    _showToast(context, "Scheda Aggiornata");
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
