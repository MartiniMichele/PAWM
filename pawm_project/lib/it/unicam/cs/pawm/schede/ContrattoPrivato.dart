

import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaPrivato.dart';

class ContrattoPrivato {

  late int oreTotali;
  late int oreRimanenti;
  late int valoreContratto;
  late String cliente;
  late List<SchedaPrivato> listaSchede = <SchedaPrivato>[];

  ContrattoPrivato(
      this.oreTotali,
      this.oreRimanenti,
      this.valoreContratto,
      this.cliente);

  @override
  String toString() {
    return 'ContrattoPrivato{oreTotali: $oreTotali, '
        'oreRimanenti: $oreRimanenti, '
        'valoreContratto: $valoreContratto, '
        'cliente: $cliente, '
        'listaSchede: $listaSchede}';
  }

//int get oreTotali => _oreTotali;
}