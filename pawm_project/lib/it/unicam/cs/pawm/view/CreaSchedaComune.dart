import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/DrawerWidget.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/ThreeButtons.dart';

class CreaSchedeComune extends StatelessWidget {
  CreaSchedeComune({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Crea Scheda Comune"),
        ),
      ),
    );
  }
}
