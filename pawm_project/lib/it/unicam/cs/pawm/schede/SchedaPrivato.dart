

 const String tablePrivato = "Schede_Privato";
 const String tablePrivatoContratto = "Schede_Contratto_Privato";

class SchedaPrivato{

  final int numeroScheda;
  late final int idContratto;
  late int durataIntervento;
  late String data;
  late String orario;
  late String descrizione;
  late String cliente;

  SchedaPrivato({
    required this.numeroScheda,
    required this.idContratto,
    required this.durataIntervento,
    required this.data,
    required this.orario,
    required this.descrizione,
    required this.cliente});

  @override
  String toString() {
    return
        'SchedaPrivato{numeroScheda: $numeroScheda, '
        'durataIntervento: $durataIntervento, '
        'data: $data, '
        'orario: $orario, '
        'descrizione: $descrizione, '
        'cliente: $cliente}';
  }

  Map<String, dynamic> toMap() {
    return {
      SchedaPrivatoFields.numeroScheda : numeroScheda,
      SchedaPrivatoFields.idContratto : idContratto,
      SchedaPrivatoFields.durata : durataIntervento,
      SchedaPrivatoFields.data : data,
      SchedaPrivatoFields.orario : orario,
      SchedaPrivatoFields.descrizione : descrizione,
      SchedaPrivatoFields.cliente : cliente,
    };
  }

  static SchedaPrivato fromMap(Map<String, dynamic> map) {
    return SchedaPrivato(
      numeroScheda: map[SchedaPrivatoFields.numeroScheda] as int,
      idContratto: map[SchedaPrivatoFields.idContratto] as int,
      durataIntervento: map[SchedaPrivatoFields.durata] as int,
      data: map[SchedaPrivatoFields.data] as String,
      orario: map[SchedaPrivatoFields.orario] as String,
      descrizione: map[SchedaPrivatoFields.descrizione] as String,
      cliente: map[SchedaPrivatoFields.cliente] as String,
    );
  }

}

class SchedaPrivatoFields {
  static const String numeroScheda = "_numeroScheda";
  static const String idContratto = "_idContratto";
  static const String durata = "durata";
  static const String data = "data";
  static const String orario = "orario";
  static const String descrizione = "descrizione";
  static const String cliente = "cliente";
}