import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/widget/DrawerWidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

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
  final screenshotController = ScreenshotController();
  final descrizioneController = TextEditingController();
  File? fileImage;
  DateTime data = DateTime.now();
  String numeroIntervento = "";
  String oreRimanenti = "";
  String dataText = "";
  String oraText = "";
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
    "Protezione Civile"
  ];

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
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
                onChanged: (value) =>
                    setState(() => ufficio = value.toString())),
            const SizedBox(
              height: 10,
            ),
            buildMultilineText("descrizione"),
            Row(
              children: [
                Text(numeroIntervento, style: const TextStyle(fontSize: 18)),
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
                    onPressed: confermaCreazione,
                    child: const Text("Crea Scheda")),
              ],
            ),
          ],
        ),
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

    setState(() {
      numeroIntervento = "N.Intervento: " +
          controller.contrattoComune.listaSchede.last.numeroIntervento
              .toString();
      oreRimanenti = "ore Rimanenti: " +
          controller.contrattoComune.oreRimanenti.toString();
      dataText = "data: ${data.day}/${data.month}/${data.year}";
      oraText = "ora: ${data.hour}:${data.minute}";
    });

    final image = await screenshotController.capture();
    await saveImage(image!);

    _showToast(context);
  }

  Future<void> saveImage(Uint8List bytes) async {
    String name =
        controller.contrattoComune.listaSchede.last.numeroIntervento.toString();

    if (await _requestPermission(Permission.storage)) {
      await ImageGallerySaver.saveImage(bytes, name: "Mit_Comune_" + name);
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

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Scheda creata'),
        action: SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
