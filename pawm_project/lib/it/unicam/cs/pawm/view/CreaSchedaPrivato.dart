import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/DrawerWidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

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
  final screenshotController = ScreenshotController();
  File? fileImage;
  DateTime data = DateTime.now();
  String durataText = "";
  String numeroIntervento = "";
  String dataText = "";
  String oraText = "";

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        drawer: MyDrawer(),
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
            const SizedBox(
              height: 10,
            ),
            buildCliente("Cliente"),
            Row(
              children: [
                Text(numeroIntervento, style: const TextStyle(fontSize: 18)),
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
            )
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

  void confermaCreazione() async {
    controller.creaSchedaPrivato(
        int.parse(durataController.text),
        "${data.day}/${data.month}/${data.year}",
        "${data.hour}:${data.minute}",
        descrizioneController.text,
        clienteController.text);
    setState(() {
      numeroIntervento = "N.Intervento: " +
          controller.listaPrivato.last.numeroScheda.toString();
      dataText = "data: ${data.day}/${data.month}/${data.year}";
      oraText = "ora: ${data.hour}:${data.minute}";
    });

    final image = await screenshotController.capture();
    await saveImage(image!);
  }

  Future<void> saveImage(Uint8List bytes) async {
    String name = controller.listaPrivato.last.numeroScheda.toString();

    if (await _requestPermission(Permission.storage)) {
      await ImageGallerySaver.saveImage(bytes, name: "Mit_Privato_" + name);
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
}
