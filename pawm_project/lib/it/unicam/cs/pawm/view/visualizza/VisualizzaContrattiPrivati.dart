import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/ContrattoPrivato.dart';

class VisualizzaContrattiPrivati extends StatelessWidget {
  VisualizzaContrattiPrivati(this.contratti, {Key? key}) : super(key: key);

  List<ContrattoPrivato> contratti;

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
                itemBuilder: (context, index) {
                  final ContrattoPrivato item = contratti[index];
                  return ListTile(
                      title: Text(
                          "CLIENTE: ${item.cliente}, \n"
                              "ORE TOTALI: ${item.oreTotali}, \n"
                              "ORE RIMANENTI: ${item.oreRimanenti}, \n"
                              "VALORE: ${item.valoreContratto}"));
                },
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.black,
                    ),
                itemCount: contratti.length);
  }
}
