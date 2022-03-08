import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaComune.dart';

class ContrattoComune {
  late int oreTotali;
  late int oreRimanenti;
  late int valoreContratto;
  late List<SchedaComune> listaSchede = <SchedaComune>[];

  ContrattoComune(this.oreTotali, this.oreRimanenti, this.valoreContratto);

  @override
  String toString() {
    return 'ContrattoComune{oreTotali: $oreTotali, '
        'oreRimanenti: $oreRimanenti, '
        'valoreContratto: $valoreContratto, '
        'listaSchede: $listaSchede}';
  }
}
