import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/DrawerWidget.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/ThreeButtons.dart';

class PrimaComune extends StatelessWidget {
  PrimaComune({Key? key}) : super(key: key);

  var _buttonText = [
    "Contratto Comune",
    "Contratto Privato",
    "Home"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text("Inizializza contratti"),
          ),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PrimaComune()))},
                  child: Text(_buttonText.first),
                  style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
                ),
                const SizedBox(
                  height: 50,
                ),
                //metodo senza parentesi perché è un riferimento ad esso
                ElevatedButton(
                  onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PrimaComune()))},
                  child: Text(_buttonText[1]),
                  style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )),
    );
  }
}
