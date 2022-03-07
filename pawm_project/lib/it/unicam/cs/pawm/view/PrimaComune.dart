import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/DrawerWidget.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/ThreeButtons.dart';

class PrimaComune extends StatelessWidget {
  PrimaComune({Key? key}) : super(key: key);

  var _buttonText = [
    "Prima scheda Comune",
    "Prima scheda Privato",
    "Crea contratto"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text("Crea prima Scheda Comune"),
          ),
          body: ThreeButtons(_buttonText)),
    );
  }
}
