import './TipoSchede.dart';

class SchedaComune {

  late int numeroIntervento;
  late int numeroOre;
  late String ufficio;
  late String data;
  late String orario;
  late String descrizione;
  final String tipo = "COMUNE";

  SchedaComune(
      this.numeroIntervento,
      this.numeroOre,
      this.ufficio,
      this.data,
      this.orario,
      this.descrizione,);

  @override
  String toString() {
    return
        'SchedaComune{'
        'numeroIntervento: $numeroIntervento, '
        'numeroOre: $numeroOre, '
        'ufficio: $ufficio, '
        'data: $data, '
        'orario: $orario, '
        'descrizione: $descrizione, '
        'tipo: $tipo}';
  }

}