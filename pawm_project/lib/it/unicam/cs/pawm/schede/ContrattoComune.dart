import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaComune.dart';

const String tableContrattoComune = "Contratto_Comune";

class ContrattoComune {
  final int id;
  late int oreTotali;
  late int oreRimanenti;
  late int valoreContratto;
  late List<SchedaComune> listaSchede = <SchedaComune>[];

  ContrattoComune({required this.id, required this.oreTotali, required this.oreRimanenti, required this.valoreContratto});

  Map<String, dynamic> toMap() {
    return {
      ContrattoComuneFields.id : id,
      ContrattoComuneFields.oreTotali : oreTotali,
      ContrattoComuneFields.oreRimanenti : oreRimanenti,
      ContrattoComuneFields.valoreContratto : valoreContratto,
    };
  }

  static ContrattoComune fromMap(Map<String, dynamic> map) {
    return ContrattoComune(
      id: map[ContrattoComuneFields.id] as int,
      oreTotali: map[ContrattoComuneFields.oreTotali] as int,
      oreRimanenti: map[ContrattoComuneFields.oreRimanenti] as int,
      valoreContratto: map[ContrattoComuneFields.valoreContratto] as int,
    );
  }

  @override
  String toString() {
    return 'ContrattoComune{oreTotali: $oreTotali, '
        'oreRimanenti: $oreRimanenti, '
        'valoreContratto: $valoreContratto, '
        'listaSchede: $listaSchede}';
  }
}

class ContrattoComuneFields {
  static const String id = "_id";
  static const String oreTotali = "oreTotali";
  static const String oreRimanenti = "oreRimanenti";
  static const String valoreContratto = "valore";
}
