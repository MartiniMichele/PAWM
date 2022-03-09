
const String tableComune = "Schede_Comune";

class SchedaComune {

  final int numeroIntervento;
  late final int idContratto;
  late int durata;
  late String ufficio;
  late String data;
  late String orario;
  late String descrizione;
  SchedaComune(
      this.numeroIntervento,
      this.idContratto,
      this.durata,
      this.ufficio,
      this.data,
      this.orario,
      this.descrizione,);

  @override
  String toString() {
    return
        'SchedaComune{'
        'numeroIntervento: $numeroIntervento, '
        'numeroOre: $durata, '
        'ufficio: $ufficio, '
        'data: $data, '
        'orario: $orario, '
        'descrizione: $descrizione}';
  }
}

class SchedaComuneFields {
  static const String numeroScheda = "_numeroScheda";
  static const String idContratto = "_idContratto";
  static const String durata = "durata";
  static const String ufficio = "ufficio";
  static const String data = "data";
  static const String orario = "orario";
  static const String descrizione = "descrizione";

}