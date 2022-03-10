
const String tableComune = "Schede_Comune";

class SchedaComune {

  final int numeroIntervento;
  late final int idContratto;
  late int durata;
  late String ufficio;
  late String data;
  late String orario;
  late String descrizione;

  SchedaComune({
    required this.numeroIntervento,
    required this.idContratto,
    required this.durata,
    required this.ufficio,
    required this.data,
    required this.orario,
    required this.descrizione,});

  Map<String, dynamic> toMap() {
    return {
      SchedaComuneFields.numeroScheda : numeroIntervento,
      SchedaComuneFields.idContratto : idContratto,
      SchedaComuneFields.durata : durata,
      SchedaComuneFields.ufficio : ufficio,
      SchedaComuneFields.data : data,
      SchedaComuneFields.orario : orario,
      SchedaComuneFields.descrizione : descrizione,
    };
  }

  static SchedaComune fromMap(Map<String, dynamic> map) {
    return SchedaComune(
      numeroIntervento: map[SchedaComuneFields.numeroScheda] as int,
      idContratto: map[SchedaComuneFields.idContratto] as int,
      durata: map[SchedaComuneFields.durata] as int,
      ufficio: map[SchedaComuneFields.ufficio] as String,
      data: map[SchedaComuneFields.data] as String,
      orario: map[SchedaComuneFields.orario] as String,
      descrizione: map[SchedaComuneFields.descrizione] as String,
    );
  }

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