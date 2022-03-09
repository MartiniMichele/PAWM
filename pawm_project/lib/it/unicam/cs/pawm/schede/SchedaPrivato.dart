

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
  SchedaPrivato(
      this.numeroScheda,
      this.durataIntervento,
      this.data,
      this.orario,
      this.descrizione,
      this.cliente);

  SchedaPrivato.contratto(
      this.numeroScheda,
      this.idContratto,
      this.durataIntervento,
      this.data,
      this.orario,
      this.descrizione,
      this.cliente);

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