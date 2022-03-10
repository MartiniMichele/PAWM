

import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaPrivato.dart';

const String tableContrattoPrivato = "Contratto_Privato";

class ContrattoPrivato {

  final int id;
  late int oreTotali;
  late int oreRimanenti;
  late int valoreContratto;
  late String cliente;
  late List<SchedaPrivato> listaSchede = <SchedaPrivato>[];

  ContrattoPrivato({
    required this.id,
    required this.oreTotali,
    required this.oreRimanenti,
    required this.valoreContratto,
    required this.cliente});

  @override
  String toString() {
    return 'ContrattoPrivato{oreTotali: $oreTotali, '
        'oreRimanenti: $oreRimanenti, '
        'valoreContratto: $valoreContratto, '
        'cliente: $cliente, '
        'listaSchede: $listaSchede}';
  }

  Map<String, dynamic> toMap() {
    return {
      ContrattoPrivatoFields.id : id,
      ContrattoPrivatoFields.oreTotali : oreTotali,
      ContrattoPrivatoFields.oreRimanenti : oreRimanenti,
      ContrattoPrivatoFields.valoreContratto : valoreContratto,
      ContrattoPrivatoFields.cliente : cliente
    };
  }

  static ContrattoPrivato fromMap(Map<String, dynamic> map) {
    return ContrattoPrivato(
      id: map[ContrattoPrivatoFields.id] as int,
      oreTotali: map[ContrattoPrivatoFields.oreTotali] as int,
      oreRimanenti: map[ContrattoPrivatoFields.oreRimanenti] as int,
      valoreContratto: map[ContrattoPrivatoFields.valoreContratto] as int,
      cliente: map[ContrattoPrivatoFields.cliente] as String,
    );
  }

}

class ContrattoPrivatoFields {
  static const String id = "_id";
  static const String oreTotali = "oreTotali";
  static const String oreRimanenti = "oreRimanenti";
  static const String valoreContratto = "valore";
  static const String cliente = "cliente";
}