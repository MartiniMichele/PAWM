

import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaPrivato.dart';

const String tableContrattoPrivato = "Contratto_Privato";

class ContrattoPrivato {

  final int id;
  late int oreTotali;
  late int oreRimanenti;
  late int valoreContratto;
  late String cliente;
  late List<SchedaPrivato> listaSchede = <SchedaPrivato>[];

  ContrattoPrivato(
      this.id,
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
}

class ContrattoPrivatoFields {
  static const String id = "_id";
  static const String oreTotali = "oreTotali";
  static const String oreRimanenti = "oreRimanenti";
  static const String valoreContratto = "valore";
  static const String cliente = "cliente";
}