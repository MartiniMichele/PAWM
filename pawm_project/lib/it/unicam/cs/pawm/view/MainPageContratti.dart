import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/CreaContrattoComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/CreaContrattoPrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/DrawerWidget.dart';

class MainPageContratti extends StatelessWidget {
  const MainPageContratti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar:
          AppBar(backgroundColor: Colors.green, title: const Text("Home Contratti")),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreaContrattoComune())),
              },
              child: const Text("Crea Contratto Comune"),
              style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreaContrattoPrivato())),
              },
              child: const Text("Crea Contratto Privato"),
              style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
