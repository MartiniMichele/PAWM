
import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaComune.dart';

class VisualizzaSchedeComune extends StatelessWidget {
  VisualizzaSchedeComune(this.schede, {Key? key}) : super(key: key);

  List<SchedaComune> schede = [];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final SchedaComune item = schede[index];
          return ListTile(
              title: Text(
                  "NUMERO INTERVENTO: ${item.numeroIntervento}, \n"
                      "DURATA: ${item.durata}, \n"
                      "UFFICIO: ${item.ufficio}, \n"
                      "DATA: ${item.data}"));
        },
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
        ),
        itemCount: schede.length);
  }


}