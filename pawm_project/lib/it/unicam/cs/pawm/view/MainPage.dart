import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/DrawerWidget.dart';
import 'package:pawm_project/it/unicam/cs/pawm/view/ThreeButtons.dart';

///Widget contenente la base della prima pagina
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: _MainPageHome());
  }
}

///Widget personalizzato della pagina iniziale
class _MainPageHome extends StatelessWidget {
  const _MainPageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _buttonText = [
      "Scheda Comune",
      "Scheda Privato",
      "Scheda per Contratto"
    ];

    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Home'),
        ),
        body: ThreeButtons(_buttonText));
  }
}
