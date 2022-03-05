import './TipoSchede.dart';

class SchedaComune {

  late int numeroIntervento;
  late int numeroOre;
  late String ufficio;
  late String data;
  late String orario;
  late String descrizione;
  late TipoSchede tipo;

  SchedaComune(
      this.numeroIntervento,
      this.numeroOre,
      this.ufficio,
      this.data,
      this.orario,
      this.descrizione,)
  {
    tipo = TipoSchede.COMUNE;
  }

  @override
  String toString() {
    return 'SchedaComune{numeroIntervento: $numeroIntervento, '
        'numeroOre: $numeroOre, '
        'ufficio: $ufficio, '
        'data: $data, '
        'orario: $orario, '
        'descrizione: $descrizione, '
        'tipo: $tipo}';
  }
}