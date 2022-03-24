
import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaPrivato.dart';

class VisualizzaSchedePrivatoContratto extends StatelessWidget {
  VisualizzaSchedePrivatoContratto(this.schede, {Key? key}) : super(key: key);

  List<SchedaPrivato> schede = [];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final SchedaPrivato item = schede[index];
          return ListTile(
              title: Text(
                  "NUMERO INTERVENTO: ${item.numeroScheda}, \n"
                      "DURATA: ${item.durataIntervento}, \n"
                      "CLIENTE (Contratto): ${item.cliente}, \n"
                      "DATA: ${item.data}"));
        },
        separatorBuilder: (context, index) =>
        const Divider(
          color: Colors.black,
        ),
        itemCount: schede.length);
  }
}