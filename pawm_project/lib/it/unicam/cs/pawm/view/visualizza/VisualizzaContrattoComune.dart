
import 'package:flutter/material.dart';
import 'package:pawm_project/it/unicam/cs/pawm/controller/SchedeController.dart';

class VisualizzaContrattoComune extends StatelessWidget {

  VisualizzaContrattoComune({Key? key}) : super(key: key);

  SchedaController controller = SchedaController();


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          "ORE TOTALI: ${controller.contrattoComune.oreTotali},\n"
              "ORE RIMANENTI: ${controller.contrattoComune.oreRimanenti},\n"
              "VALORE: ${controller.contrattoComune.valoreContratto}"),
    );
  }

}






